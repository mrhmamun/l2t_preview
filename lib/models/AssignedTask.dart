class AssignedTask {
  String id;
  String task_assign_id;
  String assigned_to;
  String assigned_from;
  String subject;
  String content;
  String rating;
  String owner;
  String type;
  String date;

  AssignedTask(String id, String task_assign_id, String assigned_to, String assigned_from, String subject, String content, String rating, String owner, String type, String date) {
    this.id = id;
    this.task_assign_id = task_assign_id;
    this.assigned_to = assigned_to;
    this.assigned_from = assigned_from;
    this.subject = subject;
    this.content = content;
    this.rating = rating;
    this.owner = owner;
    this.type = type;
    this.date = date;
  }

  AssignedTask.fromJson(Map json)
      : id = json['id'],
        task_assign_id = json['Assigned_id'],
        assigned_to = json['Assigned_to'],
        assigned_from = json['Assigned_from'],
        subject = json['Subject'],
        content = json['Content'],
        rating = json['Rating'],
        owner = json['Owner'],
        type = json['Type'],
        date = json['Date'];

  Map toJson() {
    return {'id': id, 'task_assign_id': task_assign_id, 'assigned_to': assigned_to, 'assigned_from': assigned_from, 'Subject': subject, 'Content': content, 'Rating': rating, 'Owner': owner, 'Type': type, 'Date': date};
  }
}