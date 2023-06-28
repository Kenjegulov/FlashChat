import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lesson12/models/ChatAppData.dart';
import 'package:flutter_lesson12/services/ChatAppService.dart';
import 'package:flutter_lesson12/view/secondPage.dart';

class ChatApp extends StatefulWidget {
  const ChatApp({super.key});

  @override
  State<ChatApp> createState() => ChatAppState();
}

class ChatAppState extends State<ChatApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ChatApp'),
      ),
      body: StreamBuilder(
        stream: ChatAppService.read(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child: CupertinoActivityIndicator(
              radius: 25,
            ));
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          } else if (snapshot.hasData) {
            final List<ChatAppData> chatAppData = snapshot.data!.docs
                .map((e) =>
                    ChatAppData.fromMap(e.data() as Map<String, dynamic>)
                      ..id = e.id)
                .toList();
            return ListView.builder(
              itemCount: chatAppData.length,
              itemBuilder: (context, index) {
                final chat = chatAppData[index];
                return Card(
                  child: ListTile(
                    leading: Text(chat.title),
                    title: Text(chat.description),
                    subtitle: Text(chat.author),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Checkbox(
                          value: chat.isCompleted,
                          onChanged: (v) async {
                            await ChatAppService.update(chat);
                          },
                        ),
                        IconButton(
                            onPressed: () async {
                              await ChatAppService.delete(chat);
                            },
                            icon: const Icon(Icons.delete))
                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            return const Text("Error");
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.purple,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SecondPage()),
            );
          }),
    );
  }
}
