import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
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
            SingleChildScrollView(
              child: Column(
                children: [
                  buildTitle(),
                  // const SizedBox(height: 0),
                  buildDescription(context),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTitle() => Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextFormField(
          initialValue: title,
          maxLength: 50,
          autofocus: true,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 26,
          ),
          decoration: const InputDecoration(
            border: InputBorder.none,
            hintText: 'عنوان',
            hintStyle: TextStyle(color: Colors.black54),
            errorStyle: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
            ),
          ),
          validator: (title) => title != null && title.isEmpty
              ? 'عنوان نمی‌تواند خالی باشد!'
              : null,
          onChanged: onChangedTitle,
        ),
      );

  Widget buildDescription(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double witdh = size.width;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: TextFormField(
        initialValue: description,
        maxLines: 10,
        maxLength: 250,
        style: const TextStyle(color: Colors.black, fontSize: 20),
        decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: 'توضیحات',
          hintStyle: TextStyle(color: Colors.black54),
          errorStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 13,
          ),
        ),
        onChanged: onChangedDescription,
      ),
    );
  }
}
