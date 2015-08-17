// Copyright (c) 2015, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:io';
import 'package:crypto/crypto.dart';
import 'package:dartcmd_webrtc/source/nodejs/NodejsCommTCP.dart';
import 'package:dartcmd_webrtc/WebRtcFactoryNodejs.dart';
import 'package:dartcmd_webrtc/WebRtc.dart';
import 'package:dartcmd_webrtc/P2PProvider.dart';
import 'package:dartcmd_webrtc/P2PProviderFactoryNodeJs.dart';

const Map rtcConfiguration = const {"iceServers": const []};

main() {
  P2PProviderFactory f = new P2PProviderFactoryNodeJs();
  P2P p2p = f.createP2PProvider({'host' : 'localhost', 'port':6655});

  p2p.initialize().then((_) {


    p2p.connect("client1", {
      'signalingURL': 'http://localhost:9000',
      'p12' : CryptoUtils.bytesToBase64(new File("/home/areiter/client1.p12").readAsBytesSync()),
      'p12password' : 'test'
    });

    p2p.registered.listen((P2P p2p) {
      print("Registered at management entity with id: ${p2p.peerId}");
      p2p.updateResourceProviderState(true);
    });

    p2p.ready.listen((P2P p2p) {
      PeerConnection pc;
      AuthenticatedPeerConnection ac;
      print("Ready for communication");
      new Timer(new Duration(seconds:3), () {
        p2p.getPeerConnection(new PeerId.systemId(p2p, "client2"))
        .then((PeerConnection p) => pc = p)
        .then((_) => pc.directConnect())
        .then((_) => pc.authenticateConnection())
        .then((AuthenticatedPeerConnection c) {
          ac = c;
          return ac.getRemoteCertificateFingerprint();
        })
        .then((String fingerprint) => print(fingerprint))
        .then((_) => ac.getRemoteCertificate())
        .then((String certificate) => print(certificate))
        .then((_) {
          for (var i = 0; i < 100; i++) {
            pc.send({'d' : 'My arbitrary data$i'});
            ac.send({'x' : 'My data over encrypted channel$i'});
          }

        });
      });
      /*.then((_) {
        new Timer.periodic(new Duration(milliseconds: 2000), (Timer t) {
          int tick = new DateTime.now().millisecondsSinceEpoch;
          ac.ping()
          .then((_) {
            print("Ping Completed in ${new DateTime.now().millisecondsSinceEpoch - tick}");
          });
        });
      });*/


    });
  });

  P2P p2p_2 = f.createP2PProvider({'host' : 'localhost', 'port':6655});

  p2p_2.initialize().then((_) {
    p2p_2.connect("client2",
    {
      'signalingURL': 'http://localhost:9000',
      'p12' : CryptoUtils.bytesToBase64(new File("/home/areiter/client2.p12").readAsBytesSync()),
      'p12password' : 'test'
    });

    p2p_2.registered.listen((peerId) {
      print("Registered at management entity with id: $peerId");
      p2p.updateResourceProviderState(true);
    });

    p2p_2.ready.listen((_) {
      print("Ready for communication");
    });

    p2p_2.newPeerConnection.listen((PeerConnection pc){

      pc.message.listen((P2PMessage msg){
        print("Received plain message: ${msg.toString()}");
      });


      pc.authenticatedPeerConnection.listen((AuthenticatedPeerConnection ac){
        ac.message.listen((P2PMessage msg){
          print("Received encrypted message: ${msg.toString()}");
        });
      });
    });
  });

  for(var i = 0; i<3; i++) {
    P2P p2p_X = f.createP2PProvider({'host' : 'localhost', 'port':6655});

    p2p_X.initialize().then((_) {
      p2p_X.connect("clientX_$i", {'signalingURL': 'http://localhost:9000'});

      p2p_X.registered.listen((peerId) {
        print("Registered at management entity with id: $peerId");
        p2p.updateResourceProviderState(true);
      });

      p2p_X.ready.listen((_) {
        print("Ready for communication");
      });
    });
  }

}
