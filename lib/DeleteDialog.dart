import 'package:link2task/API.dart';
import 'package:flutter/material.dart';



showDeleteDialog(BuildContext context, String id) {

  _deleteTask() {
    API.deleteTask(id).then((response) {
      print(response);
    });
  }

  Widget yesButton = FlatButton(
      child: Text("Yes"),
      onPressed: () {
        _deleteTask();
        Navigator.pop(context);
        Navigator.pop(context,"success");
      }
  );
  Widget noButton = FlatButton(
      child: Text("No"),
      onPressed:  () {
        Navigator.pop(context);
      }
  );

  AlertDialog alert = AlertDialog(
    title: Text("Notice"),
    content: Text("Are you sure you want to delete task?"),
    actions: [
      yesButton,
      noButton
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}