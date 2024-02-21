import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hive/hive.dart';
import 'package:martyrlabwork/data/hive.dart';
import 'package:martyrlabwork/models/person.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var nameController = TextEditingController();
  var addressController = TextEditingController();

  void add() async {
    personBox.add(
        Person(name: nameController.text, address: addressController.text));
    setState(() {});
  }

  void delete(int index) async {
    personBox.deleteAt(index);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Firstname'),
            TextField(
              controller: nameController,
              decoration: InputDecoration(border: OutlineInputBorder()),
            ),
            Text('Address'),
            TextField(
              controller: addressController,
              decoration: InputDecoration(border: OutlineInputBorder()),
            ),
            Gap(10),
            ElevatedButton(
              onPressed: add,
              child: Text('Add'),
            ),
            Expanded(
                child: ListView.builder(
              itemCount: personBox.length,
              itemBuilder: (_, index) {
                var person = personBox.getAt(index) as Person;
                return Dismissible(
                  key: UniqueKey(),
                  direction: DismissDirection.endToStart,
                  child: Card(
                    child: ListTile(
                      title: Text(person.name),
                      subtitle: Text(person.address),
                    ),
                  ),
                  onDismissed: (direction) {
                    setState(() {
                      personBox.deleteAt(index);
                    });
                  },
                );
              },
            )),
          ],
        ),
      ),
    );
  }
}
