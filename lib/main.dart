import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DogImageWidget(),
    );
  }
}

class DogImageWidget extends StatefulWidget {
  @override
  _DogImageWidgetState createState() => _DogImageWidgetState();
}

class _DogImageWidgetState extends State<DogImageWidget> {
  String imageUrl = '';

  Future<void> fetchDogImage() async {
    final response = await http.get(Uri.parse('https://dog.ceo/api/breeds/image/random'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      setState(() {
        imageUrl = data['message'];
      });
    } else {
      throw Exception('Failed to load dog image');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchDogImage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Random Dog Image'),
      ),
      body: Center(
        child: imageUrl.isNotEmpty
            ? Image.network(
          imageUrl,
          width: 300,
          height: 300,
          fit: BoxFit.cover,
        )
            : CircularProgressIndicator(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          fetchDogImage();
        },
        child: Icon(Icons.refresh),
      ),
    );
  }
}
