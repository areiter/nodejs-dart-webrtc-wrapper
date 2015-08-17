part of webrtc.nodejs;

class RtcDataChannelNodeJs extends RtcDataChannel{

  String objectId;
  var data;

  RtcDataChannelNodeJs(this.objectId, this.data){
    NodeJsCommTCP.nodejsComm.registerForObjectEvents(objectId, (msg){
      if(msg['event'] == "onOpen") {
        data['readyState'] = 'open';
        ctrlOnOpen.add(this);
      }
      else if(msg['event'] == "onClose") {
        data['readyState'] = 'closed';
        ctrlOnClose.add(this);
      }
      else if(msg['event'] == "onError") {
        data['readyState'] = 'closed';
        ctrlOnError.add(this);
      }
      else if(msg['event'] == "onMessage") {
        ctrlOnMessage.add(new MessageEventNodejs(msg));
      }
    });
  }

  String get binaryType => data['binaryType'];

  int get bufferedAmount {
    return 0;
  }

  int get id => data['id'];

  String get label => data['label'];

  int get maxRetransmitTime => data['maxRetransmitTime'];

  int get maxRetransmits => data['maxRetransmits'];

  //TODO: Cannot get value synchonized
  bool get negotiated => true;


  bool get ordered => data['ordered'];

  String get protocol => data['protocol'];

  String get readyState {
    NodeJsCommTCP.nodejsComm.callMethod(objectId, "RtcDataChannel:getReadyState", [])
    .then((result){
      data['readyState'] = result['data'];
    });

    return data['readyState'];
  }

  bool get reliable => data['reliable'];

  StreamController<RtcDataChannel> ctrlOnClose = new StreamController.broadcast();
  Stream<RtcDataChannel> get onClose => ctrlOnClose.stream;

  StreamController<RtcDataChannel> ctrlOnError = new StreamController.broadcast();
  Stream<RtcDataChannel> get onError => ctrlOnError.stream;

  StreamController<MessageEvent> ctrlOnMessage = new StreamController.broadcast();
  Stream<MessageEvent> get onMessage => ctrlOnMessage.stream;

  StreamController<RtcDataChannel> ctrlOnOpen = new StreamController.broadcast();
  Stream<RtcDataChannel> get onOpen => ctrlOnOpen.stream;

  void send(data) {

    var transmitData;

    if(data is String)
      transmitData = {'sdata' : data};
    else
      transmitData = {'b64data' : CryptoUtils.bytesToBase64(data)};

    NodeJsCommTCP.nodejsComm.callMethod(objectId, "RtcDataChannel:send", [transmitData]);
  }


  void close() {
    NodeJsCommTCP.nodejsComm.callMethod(objectId, "RtcDataChannel:close", []);
  }


  void set binaryType(String value) {
    NodeJsCommTCP.nodejsComm.callMethod(objectId, "RtcDataChannel:setBinaryType", [value]);
    data['binaryType'] = value;
  }

}