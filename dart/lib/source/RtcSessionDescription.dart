part of webrtc;

abstract class RtcSessionDescription {
  String get sdp;

  void set sdp(String value);

  String get type;

  void set type(String value);
}