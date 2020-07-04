import 'dart:async';
import 'package:http/http.dart' as http;

const baseUrl = "http://l2t.abrams.si/";

class API {
  static Future getAssignedTasks(String user_id) {
    var url = baseUrl + "task/get_assigned_tasks.php?assigned_to=" + user_id;
    return http.get(url);
  }

  static Future assignTask(String task_id ,String assigned_from, String assigned_to){
    Map<String, String> headers = {"Content-type": "application/json"};
    var url = baseUrl + "task/assign_task.php";
    return http.post(url, body: {'task_id': task_id, 'assigned_to':assigned_to,
      'assigned_from':assigned_from});
  }

  static Future GetUserIdByUsername(String username) {
    var url = baseUrl + "user/get_userid_by_username.php?username=" + username;
    return http.get(url);
  }

  static Future GetUsernameByUserId(String user_id) {
    var url = baseUrl + "user/get_username_by_userid.php?user_id=" + user_id;
    return http.get(url);
  }

  static Future getTasks(String user_id) {
    var url = baseUrl + "task/get_my_tasks.php?task_owner=" + user_id;
    return http.get(url);
  }

  static Future getTask(String user_id) {
    var url = baseUrl + "task/get_task.php?task_id=" + user_id;
    return http.get(url);
  }

  static Future getDashboardTasks(String user_id) {
    var url = baseUrl + "task/get_dashboard_tasks.php?task_owner=" + user_id;
    return http.get(url);
  }

  static Future deleteTask(String task_id) {
    var url = baseUrl + "task/delete_task.php?task_id=" + task_id;
    return http.get(url);
  }

  static Future createTask(String task_subject, int task_type, String task_owner,
      String task_status, String task_content, String task_rating, String start_date, String finish_date){
    Map<String, String> headers = {"Content-type": "application/json"};
    var url = baseUrl + "task/create_task.php";
    return http.post(url, body: {'task_subject': task_subject, 'task_type':task_type.toString(),
      'task_owner':task_owner.toString(), 'task_status':task_status, 'task_content':task_content, 'task_rating': task_rating, 'start_date': start_date, 'finish_date': finish_date});
  }

  static Future updateTask(String task_id, String task_subject, String task_content, String task_type, String task_owner, String task_status, String task_rating) {
    var url = baseUrl + "task/update_task.php?task_id=" + task_id + "&task_subject=" + task_subject+ "&task_type=" + task_type+ "&task_owner=" + task_owner+ "&task_status=" + task_status + "&task_rating=" + task_rating + "&task_content="+task_content;
    print(url);
    return http.get(url);
  }

  static Future logIn(String username, String password) {
    var url = baseUrl + "user/login.php?username=" + username + "&password=" + password;
    return http.get(url);
  }

  static Future signUp(String email, String password, String username,
      String phone_number, String parent_id, String token){
    Map<String, String> headers = {"Content-type": "application/json"};
    var url = baseUrl + "user/signup.php";
    return http.post(url, body: {'username': username, 'password':password,
      'email':email, 'phone_number':phone_number, 'parent_id':parent_id, 'token': token});
  }

  static Future getRelationships(String user_id) {
    var url = baseUrl + "user/get_relationships.php?user_id=" + user_id;
    return http.get(url);
  }

  static Future getNotificationToken(String user_id) {
    var url = baseUrl + "user/getToken.php?user_id=" + user_id;
    return http.get(url);
  }

  static Future getRelationshipRequests(String user_id) {
    var url = baseUrl + "user/get_relationship_requests.php?user_id=" + user_id;
    return http.get(url);
  }

  static Future getAcceptedRequests(String user_id) {
    var url = baseUrl + "user/get_accepted_relationships.php?user_id=" + user_id;
    return http.get(url);
  }

  static Future setRelationship(String user_one_id, String user_two_id, String operation) {
    Map<String, String> headers = {"Content-type": "application/json"};
    var url = baseUrl + "user/relationship_request.php";
    return http.post(url, body: {'operation': operation, 'user1': user_one_id,
      'user2':user_two_id});
  }

  static Future sendChat(String taskId, String from, String to, String subject, String messageContent) {
    Map<String, String> headers = {"Content-type": "application/json"};
    var url = baseUrl + "/user/send_chat.php";
    return http.post(url, body: {'task_id': taskId, 'chat_from': from,
      'chat_to':to, 'subject' : subject, 'message_content' : messageContent});
  }

  static Future getChat(String taskId, String userId) {
    var url = baseUrl + "user/get_chat.php?task_id=" + taskId + "&user_id="+userId;
    print(url);
    return http.get(url);
  }


}