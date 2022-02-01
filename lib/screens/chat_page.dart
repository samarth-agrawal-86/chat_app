// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('chats/beXa2hUeG4sLIjeKLDrW/messages')
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        final messageDocs = snapshot.data!.docs;
        //print('Message Data : $messageData');
        print(messageDocs.first);
        // flutter: Instance of '_JsonQueryDocumentSnapshot'
        print(messageDocs.first.data());
        // flutter: {text: Hello}

        return ListView.builder(
          itemCount: messageDocs.length,
          itemBuilder: (context, index) {
            return Container(
              padding: EdgeInsets.all(10),
              height: 40,
              child: Text('${messageDocs[index]['text']}'),
            );
          },
        );
      },
    ));
  }
}
