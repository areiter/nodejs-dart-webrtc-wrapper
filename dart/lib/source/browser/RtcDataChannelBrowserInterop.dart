part of webrtc.browser;

class RtcDataChannelBrowserInterop extends RtcDataChannel{

  RtcDataChannelBrowserInterop(this.dataChannel){
    dataChannel.onClose.listen((evt) => ctrlOnClose.add(this));
    dataChannel.onError.listen((evt) => ctrlOnError.add(this));
    dataChannel.onOpen.listen((evt) => ctrlOnOpen.add(this));
    dataChannel.onMessage.listen((dhtml.MessageEvent evt) => ctrlOnMessage.add(new MessageEventBrowserInterop(evt)));
  }

  dhtml.RtcDataChannel dataChannel;

  String get binaryType => dataChannel.binaryType;
  void set binaryType(String value) { dataChannel.binaryType = value; }

  int get bufferedAmount => dataChannel.bufferedAmount;

  int get id => dataChannel.id;

  String get label => dataChannel.label;

  int get maxRetransmitTime => dataChannel.maxRetransmitTime;

  int get maxRetransmits => dataChannel.maxRetransmits;

  bool get negotiated => dataChannel.negotiated;

  bool get ordered => dataChannel.ordered;

  String get protocol => dataChannel.protocol;

  String get readyState => dataChannel.readyState;

  bool get reliable => dataChannel.reliable;

  StreamController<RtcDataChannel> ctrlOnClose = new StreamController<RtcDataChannel>.broadcast();
  Stream<RtcDataChannel> get onClose => ctrlOnClose.stream;

  StreamController<RtcDataChannel> ctrlOnError = new StreamController<RtcDataChannel>.broadcast();
  Stream<RtcDataChannel> get onError => ctrlOnError.stream;

  StreamController<MessageEvent> ctrlOnMessage = new StreamController<MessageEvent>.broadcast();
  Stream<MessageEvent> get onMessage => ctrlOnMessage.stream;

  StreamController<RtcDataChannel> ctrlOnOpen = new StreamController<RtcDataChannel>.broadcast();
  Stream<RtcDataChannel> get onOpen => ctrlOnOpen.stream;

  void send(data) {
    dataChannel.send(data);
  }


  void close() {
    dataChannel.close();
  }
}