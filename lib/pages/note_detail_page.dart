import 'package:flutter/material.dart';
import 'package:notesapp2/components/my_back_button.dart';

class NoteDetailPage extends StatelessWidget {
  final String title;
  final String description;
  final DateTime timestamp;
  const NoteDetailPage({
    super.key,
    required this.title,
    required this.description,
    required this.timestamp,
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
            ListTile(
              contentPadding: EdgeInsets.all(0),
              title: Text(
                title,
                style: TextStyle(fontSize: 30, fontFamily: 'DMSerifText'),
              ),
              subtitle: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "${timestamp.month}/"
                    "${timestamp.day}/"
                    "${timestamp.year} "
                    "${timestamp.hour}:"
                    "${timestamp.minute.toString().padLeft(2, "0")}",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                  ),
                ],
              ),
            ),
            Divider(thickness: 0.5),

            //detailed text
            Text(description, style: TextStyle(fontSize: 15)),
          ],
        ),
      ),
    );
  }
}
