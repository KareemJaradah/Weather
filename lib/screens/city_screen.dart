import 'package:flutter/material.dart';

class CityScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TextEditingController _cityController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text('Add City'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _cityController,
              decoration: InputDecoration(
                labelText: 'City Name',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_cityController.text.isNotEmpty) {
                  Navigator.pop(context, _cityController.text);
                }
              },
              child: Text('Add City'),
            ),
          ],
        ),
      ),
    );
  }
}
