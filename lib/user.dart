import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_20/main.dart';
import 'package:flutter_application_20/home.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  var currentValue;
  final controllerName = TextEditingController();
  final controllerAge = TextEditingController();
  // final controllerDate = TextEditingController();
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('Add User'),
        ),
        body: ListView(
          padding: EdgeInsets.all(16),
          children: <Widget>[
            TextField(
              controller: controllerName,
              decoration: decoration('Name'),
            ),
            const SizedBox(height: 24),
            TextField(
              controller: controllerAge,
              decoration: decoration('Age'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              child: Text('Create'),
              onPressed: () {
                final user = User(
                  name: controllerName.text,
                  age: int.parse(controllerAge.text),
                  // birthday: DateTime.parse(controllerDate.text)
                );
                createUser(user);

                Navigator.pop(context);
              },
            ),
            // ElevatedButton(
            //   child: Text('Update'),
            //   onPressed: (() {
            //     final docUser =
            //         FirebaseFirestore.instance.collection('user').doc('my-id');
            //     docUser.update({
            //       'name': 'Gbal',
            //     });
            //   }),
            // )
          ],
        ),
      );
  InputDecoration decoration(String label) => InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
      );

  Future createUser(User user) async {
    final docUser = FirebaseFirestore.instance.collection('user').doc();
    user.id = docUser.id;

    final json = user.toJson();
    await docUser.set(json);
  }

  static User FromJson(Map<String, dynamic> json) => User(
        id: json['id'],
        name: json['name'],
        age: json['age'],
        // birthday: (json['birthday'] as Timestamp).toDate(),
      );
}

// DateFormat(String s) {}

// DateTimeField(
//     {required InputDecoration decoration,
//     required format,
//     required Function(dynamic context, dynamic currentValue) onShowPicker,
//     required Object context,
//     required DateTime firstDate,
//     required DateTime lastDate,
//     required initialDate}) {}
