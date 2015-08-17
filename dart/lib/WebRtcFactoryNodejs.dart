library webrtc.nodejs;


import 'dart:io';
import 'dart:convert';
import 'dart:async';
import 'package:uuid/uuid.dart';
import 'WebRtc.dart';
import './source/nodejs/WebRtcNodejs.dart';
import './source/nodejs/NodejsCommTCP.dart';


class WebRtcFactoryNodeJs extends WebRtcFactory{

  WebRtcFactoryNodeJs(int remotePort, int localPort){
    NodeJsCommTCP.remotePort = remotePort;
    new NodeJsCommTCP();
  }

  Future<RtcPeerConnection> createRtcPeerConnection(Map rtcConfiguration, Map mediaConstraints) {
    String objectId = new Uuid().v4();
    return NodeJsCommTCP.nodejsComm.createObject(objectId, "RtcPeerConnection", [rtcConfiguration]).then((result){
      return new RtcPeerConnectionNodejs(result['objectId'], result['args']);
    });
  }

  RtcSessionDescription createRtcSessionDescription([Map descriptionInitDict]){
    return new RtcSessionDescriptionNodeJs({
      'objectId' : null,
      'result': descriptionInitDict
    });
  }

  RtcIceCandidate createRtcIceCandidate([Map init]){
    return new RtcIceCandidateNodeJs({
      'objectId' : null,
      'result': init
    });
  }
}