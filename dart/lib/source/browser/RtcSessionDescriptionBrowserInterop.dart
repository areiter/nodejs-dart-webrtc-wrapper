part of webrtc.browser;

class RtcSessionDescriptionBrowserInterop extends RtcSessionDescription{


  RtcSessionDescriptionBrowserInterop(this.sessionDescription);

  dhtml.RtcSessionDescription sessionDescription;

  String get sdp => sessionDescription.sdp;
  void set sdp(String value) {sessionDescription.sdp = value;}

  String get type => sessionDescription.type;
  void set type(String value) { sessionDescription.type = value; }

}