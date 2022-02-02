import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatMessage extends StatelessWidget {
  const ChatMessage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('chat').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.data == null) {
          return Center(
            child: Text('No Chat'),
          );
        }
        print(snapshot);
        //flutter: AsyncSnapshot<QuerySnapshot<Object?>>(ConnectionState.active, Instance of '_JsonQuerySnapshot', null, null)

        print(snapshot.data);
        //Instance of '_JsonQuerySnapshot'

        print(snapshot.data!.docs);
        //[Instance of '_JsonQueryDocumentSnapshot', Instance of '_JsonQueryDocumentSnapshot', Instance of '_JsonQueryDocumentSnapshot']

        final messageDocs = snapshot.data!.docs;
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
    );
  }
}
