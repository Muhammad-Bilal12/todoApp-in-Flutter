import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

List<String> _addTodo = [];

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController addTodoController = TextEditingController();
  TextEditingController editTodoController = TextEditingController();

  addTodof() {
    setState(() {
      _addTodo.add(addTodoController.text);
      addTodoController.clear();
    });
  }

  removeNotes(i) {
    _addTodo.removeAt(i);
  }

  editTodo(i) {
    _addTodo[i] = editTodoController.text;
    editTodoController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(
          Icons.check_box_outlined,
          size: 40,
          color: Colors.white,
        ),
        title: const Text(
          "MyTodo",
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 8),
              width: MediaQuery.of(context).size.width * 1,
              height: MediaQuery.of(context).size.height * 0.08,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: addTodoController,
                        decoration: const InputDecoration(
                          hintText: "ADD TODO",
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.blue.shade600,
                      ),
                      child: Center(
                        child: IconButton(
                          onPressed: () {
                            addTodof();
                          },
                          icon: const Icon(
                            Icons.add,
                            size: 25,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.all(8.0),
              height: MediaQuery.of(context).size.height * 0.7,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
                borderRadius: BorderRadius.circular(20),
              ),
              child: ListView.builder(
                itemCount: _addTodo.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    trailing: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.3,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                  title: const Text("Edit Todo"),
                                  content: TextField(
                                    decoration: const InputDecoration(
                                        hintText: "Edit Your Todo"),
                                    controller: editTodoController,
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        setState(() {
                                          editTodo(index);
                                          Navigator.pop(context, "Edit");
                                        });
                                      },
                                      child: const Text("Edit"),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context, 'Cancel');
                                      },
                                      child: const Text("Cancel"),
                                    ),
                                  ],
                                ),
                              );
                            },
                            icon: Icon(
                              Icons.edit_note,
                              color: Colors.blue[600],
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                removeNotes(index);
                              });
                            },
                            icon: Icon(
                              Icons.delete,
                              color: Colors.blue[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                    title: Container(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      child: Text("${_addTodo[index]} "),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
