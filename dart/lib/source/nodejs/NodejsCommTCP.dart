library webrtc.nodejs.comm;

import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:uuid/uuid.dart';


class NodeJsCommTCP{
  static var remoteHost = "127.0.0.1";
  static var remotePort = 6600;


  static NodeJsCommTCP nodejsComm = null;

  factory NodeJsCommTCP(){
    if(nodejsComm == null)
      nodejsComm = new NodeJsCommTCP._internal(remoteHost, remotePort);

    if(nodejsComm != null)
      return nodejsComm;
  }


  Socket _socket = null;
  String _host;
  int _port;
  int _listeningPort;

  Map _objectEvents = new Map();
  Map _callbacks = new Map();
  Completer<NodeJsCommTCP> _ctrlReady = new Completer<NodeJsCommTCP>();
  Future<NodeJsCommTCP> get onReady => _ctrlReady.future;

  NodeJsCommTCP._internal(this._host, this._port){
    Socket.connect(_host, _port).then((Socket s){
      _socket = s;
      print("TCP socket connected");
      _ctrlReady.complete(this);
      s.listen((data) => _onData(s, data));
    });
  }

  void _onData(Socket s, data) {
    String smsg = new String.fromCharCodes(data);
    for (String splittedMsg in smsg.split('\n\n')) {
      if(splittedMsg.length == 0) continue;
      //print("Socket received ${splittedMsg}");
      try {
        var msg = JSON.decode(splittedMsg);

        _dispatchMessage(msg);


      } catch (exception, stackTrace) {
        print("error: ${exception} ${stackTrace}");
      }
    }
  }

  void _send(data){
    //print("Sending ${data}");
    _socket.write(data + '\n\n');
  }

  Future callMethod(String objectId, String method, List<String> arguments){
    String callId = new Uuid().v4();
    var data = JSON.encode(
        {'type' : 'callMethod',
        'callId' : callId,
        'objectId' : objectId,
        'method': method,
        'args': arguments}
    );
    Completer c = new Completer();
    _registerCallback(callId, (results){
      c.complete(results);
    });

    _send(data);

    return c.future;
  }

  Future createObject(String objectId, String type, List<String> arguments){
    String callId = new Uuid().v4();
    var data = JSON.encode(
        {'type' : 'createObject',
          'callId' : callId,
          'objectId' : objectId,
          'objType': type,
          'args': arguments}
    );
    Completer c = new Completer();
    _registerCallback(callId, (result){
      c.complete(result);
    });
    _send(data);

    return c.future;
  }

  void registerForObjectEvents(objectId, callback){
    _objectEvents[objectId] = callback;
  }

  void _registerCallback(callId, callback){
    _callbacks[callId] = callback;
  }

  void _dispatchMessage(msg){
    String type = msg['type'];

    if(type == "rCreateObject" || type == "rCallMethod"){
      if(!_callbacks.containsKey(msg['callId']))
        print("CallId ${msg['callId']} not registered");
      else{
        _callbacks[msg['callId']](msg);
        _callbacks.remove(msg['callId']);
      }
    }
    else if(type == "event"){
      if(!_objectEvents.containsKey(msg['objectId']))
        print("No event listener listening for object id ${msg['objectId']}");
      else{
        _objectEvents[msg['objectId']](msg);
      }
    }
  }
}