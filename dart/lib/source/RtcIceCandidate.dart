part of webrtc;

abstract class RtcIceCandidate {

  //TODO: implement in derived class
  /*factory RtcIceCandidate(Map dictionary) {
  }
  */

  String get candidate;
  void set candidate(String value);

  int get sdpMLineIndex;
  void set sdpMLineIndex(int value);

  String get sdpMid;
  void set sdpMid(String value);

}