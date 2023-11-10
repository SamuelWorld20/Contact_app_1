import 'package:flutter/material.dart';
import 'package:faker/faker.dart';
import './/data/contact.dart';

class ContactsListPage extends StatefulWidget {
  @override
  State<ContactsListPage> createState() => _ContactsListState();
}

class _ContactsListState extends State<ContactsListPage> {
  late List<Contact> _contacts = [];

  // Runs when the widget is initialized
  @override
  void initState() {
    super.initState();
    _contacts = List.generate(
      50,
      (index) => Contact(
        name: Faker().person.firstName() + ' ' + Faker().person.lastName(),
        email: Faker().internet.freeEmail(),
        phoneNumber: Faker().randomGenerator.integer(1000000).toString(),
      ),
    );
  }

  // build() runs when the state changes
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contacts'),
      ),
      body: ListView.builder(
        itemCount: _contacts.length,
        itemBuilder: (context, index) => ListTile(
          title: Text(_contacts[index].name),
          subtitle: Text(_contacts[index].email),
          trailing: IconButton(
            icon: Icon(
              _contacts[index].isFavorite ? Icons.star : Icons.star_border,
              color: _contacts[index].isFavorite ? Colors.amber : Colors.grey,
            ),
            onPressed: () {
              setState(() {
                _contacts[index].isFavorite = !_contacts[index].isFavorite;
                // Takes in a higher order function which gets passed two contacts
                _contacts.sort((a, b) {
                  if (a.isFavorite) {
                    // contactOne will be BEFORE contactTwo
                    return -1;
                  } else if (b.isFavorite) {
                    // contactOne will be AFTER contactTwo
                    return 1;
                  } else {
                    // the position doesn't change
                    return 0;
                  }
                });
              });
            },
          ),
        ),
      ),
    );
  }
}
