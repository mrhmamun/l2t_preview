class User {
  String id;
  String assigned_to;
  String assigned_from;
  String token;

  User(String id, String assigned_to, String assigned_from) {
    this.id = id;
    this.assigned_to = assigned_to;
    this.assigned_from = assigned_from;
    this.token = token;
  }

  User.fromJson(Map json)
      : id = json['id'],
        assigned_to = json['Assigned_to'],
        assigned_from = json['Assigned_from'],
        token = json['token'];

  Map toJson() {
    return {'id': id, 'Assigned_to': assigned_to, 'Assigned_from': assigned_from, 'token':token};
  }
}