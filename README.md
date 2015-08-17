# nodejs-dart-webrtc-wrapper
Provides a nodejs module which exposes the WebRTC api over tcp, so command line based dart apps can use WebRTC.

Start the nodejs server part with 
```dart
node bin/server 6600
```


In dart create an instance of the WebRtcFactoryNodeJs wih rtcConfiguration and mediaConstraints as described in the specification

```dart
var factory = new WebRtcFactoryNodeJs();

factory.createRtcPeerConnection(rtcConfiguration, mediaConstraints)
.then((RtcPeerConnection pc){
 ...
});
```