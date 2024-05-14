import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CustomRow extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String labelText;
  final bool readOnly;

  const CustomRow({
    super.key,
    required this.controller,
    required this.hintText,
    required this.labelText,
    this.readOnly = false
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
      child: Column(children: [
          Row(children: [
              SizedBox(
                  width: 110,
                  child: Text(labelText, style: const TextStyle(fontSize: 16))
              ),
              Expanded(
                child: TextField(
                  readOnly: readOnly,
                  controller: controller,
                  style: const TextStyle(fontSize: 16),
                  decoration: InputDecoration(
                    hintText: hintText,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
