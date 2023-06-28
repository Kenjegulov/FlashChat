import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_lesson12/models/Controllers.dart';
import '../models/ChatAppData.dart';

class ChatAppService {
  static final db = FirebaseFirestore.instance;

  static Stream<QuerySnapshot> read() {
    return db.collection("ChatApp").snapshots();
  }

  // add data in ChatApp
  static Future<void> add() async {
    final chatApp = ChatAppData(
      title: Controller.titleController.text,
      description: Controller.descriptionController.text,
      isCompleted: Controller.isCompleted,
      author: Controller.authorController.text,
    );
    await db.collection("ChatApp").add(chatApp.toMap());
  }

  // update data in ChatApp
  static Future<void> update(ChatAppData chatAppData) async {
    await db
        .collection("ChatApp")
        .doc(chatAppData.id)
        .update({"isCompleted": !chatAppData.isCompleted});
  }

  // delete data in ChatApp
  static Future<void> delete(ChatAppData chatAppData) async {
    await db.collection("ChatApp").doc(chatAppData.id).delete();
  }
}
