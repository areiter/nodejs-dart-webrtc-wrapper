part of webrtc;


WebRtcFactory wrtcFactory;

/// Abstract factory for creating WebRTC related objects
///
/// The factory is abstracted in a way that different implementations depending on incompatible libraries
/// (e.g. dart:io vs dart:html)  can be created by different factory implementations
abstract class WebRtcFactory{

  /// Creates a new RtcPeerConnection with the given configuration properties.
  ///
  /// The arguments are consistent with the specification and it should be able to pass them to the concrete
  /// implementation as they are.
  Future<RtcPeerConnection> createRtcPeerConnection(Map rtcConfiguration, Map mediaConstraints);

  /// Create a new RtcSessionDescription with the given configuration properties
  ///
  RtcSessionDescription createRtcSessionDescription([Map descriptionInitDict]);

  /// Create a new RtcIceCandidate with the given configuration properties
  ///
  RtcIceCandidate createRtcIceCandidate([Map init]);
}