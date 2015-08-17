part of webrtc.nodejs;

class RtcPeerConnectionNodejs extends RtcPeerConnection{

  String _objectId;

  RtcPeerConnectionNodejs(this._objectId, Map init){
    _signalingState = init['signalingState'];
    _iceConnectionState = init['iceConnectionState'];
    _iceGatheringState = init['iceGatheringState'];

    onSignalingStateChange.listen((newSignalingState) => _signalingState = newSignalingState);
    onIceConnectionStateChange.listen((newIceConnectionState) => _iceConnectionState = newIceConnectionState);

    NodeJsCommTCP.nodejsComm.registerForObjectEvents(_objectId, (msg){
      if(msg['event'] == "onSignalingStateChange")
        ctrlOnSignalStateChange.add(msg['data']);
      else if(msg['event'] == "onIceConnectionStateChange")
        ctrlOnIceConnectionStateChange.add(msg['data']);
      else if(msg['event'] == "onIceGatheringStateChange")
        _iceGatheringState = msg['data'];
      else if(msg['event'] == "onIceCandidate")
        ctrlOnIceCandidate.add(new RtcIceCandidateNodeJs({'objectId': null, 'result' : msg['data']}));
      else if(msg['event'] == "onDataChannel")
        ctrlOnDataChannel.add(new RtcDataChannelNodeJs(msg['dataChannelId'], msg['data']));
    });

    onDataChannel.listen((RtcDataChannel){

    });

    //TODO onnegotiationeeded is not supported by nodejs yet, simulate it
    ctrlOnNegotiatedNeeded.add(null);
  }


  Future<RtcSessionDescription> createOffer([Map mediaConstraints]) {
    return NodeJsCommTCP.nodejsComm.callMethod(_objectId, "RtcPeerConnection:createOffer", [{}])
    .then((result){
      return new RtcSessionDescriptionNodeJs(result);
    });
  }

  Future<RtcSessionDescription> createAnswer([Map mediaConstraints]) {
    return NodeJsCommTCP.nodejsComm.callMethod(_objectId, "RtcPeerConnection:createAnswer", [{}])
    .then((result){
      return new RtcSessionDescriptionNodeJs(result);
    });
  }

  void addIceCandidate(RtcIceCandidate candidate, successCallback, failureCallback) {
    var candidateJson;

    if(candidate is RtcIceCandidateNodeJs)
      candidateJson = (candidate as RtcIceCandidateNodeJs).encodeToJSON();
    else
      candidateJson = new RtcIceCandidateNodeJs.cloneData(candidate).encodeToJSON();

    NodeJsCommTCP.nodejsComm.callMethod(_objectId, "RtcPeerConnection:addIceCandidate", [candidateJson])
    .then((result){
      if(!result.containsKey('error'))
        successCallback();
      else
        failureCallback(result);
    });
  }

  void close() {
    NodeJsCommTCP.nodejsComm.callMethod(_objectId, "RtcPeerConnection:close", [{}]);
  }

  Future<RtcDataChannel> createDataChannel(String label, [Map options]) {
    return NodeJsCommTCP.nodejsComm.callMethod(_objectId, "RtcPeerConnection:createDataChannel", [label, options])
    .then((result){
      return new RtcDataChannelNodeJs(result['dataChannelId'], result['data']);
    });
  }

  Future setLocalDescription(RtcSessionDescription description) {
    var descriptionJson;

    if(description is RtcSessionDescriptionNodeJs)
      descriptionJson = (description as RtcSessionDescriptionNodeJs).encodeToJSON();
    else
      descriptionJson = new RtcSessionDescriptionNodeJs.cloneData(description).encodeToJSON();

    Completer c = new Completer();

    NodeJsCommTCP.nodejsComm.callMethod(_objectId, "RtcPeerConnection:setLocalDescription", [descriptionJson])
    .then((result){
      if(!result.containsKey('error')) {
        _localDescription = description;
        c.complete();
      }
      else
        c.completeError(result['error']);
    });

    return c.future;
  }

  Future setRemoteDescription(RtcSessionDescription description) {
    var descriptionJson;

    if(description is RtcSessionDescriptionNodeJs)
      descriptionJson = (description as RtcSessionDescriptionNodeJs).encodeToJSON();
    else
      descriptionJson = new RtcSessionDescriptionNodeJs.cloneData(description).encodeToJSON();

    Completer c = new Completer();

    NodeJsCommTCP.nodejsComm.callMethod(_objectId, "RtcPeerConnection:setRemoteDescription", [descriptionJson])
    .then((result){
      if(!result.containsKey('error')) {
        _remoteDescription = description;
        c.complete();
      }
      else
        c.completeError(result['error']);
    });

    return c.future;
  }

  void updateIce([Map configuration, Map mediaConstraints]) {
    //TODO: No remote implementation
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


  String _signalingState = null;
  String get signalingState => _signalingState;


  RtcSessionDescription _remoteDescription = null;
  RtcSessionDescription get remoteDescription => _remoteDescription;


  RtcSessionDescription _localDescription = null;
  RtcSessionDescription get localDescription => _localDescription;


  String _iceGatheringState = null;
  String get iceGatheringState => _iceGatheringState;


  String _iceConnectionState = null;
  String get iceConnectionState => _iceConnectionState;

}