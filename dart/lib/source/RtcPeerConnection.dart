
part of webrtc;

abstract class RtcPeerConnection {
  Future<RtcSessionDescription> createOffer([Map mediaConstraints]);

  Future<RtcSessionDescription> createAnswer([Map mediaConstraints]);

  //TODO: RtcPeerConnection.getStats not implemented
  //Future<RtcStatsResponse> getStats(MediaStreamTrack selector);


  //TODO: Implement in derived class
  /*  factory RtcPeerConnection(Map rtcConfiguration, [Map mediaConstraints]) {
    if (mediaConstraints != null) {
      return _blink.BlinkRTCPeerConnection.instance.constructorCallback_2_(rtcConfiguration, mediaConstraints);
    }
    return _blink.BlinkRTCPeerConnection.instance.constructorCallback_1_(rtcConfiguration);
  }
  */

  String get iceConnectionState;

  String get iceGatheringState;

  RtcSessionDescription get localDescription;

  RtcSessionDescription get remoteDescription;

  String get signalingState;

  void addIceCandidate(RtcIceCandidate candidate, var successCallback, var failureCallback);

  //TODO: RtcPeerConnection.addStream not implemented, as only RtcDataChannel relevant APIs are implemented
  /*void addStream(MediaStream stream, [Map mediaConstraints]) {
    if (mediaConstraints != null) {
      _blink.BlinkRTCPeerConnection.instance.addStream_Callback_2_(this, stream, mediaConstraints);
      return;
    }
    _blink.BlinkRTCPeerConnection.instance.addStream_Callback_1_(this, stream);
    return;
  }
  */

  void close();


  //TODO: RtcPeerConnection.addStream not implemented, as only RtcDataChannel relevant APIs are implemented
  /*RtcDtmfSender createDtmfSender(MediaStreamTrack track) => _blink.BlinkRTCPeerConnection.instance.createDTMFSender_Callback_1_(this, track);
   */

  Future<RtcDataChannel> createDataChannel(String label, [Map options]);

  //TODO: RtcPeerConnection.getLocalStreams not implemented, as only RtcDataChannel relevant APIs are implemented
  /*@DomName('RTCPeerConnection.getLocalStreams')
  @DocsEditable()
  List<MediaStream> getLocalStreams() => _blink.BlinkRTCPeerConnection.instance.getLocalStreams_Callback_0_(this);
  */

  //TODO: RtcPeerConnection.getRemoteStreams not implemented, as only RtcDataChannel relevant APIs are implemented
  /*@DomName('RTCPeerConnection.getRemoteStreams')
  @DocsEditable()
  List<MediaStream> getRemoteStreams() => _blink.BlinkRTCPeerConnection.instance.getRemoteStreams_Callback_0_(this);
  */

  //TODO: RtcPeerConnection.getStreamById not implemented, as only RtcDataChannel relevant APIs are implemented
  /*@DomName('RTCPeerConnection.getStreamById')
  @DocsEditable()
  MediaStream getStreamById(String streamId) => _blink.BlinkRTCPeerConnection.instance.getStreamById_Callback_1_(this, streamId);
  */

  //TODO: RtcPeerConnection.removeStream not implemented, as only RtcDataChannel relevant APIs are implemented
  /*
  @DomName('RTCPeerConnection.removeStream')
  @DocsEditable()
  void removeStream(MediaStream stream) => _blink.BlinkRTCPeerConnection.instance.removeStream_Callback_1_(this, stream);
  */

  Future setLocalDescription(RtcSessionDescription description);

  Future setRemoteDescription(RtcSessionDescription description);

  void updateIce([Map configuration, Map mediaConstraints]);

  //TODO: RtcPeerConnection.onAddStream not implemented, as only RtcDataChannel relevant APIs are implemented
  /// Stream of `addstream` events handled by this [RtcPeerConnection].
  /*
  @DomName('RTCPeerConnection.onaddstream')
  @DocsEditable()
  Stream<MediaStreamEvent> get onAddStream => addStreamEvent.forTarget(this);
  */

  Stream<RtcDataChannel> get onDataChannel;

  Stream<RtcIceCandidate> get onIceCandidate;

  Stream get onIceConnectionStateChange;

  Stream get onNegotiationNeeded;

  //TODO: RtcPeerConnection.onRemoveStream not implemented, as only RtcDataChannel relevant APIs are implemented
  /// Stream of `removestream` events handled by this [RtcPeerConnection].
  /*@DomName('RTCPeerConnection.onremovestream')
  @DocsEditable()
  Stream<MediaStreamEvent> get onRemoveStream => removeStreamEvent.forTarget(this);
  */

  Stream get onSignalingStateChange;
}