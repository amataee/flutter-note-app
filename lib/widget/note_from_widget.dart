import 'package:flutter/material.dart';

class NoteFormWidget extends StatelessWidget {
  final bool? isImportant;
  final int? number;
  final String? title;
  final String? description;
  final ValueChanged<bool> onChangedImportant;
  final ValueChanged<int> onChangedNumber;
  final ValueChanged<String> onChangedTitle;
  final ValueChanged<String> onChangedDescription;

  const NoteFormWidget({
    Key? key,
    this.isImportant = false,
    this.number = 0,
    this.title = '',
    this.description = '',
    required this.onChangedImportant,
    required this.onChangedNumber,
    required this.onChangedTitle,
    required this.onChangedDescription,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // TODO: Complete the priority feature!
              // Text(
              //   'Is It Important? Set the Priority:',
              //   style: TextStyle(color: Colors.white, fontSize: 16),
              // ),
              Row(
                children: [
                  // Switch(
                  //   value: isImportant ?? false,
                  //   onChanged: onChangedImportant,
                  //   activeColor: Colors.white,
                  // ),
                  // Expanded(
                  //   child: Slider(
                  //     activeColor: Colors.white,
                  //     inactiveColor: Colors.black54,
                  //     value: (number ?? 0).toDouble(),
                  //     min: 0,
                  //     max: 5,
                  //     divisions: 5,
                  //     onChanged: (number) => onChangedNumber(number.toInt()),
                  //   ),
                  // )
                ],
              ),
              buildTitle(),
              SizedBox(height: 8),
              buildDescription(),
              SizedBox(height: 16),
            ],
          ),
        ),
      );

  Widget buildTitle() => TextFormField(
        maxLines: 1,
        initialValue: title,
        maxLength: 50,
        autofocus: true,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 26,
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'Title',
          hintStyle: TextStyle(color: Colors.white70),
          errorStyle: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        validator: (title) => title != null && title.isEmpty
            ? 'The title cannot be empty!'
            : null,
        onChanged: onChangedTitle,
      );

  Widget buildDescription() => TextFormField(
        maxLines: 5,
        initialValue: description,
        maxLength: 250,
        style: TextStyle(color: Colors.white, fontSize: 20),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'Type something...',
          hintStyle: TextStyle(color: Colors.white70),
          errorStyle: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        validator: (title) => title != null && title.isEmpty
            ? 'The description cannot be empty!'
            : null,
        onChanged: onChangedDescription,
      );
}
