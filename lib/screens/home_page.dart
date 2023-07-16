import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/todo.dart';
import '../services/auth.dart';
import '../services/database.dart';
import '../widgets/to_do_card.dart';

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
        toolbarHeight: 72.0,
        title: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(
            'Tasks',
            textAlign: TextAlign.start,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onPrimary,
                  fontWeight: FontWeight.w700,
                ),
          ),
        ),
        centerTitle: false,
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: IconButton(
              key: const ValueKey('signOut'),
              icon: const Icon(Icons.exit_to_app),
              onPressed: () {
                Auth(auth: widget.auth).signOut();
              },
            ),
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
                                if (_todoController.text != "") {
                                  setState(() {
                                    Database(firestore: widget.firestore)
                                        .addToDo(
                                            uid: widget.auth.currentUser!.uid,
                                            title: _todoController.text);
                                    _todoController.clear();
                                  });
                                }
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
          Padding(
            padding:
                const EdgeInsets.only(left: 24.0, right: 24.0, bottom: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Flexible(
                  fit: FlexFit.loose,
                  child: StreamBuilder(
                    stream: Database(firestore: widget.firestore)
                        .streamToDos(uid: widget.auth.currentUser!.uid),
                    builder: (BuildContext context,
                        AsyncSnapshot<List<ToDoModel>> snapshot) {
                      if (snapshot.connectionState == ConnectionState.active) {
                        if (snapshot.data == null) {
                          return const Align(
                            alignment: Alignment.topLeft,
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 8.0),
                              child:
                                  Text("You don't have any unfinished Tasks"),
                            ),
                          );
                        }
                        return ListView.builder(
                          padding: const EdgeInsets.symmetric(vertical: 12.0),
                          shrinkWrap: true,
                          itemCount: snapshot.data!.length,
                          itemBuilder: (_, index) {
                            return ToDoCard(
                              firestore: widget.firestore,
                              uid: widget.auth.currentUser!.uid,
                              toDo: snapshot.data![index],
                            );
                          },
                        );
                      } else {
                        return const Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text("Loading..."),
                          ),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
