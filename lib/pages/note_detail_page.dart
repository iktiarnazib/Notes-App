import 'package:flutter/material.dart';
import 'package:notesapp2/components/my_back_button.dart';

class NoteDetailPage extends StatelessWidget {
  final String title;
  final String description;
  const NoteDetailPage({
    super.key,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Note Details'),
        automaticallyImplyLeading: false,
        leading: Padding(
          padding: const EdgeInsets.only(left: 12.0),
          child: MyBackButton(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: ListView(
          children: [
            //title
            Text(
              title,
              style: TextStyle(fontFamily: "DMSerifText", fontSize: 30),
              softWrap: true,
            ),
            Divider(thickness: 0.5),

            //detailed text
            Text(description),
          ],
        ),
      ),
    );
  }
}
