part of webrtc.nodejs;

class RtcIceCandidateNodeJs extends RtcIceCandidate{

  var data;

  RtcIceCandidateNodeJs(this.data){

  }

  RtcIceCandidateNodeJs.cloneData(RtcIceCandidate other){
    data = {
      'objectId' : null,
      'result': {
        'candidate' : other.candidate,
        'sdpMLineIndex' : other.sdpMLineIndex,
        'sdpMid' : other.sdpMid
      }
    };
  }

  String get objectId => data['objectId'];

  String get candidate => data['result']['candidate'];
  int get sdpMLineIndex => data['result']['sdpMLineIndex'];
  String get sdpMid => data['result']['sdpMid'];

  void set sdpMid(String value) {
    data['result']['sdpMid'] = value;
  }

  void set sdpMLineIndex(int value) {
    data['result']['sdpMLineIndex'] = value;
  }

  void set candidate(String value) {
    data['result']['candidate'] = value;
  }

  Map encodeToJSON(){
    return {
      'candidate' : candidate,
      'sdpMLineIndex' : sdpMLineIndex,
      'sdpMid' : sdpMid
    };
  }
}