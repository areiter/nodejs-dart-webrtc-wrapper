part of webrtc.browser;

class RtcIceCandidateBrowserInterop extends RtcIceCandidate{

  RtcIceCandidateBrowserInterop(this.iceCandidate);

  dhtml.RtcIceCandidate iceCandidate;

  String get candidate => iceCandidate.candidate;
  void set candidate(String value) { iceCandidate.candidate = value;  }

  int get sdpMLineIndex => iceCandidate.sdpMLineIndex;
  void set sdpMLineIndex(int value) {iceCandidate.sdpMLineIndex = value;  }

  String get sdpMid => iceCandidate.sdpMid;
  void set sdpMid(String value) {iceCandidate.sdpMid = value;}
}