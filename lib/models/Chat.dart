class Chat {
  String id;
  String from;
  String to;
  String subject;
  String message;
  String date;

  Chat(String id, String from, String to, String subject, String message, String date) {
    this.id = id;
    this.from = from;
    this.to = to;
    this.subject = subject;
    this.message = message;
    this.date = date;
  }

  Chat.fromJson(Map json)
      : id = json['id'],
        from = json['chat_from'],
        to = json['chat_to'],
        subject = json['subject'],
        message = json['message_content'],
        date = json['create_date'];


  Map toJson() {
    return {'id': id, 'chat_from': from, 'chat_to': to, 'subject':subject, 'message_content': message, 'date': date};
  }
}