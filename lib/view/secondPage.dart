import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lesson12/models/Controllers.dart';
import 'package:flutter_lesson12/services/ChatAppService.dart';

class SecondPage extends StatefulWidget {
  const SecondPage({super.key});

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('This is Second Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: Controller.titleController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Error, title is empty";
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Title',
                  filled: true,
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                maxLines: 8,
                controller: Controller.descriptionController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Error, description is empty";
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Description',
                  filled: true,
                ),
              ),
              CheckboxListTile(
                value: Controller.isCompleted,
                onChanged: (v) {
                  setState(
                    () {
                      Controller.isCompleted = v!;
                    },
                  );
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: Controller.authorController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Error, author is empty";
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Author',
                  filled: true,
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return SimpleDialog(
                            backgroundColor: Colors.white.withOpacity(0.8),
                            title: const Text(
                              "Сиздин маалыматыныз жуктолуудо",
                              textAlign: TextAlign.center,
                            ),
                            children: [
                              CupertinoActivityIndicator(
                                radius: 20,
                                color: Colors.blue.withOpacity(0.8),
                              )
                            ],
                          );
                        });
                    await ChatAppService.add();
                    Navigator.popUntil(context, (route) => route.isFirst);
                  } else {
                    null;
                  }
                },
                icon: const Icon(Icons.arrow_upward),
                label: const Text(
                  'Save',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
