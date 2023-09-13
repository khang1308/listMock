import 'package:flutter/material.dart';
import 'package:todolist/class.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController descController = TextEditingController();

  var listMock = [
    MockTodo(name: 'A', desc: 'A1'),
    MockTodo(name: 'B', desc: '1')
  ];

  int selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ListMock'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                  hintText: 'title',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)))),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: descController,
              decoration: const InputDecoration(
                  hintText: 'content',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)))),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    String name = nameController.text.trim();
                    String desc = descController.text.trim();
                    if (name.isNotEmpty && desc.isNotEmpty) {
                      setState(() {
                        listMock.add(MockTodo(name: name, desc: desc));
                      });
                    }
                  },
                  child: const Text('Add'),
                ),
                ElevatedButton(
                  onPressed: () {
                    String name = nameController.text.trim();
                    String desc = descController.text.trim();
                    if (name.isNotEmpty && desc.isNotEmpty)
                      setState(() {
                       nameController.text = '';
                        descController.text = '';
                        listMock[selectedIndex].name = name;
                        listMock[selectedIndex].desc = desc;
                        selectedIndex = -1;
                      });
                  },
                  child: const Text('Save'),
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: listMock.length,
                itemBuilder: (context, index) => getRow(index),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget getRow(int index) {
    return ListTile(
      title: Container(
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            border: Border.all(color: Colors.black)),
        width: 50,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(listMock[index].name),
                      Text(listMock[index].desc),
                    ]),
              ),
              SizedBox(
                child: Row(
                  children: [
                    InkWell(
                        onTap: () {
                          nameController.text = listMock[index].name;
                          descController.text = listMock[index].desc;
                          setState(() {
                            selectedIndex = index;
                          });
                        },
                        child: const Icon(Icons.edit)),
                    InkWell(
                        onTap: () {
                          setState(() {
                            listMock.removeAt(index);
                          });
                        },
                        child: const Icon(Icons.delete_forever_rounded)),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
