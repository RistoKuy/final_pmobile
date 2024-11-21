import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GalleryScreen extends StatefulWidget {
  const GalleryScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _GalleryScreenState createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  List<String> _photos = [];
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _fetchPhotos();
  }

  Future<void> _fetchPhotos() async {
    try {
      final response = await http.get(
        Uri.parse('https://pixabay.com/api/?key=47202390-1425d924895558884d51e7a3e&per_page=20'),
      );
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        setState(() {
          _photos = (data['hits'] as List).map((photo) => photo['webformatURL'] as String).toList();
        });
      } else {
        setState(() {
          _errorMessage = 'Failed to load photos';
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to load photos: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gallery'),
        backgroundColor: Colors.black,
      ),
      body: _errorMessage.isNotEmpty
          ? Center(child: Text(_errorMessage, style: const TextStyle(color: Colors.white)))
          : _photos.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 5,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: _photos.length,
                  itemBuilder: (context, index) {
                    return Image.network(_photos[index], fit: BoxFit.cover);
                  },
                ),
    );
  }
}
