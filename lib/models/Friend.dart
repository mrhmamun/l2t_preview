class Friend {
  String id;
  String user_one_id;
  String user_one_username;
  String user_two_id;
  String user_two_username;
  String user_id;


  Friend(String id, String user_one_id, String user_one_username, String user_two_id, String user_two_username, String user_id) {
    this.id = id;
    this.user_one_id = user_one_id;
    this.user_one_username = user_one_username;
    this.user_two_id = user_two_id;
    this.user_two_username = user_two_username;
    this.user_id = user_id;
  }

  Friend.fromJson(Map json)
      : id = json['RELATIONSHIP_ID'],
        user_one_id = json['USER_ONE_ID'],
        user_one_username = json['USER_ONE_USERNAME'],
        user_two_id = json['USER_TWO_ID'],
        user_two_username = json['USER_TWO_USERNAME'],
        user_id = json['USER_ID'];


  Map toJson() {
    return {'id': id, 'user_one_id': user_one_id, 'user_one_username': user_one_username, 'user_two_id': user_two_id, 'user_two_username': user_two_username, 'user_id' : user_id};
  }
}