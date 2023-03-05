import 'package:flutter/material.dart';

class MyDropdownButton extends StatefulWidget {
  const MyDropdownButton({super.key});

  @override
  _MyDropdownButtonState createState() => _MyDropdownButtonState();
}

class _MyDropdownButtonState extends State<MyDropdownButton> {
  String _selectedOption = 'Flutter';

  /// Set a default value.

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      items: <String>['Flutter', 'Swift', 'UI / UX'].map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(value: value, child: Text(value));
      }).toList(),
      value: _selectedOption,
      hint: const Text('Select an option'),
      onChanged: (newValue) {
        setState(() {
          _selectedOption = newValue!;
        });
        print(newValue);
      },
      style: const TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.normal),
      icon: const Icon(
        Icons.arrow_drop_down,
      ),
    );
  }
}
