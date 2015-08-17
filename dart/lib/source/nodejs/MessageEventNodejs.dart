part of webrtc.nodejs;

class MessageEventNodejs extends MessageEvent{

  var _data;

  MessageEventNodejs(msg){
    if(msg.containsKey("sdata"))
      _data = msg["sdata"];
    else{
      _data = CryptoUtils.base64StringToBytes(msg['b64data']);
    }

  }

  get data => _data;


}