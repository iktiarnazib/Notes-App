import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notesapp2/components/my_back_button.dart';
import 'package:notesapp2/components/my_key_button.dart';
import 'package:notesapp2/components/my_style_button.dart';
import 'package:notesapp2/models/note_database.dart';

class NoteDetailPage extends ConsumerStatefulWidget {
  final String title;
  final String description;
  final DateTime timestamp;
  final int id;
  const NoteDetailPage({
    super.key,
    required this.title,
    required this.description,
    required this.timestamp,
    required this.id,
  });

  @override
  ConsumerState<NoteDetailPage> createState() => _NoteDetailPageState();
}

class _NoteDetailPageState extends ConsumerState<NoteDetailPage> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  //update a note
  void onEditPressed({
    required int id,
    required String oldText,
    required String oldDescription,
  }) {
    titleController.text = oldText;
    descriptionController.text = oldDescription;
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).colorScheme.surface,
          title: Text('Edit note', style: TextStyle(fontFamily: 'DMSerifText')),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  style: TextStyle(fontFamily: 'DMSerifText'),
                  //min line 1
                  //max line 5
                  //keyboardinput inputtextype multiline
                  minLines: 1,
                  maxLines: 3,
                  keyboardType: TextInputType.multiline,
                  controller: titleController,
                  autofocus: true,
                  decoration: InputDecoration(
                    hintText: 'Add more details here',
                    hintStyle: TextStyle(
                      fontFamily: 'DMSerifText',
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.inversePrimary,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                TextFormField(
                  style: TextStyle(fontFamily: 'DMSerifText'),
                  //min line 1
                  //max line 5
                  //keyboardinput inputtextype multiline
                  minLines: 4,
                  maxLines: 6,
                  keyboardType: TextInputType.multiline,
                  controller: descriptionController,
                  autofocus: true,
                  decoration: InputDecoration(
                    hintText: 'Add more details here',
                    hintStyle: TextStyle(
                      fontFamily: 'DMSerifText',
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.inversePrimary,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            //Cancel Button
            MaterialButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Cancel',
                style: TextStyle(
                  fontFamily: 'DMSerifText',
                  fontSize: 16,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
              ),
            ),

            //Save Button
            MyKeyButton(
              text: 'Save',
              onPressed: () {
                ref
                    .read(noteProvider.notifier)
                    .updateNote(
                      id: id,
                      newText: titleController.text.trim(),
                      newSubText: descriptionController.text.trim(),
                      timeStamp: DateTime.now(),
                    );
                if (mounted) {
                  Navigator.pop(context);
                }
                if (mounted) {
                  Navigator.pop(context);
                }
              },
              backgroundColor: Colors.green.shade800,
              foregroundColor: Colors.white,
            ),
          ],
        );
      },
    );
  }

  //delete note
  void onDeletePressed(int id) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).colorScheme.primary,
          title: Text('Delete the note?'),
          content: Text("Are you sure you want to delete this note?"),
          actions: [
            //Cancel button
            MyKeyButton(
              text: 'Cancel',
              onPressed: () => Navigator.pop(context),
              backgroundColor: null,
              foregroundColor: Theme.of(context).colorScheme.inversePrimary,
            ),
            MyKeyButton(
              text: 'Delete',
              onPressed: () {
                ref.read(noteProvider.notifier).deleteNote(id);
                if (mounted) {
                  Navigator.pop(context);
                }
                if (mounted) {
                  Navigator.pop(context);
                }
              },
              backgroundColor: Colors.red.shade400,
              foregroundColor: Colors.white,
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Note Details',
          style: TextStyle(fontFamily: 'DMSerifText'),
        ),
        automaticallyImplyLeading: false,
        leading: Padding(
          padding: const EdgeInsets.only(left: 12.0),
          child: MyBackButton(),
        ),
        actions: [
          MyStyleButton(
            onTap: () => onDeletePressed(widget.id),
            icon: Icons.delete,
            iconColor: Colors.red.shade400,
          ),
          SizedBox(width: 5),
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: MyStyleButton(
              icon: Icons.edit,
              iconColor: Theme.of(context).colorScheme.inversePrimary,
              onTap: () => onEditPressed(
                id: widget.id,
                oldText: widget.title,
                oldDescription: widget.description,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: ListView(
          children: [
            ListTile(
              contentPadding: EdgeInsets.all(0),
              title: Text(
                widget.title,
                style: TextStyle(fontSize: 30, fontFamily: 'DMSerifText'),
              ),
              subtitle: Text(
                "${widget.timestamp.month}/"
                "${widget.timestamp.day}/"
                "${widget.timestamp.year} "
                "${widget.timestamp.hour}:"
                "${widget.timestamp.minute.toString().padLeft(2, "0")}",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.tertiary,
                  fontFamily: 'DMSerifText',
                ),
              ),
            ),
            Divider(thickness: 0.5),

            //detailed text
            Text(
              widget.description,
              style: TextStyle(fontSize: 17, fontFamily: 'DMSerifText'),
            ),
          ],
        ),
      ),
    );
  }
}
