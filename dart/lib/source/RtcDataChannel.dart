part of webrtc;

abstract class RtcDataChannel{
  String get binaryType;
  void set binaryType(String value);

  int get bufferedAmount;

  int get id;

  String get label;

  int get maxRetransmitTime;

  int get maxRetransmits;

  bool get negotiated;

  bool get ordered;

  String get protocol;

  String get readyState;

  bool get reliable;

  void close();

  void send(data);

  /// Returns a broadcast stream on onClose events
  ///
  Stream<RtcDataChannel> get onClose;

  /// Returns a broadcast stream on onError events
  ///
  Stream<RtcDataChannel> get onError;

  /// Returns a broadcast stream on onMessage events
  ///
  Stream<MessageEvent> get onMessage;

  /// Returns a broadcast stream on onOpen events
  ///
  Stream<RtcDataChannel> get onOpen;
}