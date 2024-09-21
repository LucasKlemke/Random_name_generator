import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(RandomNameGeneratorApp());
}

class RandomNameGeneratorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: RandomNameGeneratorScreen(),
    );
  }
}

class RandomNameGeneratorScreen extends StatefulWidget {
  @override
  _RandomNameGeneratorScreenState createState() => _RandomNameGeneratorScreenState();
}

class _RandomNameGeneratorScreenState extends State<RandomNameGeneratorScreen> {
  final TextEditingController _nameController = TextEditingController();
  final List<String> _names = [];
  String? _randomName;

  void _addName() {
    if (_nameController.text.isNotEmpty) {
      setState(() {
        _names.add(_nameController.text);
        _nameController.clear();
      });
    }
  }

  void _generateRandomName() {
    if (_names.isNotEmpty) {
      final random = Random();
      setState(() {
        _randomName = _names[random.nextInt(_names.length)];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Random Name Generator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Enter a name',
                suffixIcon: IconButton(
                  icon: Icon(Icons.add),
                  onPressed: _addName,
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _generateRandomName,
              child: Text('Generate Random Name'),
            ),
            SizedBox(height: 20),
            if (_randomName != null)
              Text(
                'Random Name: $_randomName',
                style: TextStyle(fontSize: 24),
              ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _names.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_names[index]),
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