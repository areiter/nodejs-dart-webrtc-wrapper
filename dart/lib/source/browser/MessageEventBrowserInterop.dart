part of webrtc.browser;

class MessageEventBrowserInterop extends MessageEvent{

  dhtml.MessageEvent messageEvent;

  MessageEventBrowserInterop(this.messageEvent);

  get data => messageEvent.data;
}
