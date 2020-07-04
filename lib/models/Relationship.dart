class Relationship {
  String relationship_id;
  String user_one_id;
  String user_one_username;
  String user_two_id;
  String user_two_username;
  String status;
  String action_user_id;
  String created_date;
  String last_update_date;

  Relationship(String relationship_id, String user_one_id, String user_one_username, String user_two_id, String user_two_username, String status, String action_user_id, String created_date, String last_update_date){
    this.relationship_id = relationship_id;
    this.user_one_id = user_one_id;
    this.user_two_id = user_two_id;
    this.user_one_username = user_one_username;
    this.user_two_username = user_two_username;
    this.status = status;
    this.action_user_id = action_user_id;
    this.created_date = created_date;
    this.last_update_date = last_update_date;
  }

  Relationship.fromJson(Map json)
      : relationship_id = json['RELATIONSHIP_ID'],
        user_one_id = json['USER_ONE_ID'],
        user_two_id = json['USER_TWO_ID'],
        status = json['STATUS'],
        action_user_id = json['ACTION_USER_ID'],
        created_date = json['CREATE_DATE'],
        last_update_date = json['LAST_UPDATE_DATE'],
        user_one_username = json['USER_ONE_USERNAME'],
        user_two_username = json['USER_TWO_USERNAME'];


  Map toJson() {
    return {'relationship_id': relationship_id, 'user_one_id': user_one_id, 'user_two_id': user_two_id, 'status': status, 'action_user_id': action_user_id,
      'created_date': created_date, 'last_update_date': last_update_date, 'user_one_username': user_one_username, 'user_two_username': user_two_username};
  }
}