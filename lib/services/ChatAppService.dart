import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_lesson12/view/home.dart';

class ChatAppService {
  final db = FirebaseFirestore.instance;
  Future<ChatApp> read() async {
    await db.collection("ChatApp").get().then((event) {
      var id = event.docs;
      print(id);
      return;
    });
    return const ChatApp();
  }
}
