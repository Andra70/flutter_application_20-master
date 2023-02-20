// import 'dart:html';
// import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_20/User.dart';

// import 'package:flutter_application_19/main.dart';

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("All Data"),
          // actions: [
          //   IconButton(
          //     icon: Icon(Icons.add),
          //     onPressed: () {
          //       final name = controller.text;

          //       createUser(name: name);
          //     },
          //   )
          // ],
        ),
        body: StreamBuilder<List<User>>(
            stream: readUsers(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text('Something went wrong! ${snapshot.error}');
              } else if (snapshot.hasData) {
                final user = snapshot.data!;

                return ListView(
                  children: user.map(buildUser).toList(),
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }),

        // floatingActionButton: FloatingActionButton(
        //     child: Icon(Icons.add),
        //     onPressed: () {
        //       Navigator.of(context)
        //           .push(MaterialPageRoute(builder: (context) => UserPage()));
        //     }),
        floatingActionButton:
            Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
          FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => const UserPage()));
            },
          ),

          // FloatingActionButton(
          //   onPressed: () {
          //     Navigator.push(
          //         context, MaterialPageRoute(builder: (_) => const UserPage()));
          //   },
          // )
          Expanded(child: Container()),
          FloatingActionButton(
            child: Icon(Icons.update),
            onPressed: () {
              final docUser = FirebaseFirestore.instance
                  .collection('user')
                  .doc('T7W0Z3xnDzUCJPxwbHfP');
              docUser.update({
                'name': 'BLAIG',
              });
            },
          ),
          //   ],
          // ),
          // body: StreamBuilder<List<User>>(
          //   stream: readUser(),
          //   builder: ((context, snapshot) {
          //     if (snapshot.hasError) {
          //       return Text('Something went wrong! ${snapshot.error}');
          //     } else if (snapshot.hasData) {
          //       final user = snapshot.data!;

          //       return ListView(
          //         children: user.map(buildUser).toList(),
          //       );
          //     } else {
          //       return Center(child: CircularProgressIndicator());
          //     }
          //   }),
          // ),
        ]));
  }

  Widget buildUser(User user) => ListTile(
        leading: CircleAvatar(child: Text('${user.age}')),
        title: Text(user.name),
      );
  // Widget buildUser(User user) => ListTile(
  //       leading: CircleAvatar(child: Text('${user.age}')),
  //       title: Text(user.name),
  //       // subtitle: Text(user.birthday.toIso8601String()),
  //     );
  // Stream<List<User>> readUser() => FirebaseFirestore.instance
  //     .collection('user')
  //     .snapshots()
  //     // .collection('users')
  //     // .snapshots()
  //     .map((snapshot) =>
  //         snapshot.docs.map((doc) => User.Fromjson(doc.data())).toList());

  Stream<List<User>> readUsers() => FirebaseFirestore.instance
      .collection('user')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => User.FromJson(doc.data())).toList());

  // Future createUser({required String name}) async {
  //   final docUser = FirebaseFirestore.instance.collection('user').doc();
  //   final user = User(
  //     id: docUser.id,
  //     name: name,
  //     age: 21,
  //     // birthday: DateTime(2001, 7, 28),
  //   );
  //   final json = user.toJson();

  //   ///Create document and write data to firebase
  //   await docUser.set(json);
  // }

}

class User {
  String id;
  final String name;
  final int age;
  // final DateTime birthday;

  User({
    this.id = '',
    required this.name,
    required this.age,
    // required this.birthday,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'age': age,
        // 'birthday': birthday,
      };
  static User FromJson(Map<String, dynamic> json) => User(
        id: json['id'],
        name: json['name'],
        age: json['age'],

        // birthday: (json['birthday'] as Timestamp).toDate(),
      );
}
