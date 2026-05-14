import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notesapp2/components/my_drawer.dart';
import 'package:notesapp2/components/note_tile.dart';
import 'package:notesapp2/models/note_database.dart';
import 'package:notesapp2/pages/note_detail_page.dart';

class NotesPage extends ConsumerStatefulWidget {
  const NotesPage({super.key});

  @override
  ConsumerState<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends ConsumerState<NotesPage> {
  TextEditingController textController = TextEditingController();
  TextEditingController textController2 = TextEditingController();
  var errorText = '';
  //create a note
  void onActionButtonPressed() {
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, setState) {
            return AlertDialog(
              title: Text(
                'Add a note',
                style: TextStyle(
                  fontFamily: "DMSerifText",
                  fontStyle: FontStyle.normal,
                ),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    style: TextStyle(fontFamily: 'DMSerifText'),
                    //min line 1
                    //max line 5
                    //keyboardinput inputtextype multiline
                    minLines: 1,
                    maxLines: 5,
                    keyboardType: TextInputType.multiline,
                    controller: textController,
                    autofocus: true,
                    decoration: InputDecoration(
                      hintText: 'Add a note',
                      hintStyle: TextStyle(
                        fontFamily: 'DMSerifText',
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  if (errorText.isNotEmpty)
                    Text(errorText, style: TextStyle(color: Colors.red)),
                ],
              ),

              actions: [
                //Cancel Button
                MaterialButton(
                  onPressed: () {
                    setState(() {
                      errorText = '';
                    });
                    textController.clear();
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: "DMSerifText",
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                ),

                //Save Button
                MaterialButton(
                  onPressed: () {
                    if (textController.text.trim().isEmpty) {
                      setState(() {
                        errorText = 'Please enter a text';
                      });
                    } else {
                      ref
                          .read(noteProvider.notifier)
                          .addNote(textController.text.trim());
                      Navigator.pop(context);
                      textController.clear();
                      errorText = '';
                    }
                  },
                  child: Text(
                    'Save',
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 16,
                      fontFamily: "DMSerifText",
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  //update a note
  void onEditPressed(int id, String oldText) {
    textController2.text = oldText;
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).colorScheme.surface,
          title: Text('Edit your note'),
          content: TextFormField(
            minLines: 1,
            maxLines: 5,
            keyboardType: TextInputType.multiline,
            controller: textController2,
            autofocus: true,
            decoration: InputDecoration(
              hint: Text(
                'Edit the text...',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          actions: [
            //Cancel Button
            MaterialButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),

            //Save Button
            MaterialButton(
              onPressed: () {
                ref
                    .read(noteProvider.notifier)
                    .updateNote(id, textController2.text.trim());
                Navigator.pop(context);
                textController2.clear();
              },
              child: Text('Save', style: TextStyle(color: Colors.green)),
            ),
          ],
        );
      },
    );
  }

  //delete a note
  void onDeletePressed(int id, String note) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).colorScheme.primary,
          title: Text('Delete the note?'),
          content: Text("Are you sure you want to delete this note?"),
          actions: [
            //Cancel button
            MaterialButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),

            //yes button
            MaterialButton(
              onPressed: () {
                ref.read(noteProvider.notifier).deleteNote(id);
                Navigator.pop(context);
              },
              child: Text('Delete', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    //read the notes
    final notes = ref.watch(noteProvider);
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Theme.of(context).colorScheme.inversePrimary,
        ),
      ),
      drawer: MyDrawer(
        onTap: () {
          Navigator.pop(context);
        },
      ),
      body: notes.isEmpty
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 25.0),
                  child: Text(
                    'Notes',
                    style: TextStyle(
                      fontFamily: "DMSerifText",
                      fontSize: 48,
                      color: Theme.of(context).colorScheme.inversePrimary,
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      'Try adding a note...',
                      style: TextStyle(
                        fontFamily: "DMSerifText",
                        fontSize: 16,
                        color: Theme.of(context).colorScheme.inversePrimary,
                      ),
                    ),
                  ),
                ),
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 25.0),
                  child: Text(
                    'Notes',
                    style: TextStyle(
                      fontFamily: "DMSerifText",
                      fontSize: 48,
                      color: Theme.of(context).colorScheme.inversePrimary,
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: notes.length,
                    itemBuilder: (BuildContext context, int index) {
                      return NoteTile(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => NoteDetailPage(
                              title: notes[index].noteText,
                              description: notes[index].noteText,
                            ),
                          ),
                        ),

                        text: notes[index].noteText,
                        subText: notes[index].noteText,
                        timestamp: notes[index].timestamp,
                        onEditPressed: () {
                          onEditPressed(notes[index].id, notes[index].noteText);
                        },
                        onDeletePressed: () => onDeletePressed(
                          notes[index].id,
                          notes[index].noteText,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(right: 20.0),
        child: FloatingActionButton(
          backgroundColor: Theme.of(context).colorScheme.secondary,
          onPressed: onActionButtonPressed,
          child: Icon(
            Icons.add,
            color: Theme.of(context).colorScheme.inversePrimary,
          ),
        ),
      ),
    );
  }
}
