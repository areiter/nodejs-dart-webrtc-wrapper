library webrtc.browser;

import 'WebRtc.dart';
import './source/browser/WebRtcBrowser.dart';

import 'dart:html' as dhtml;
import 'dart:async';

class WebRtcFactoryBrowser extends WebRtcFactory{

  Future<RtcPeerConnection> createRtcPeerConnection(Map rtcConfiguration, Map mediaConstraints) {
    return new Future.value(new RtcPeerConnectionBrowserInterop(rtcConfiguration, mediaConstraints));
  }

  RtcSessionDescription createRtcSessionDescription([Map descriptionInitDict]){
    return new RtcSessionDescriptionBrowserInterop(new dhtml.RtcSessionDescription(descriptionInitDict));
  }

  RtcIceCandidate createRtcIceCandidate([Map init]){
    return new RtcIceCandidateBrowserInterop(new dhtml.RtcIceCandidate(init));
  }
}