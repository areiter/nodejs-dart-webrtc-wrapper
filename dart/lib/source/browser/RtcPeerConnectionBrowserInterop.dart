part of webrtc.browser;

class RtcPeerConnectionBrowserInterop extends RtcPeerConnection{

  dhtml.RtcPeerConnection _pc;

  factory RtcPeerConnectionBrowserInterop(Map rtcConfiguration, Map mediaConstraints){
    dhtml.RtcPeerConnection pc = new dhtml.RtcPeerConnection(rtcConfiguration, mediaConstraints);
    return new RtcPeerConnectionBrowserInterop._internal(pc);
  }


  Future<RtcSessionDescription> createOffer([Map mediaConstraints]) {
    return _pc.createOffer(mediaConstraints).then((dhtml.RtcSessionDescription sessionDescription){
      return new RtcSessionDescriptionBrowserInterop(sessionDescription);
    });
  }

  Future<RtcSessionDescription> createAnswer([Map mediaConstraints]) {
    return _pc.createAnswer(mediaConstraints).then((dhtml.RtcSessionDescription sessionDescription){
      return new RtcSessionDescriptionBrowserInterop(sessionDescription);
    });
  }

  void addIceCandidate(RtcIceCandidate candidate, successCallback, failureCallback) {
    if(!(candidate is RtcIceCandidateBrowserInterop)){
      throw new Exception("Unsupported RtcIceCandidate");
    }

    _pc.addIceCandidate((candidate as RtcIceCandidateBrowserInterop).iceCandidate, successCallback, failureCallback);
  }

  void close() {
    _pc.close();
  }

  Future<RtcDataChannel> createDataChannel(String label, [Map options]) {
    dhtml.RtcDataChannel dhtmlChannel = _pc.createDataChannel(label, options);

    return new Future.value(new RtcDataChannelBrowserInterop(dhtmlChannel));
  }

  Future setLocalDescription(RtcSessionDescription description) {
    if(!(description is RtcSessionDescriptionBrowserInterop)){
      throw new Exception("Unsupported RtcSessionDescription");
    }

    return _pc.setLocalDescription((description as RtcSessionDescriptionBrowserInterop).sessionDescription);
  }

  Future setRemoteDescription(RtcSessionDescription description) {
    if(!(description is RtcSessionDescriptionBrowserInterop)){
      throw new Exception("Unsupported RtcSessionDescription");
    }

    return _pc.setRemoteDescription((description as RtcSessionDescriptionBrowserInterop).sessionDescription);
  }

  void updateIce([Map configuration, Map mediaConstraints]) {
    _pc.updateIce(configuration, mediaConstraints);
  }


  RtcPeerConnectionBrowserInterop._internal(this._pc){
    _pc.onSignalingStateChange.listen((evt) => ctrlOnSignalStateChange.add(evt));
    _pc.onNegotiationNeeded.listen((evt) => ctrlOnNegotiatedNeeded.add(evt));
    _pc.onIceConnectionStateChange.listen((evt) => ctrlOnIceConnectionStateChange.add(evt));
    _pc.onIceCandidate.listen((dhtml.RtcIceCandidateEvent evt){
      if(evt.candidate != null)
        ctrlOnIceCandidate.add(new RtcIceCandidateBrowserInterop(evt.candidate));
    });
    _pc.onDataChannel.listen((dhtml.RtcDataChannelEvent evt) => ctrlOnDataChannel.add(new RtcDataChannelBrowserInterop(evt.channel)));
  }

  StreamController ctrlOnSignalStateChange = new StreamController.broadcast();
  Stream get onSignalingStateChange => ctrlOnSignalStateChange.stream;

  StreamController ctrlOnNegotiatedNeeded = new StreamController.broadcast();
  Stream get onNegotiationNeeded => ctrlOnNegotiatedNeeded.stream;


  StreamController ctrlOnIceConnectionStateChange = new StreamController.broadcast();
  Stream get onIceConnectionStateChange => ctrlOnIceConnectionStateChange.stream;


  StreamController ctrlOnIceCandidate = new StreamController.broadcast();
  Stream<RtcIceCandidate> get onIceCandidate => ctrlOnIceCandidate.stream;

  StreamController ctrlOnDataChannel = new StreamController.broadcast();
  Stream<RtcDataChannel> get onDataChannel => ctrlOnDataChannel.stream;


  String get signalingState => _pc.signalingState;


  RtcSessionDescription get remoteDescription => new RtcSessionDescriptionBrowserInterop(_pc.remoteDescription);


  RtcSessionDescription get localDescription => new RtcSessionDescriptionBrowserInterop(_pc.localDescription);


  String get iceGatheringState => _pc.iceGatheringState;


  String get iceConnectionState => _pc.iceConnectionState;

}