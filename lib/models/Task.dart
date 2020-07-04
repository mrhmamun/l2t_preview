class Task {
  String id;
  String subject;
  String content;
  String owner;
  String type;
  String date;
  String rating;
  String start_date;
  String end_date;

  Task(String id, String subject, String content, String owner, String type, String date, String rating, String start_date, String end_date) {
    this.id = id;
    this.subject = subject;
    this.content = content;
    this.owner = owner;
    this.type = type;
    this.date = date;
    this.rating = rating;
    this.start_date = start_date;
    this.end_date = end_date;
  }

  Task.fromJson(Map json)
      : id = json['id'],
        subject = json['Subject'],
        content = json['Content'],
        owner = json['Owner'],
        type = json['Type'],
        date = json['Date'],
        rating = json['Rating'],
        start_date = json['Start_Date'],
        end_date = json['End_Date'];


  Map toJson() {
    return {'id': id, 'Subject': subject, 'Content': content, 'Owner': owner, 'Type': type, 'Date': date, 'Rating' : rating, 'Start_Date' : start_date, 'End_Date':end_date};
  }
}