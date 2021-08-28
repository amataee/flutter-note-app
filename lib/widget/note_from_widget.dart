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
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
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
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
          decoration: const InputDecoration(
            border: InputBorder.none,
            hintText: 'عنوان',
            errorStyle: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
            ),
          ),
          validator: (title) => title != null && title.isEmpty
              ? 'عنوان نمی‌تونه خالی باشه!'
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
        decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: 'توضیحات',
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
