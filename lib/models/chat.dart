class Chat {
  Chat(
      {this.senderPicUrl,
      this.read,
      this.senderName,
      this.lastmessage,
      this.lastSeen});
  String senderName;
  String lastSeen;
  String lastmessage;
  bool read;
  String senderPicUrl;
}
