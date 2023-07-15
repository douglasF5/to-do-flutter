import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/auth.dart';

class HomeScreen extends StatefulWidget {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  const HomeScreen({required this.auth, required this.firestore, super.key});

  @override
  State<HomeScreen> createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  final TextEditingController _todoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('To-do\'s'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        actions: [
          IconButton(
            key: const ValueKey('signOut'),
            icon: const Icon(Icons.exit_to_app),
            onPressed: () {
              Auth(auth: widget.auth).signOut();
            },
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DecoratedBox(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
            ),
            child: Padding(
              padding:
                  const EdgeInsets.only(left: 24.0, right: 24.0, bottom: 16.0),
              child: Stack(
                children: [
                  Positioned(
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 10.0,
                          top: 4.0,
                          bottom: 4.0,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                key: const ValueKey("addField"),
                                controller: _todoController,
                                decoration: const InputDecoration(
                                    border: InputBorder.none),
                              ),
                            ),
                            IconButton(
                              key: const ValueKey("addButton"),
                              icon: const Icon(Icons.add),
                              onPressed: () {
                                // if (_todoController.text != "") {
                                //   setState(() {
                                //     Database(firestore: widget.firestore).addTodo(
                                //         uid: widget.auth.currentUser.uid,
                                //         content: _todoController.text);
                                //     _todoController.clear();
                                //   });
                                // }
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 24.0, right: 24.0, bottom: 24.0),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Tasks",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                // Expanded(
                //   child: StreamBuilder(
                //     stream: Database(firestore: widget.firestore)
                //         .streamTodos(uid: widget.auth.currentUser.uid),
                //     builder: (BuildContext context,
                //         AsyncSnapshot<List<TodoModel>> snapshot) {
                //       if (snapshot.connectionState == ConnectionState.active) {
                //         if (snapshot.data.isEmpty) {
                //           return const Center(
                //             child: Text("You don't have any unfinished Todos"),
                //           );
                //         }
                //         return ListView.builder(
                //           itemCount: snapshot.data.length,
                //           itemBuilder: (_, index) {
                //             return TodoCard(
                //               firestore: widget.firestore,
                //               uid: widget.auth.currentUser.uid,
                //               todo: snapshot.data[index],
                //             );
                //           },
                //         );
                //       } else {
                //         return const Center(
                //           child: Text("loading..."),
                //         );
                //       }
                //     },
                //   ),
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
