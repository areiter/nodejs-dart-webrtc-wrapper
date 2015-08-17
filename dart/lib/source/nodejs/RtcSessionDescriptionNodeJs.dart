part of webrtc.nodejs;

class RtcSessionDescriptionNodeJs extends RtcSessionDescription{

  var data;

  RtcSessionDescriptionNodeJs(this.data){

  }

  RtcSessionDescriptionNodeJs.cloneData(RtcSessionDescription other){
    data = {
      'objectId' : null,
      'result': {
        'type' : other.type,
        'sdp' : other.sdp
      }
    };
  }

  String get objectId => data['objectId'];

  String get sdp => data['result']['sdp'];
  String get type => data['result']['type'];

  void set type(String value) {
    data['result']['type'] = value;
  }

  void set sdp(String value) {
    data['result']['sdp'] = value;
  }

  Map encodeToJSON(){
    return {
      'type' : type,
      'sdp' : sdp
    };
  }
}