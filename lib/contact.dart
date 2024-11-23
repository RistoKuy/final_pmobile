import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ContactListScreen extends StatefulWidget {
  const ContactListScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ContactListScreenState createState() => _ContactListScreenState();
}

class _ContactListScreenState extends State<ContactListScreen> {
  List<Map<String, String>> contacts = [];
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _fetchContacts();
  }

  Future<void> _fetchContacts() async {
    try {
      final response = await http.get(
        Uri.parse('https://picsum.photos/v2/list?limit=6'),
      );
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        setState(() {
          contacts = data.map((photo) {
            return {
              'name': 'Contact ${photo['id']}',
              'email': 'contact${photo['id']}@example.com',
              'imageUrl': photo['download_url'] as String,
            };
          }).toList();
        });
      } else {
        setState(() {
          _errorMessage = 'Failed to load contacts';
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to load contacts: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact'),
        backgroundColor: Colors.black,
      ),
      body: _errorMessage.isNotEmpty
          ? Center(child: Text(_errorMessage, style: const TextStyle(color: Colors.white)))
          : ListView.builder(
              itemCount: contacts.length,
              itemBuilder: (context, index) {
                final contact = contacts[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(contact['imageUrl']!),
                  ),
                  title: Text(contact['name']!),
                  subtitle: Text(contact['email']!),
                );
              },
            ),
    );
  }
}
