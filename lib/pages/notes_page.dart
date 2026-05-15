import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notesapp2/components/my_drawer.dart';
import 'package:notesapp2/components/my_key_button.dart';
import 'package:notesapp2/components/note_tile.dart';
import 'package:notesapp2/models/note_database.dart';
import 'package:notesapp2/pages/note_detail_page.dart';
import 'package:notesapp2/themes/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotesPage extends ConsumerStatefulWidget {
  const NotesPage({super.key});

  @override
  ConsumerState<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends ConsumerState<NotesPage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController titleController2 = TextEditingController();

  TextEditingController descriptionController = TextEditingController();
  TextEditingController descriptionController2 = TextEditingController();
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
                        hintText: 'Add a note',
                        hintStyle: TextStyle(
                          fontFamily: 'DMSerifText',
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
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
                    if (errorText.isNotEmpty)
                      Text(errorText, style: TextStyle(color: Colors.red)),
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
                    if (errorText.isNotEmpty)
                      Text(errorText, style: TextStyle(color: Colors.red)),
                  ],
                ),
              ),

              actions: [
                //Cancel Button
                MaterialButton(
                  onPressed: () {
                    setState(() {
                      errorText = '';
                    });
                    titleController.clear();
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
                    if (titleController.text.trim().isEmpty) {
                      setState(() {
                        errorText = 'Please enter a text';
                      });
                    } else {
                      ref
                          .read(noteProvider.notifier)
                          .addNote(
                            noteText: titleController.text.trim(),
                            noteSubText: descriptionController.text.trim(),
                          );
                      Navigator.pop(context);
                      titleController.clear();
                      descriptionController.clear();
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
  void onEditPressed(int id, String oldText, String oldDescription) {
    titleController2.text = oldText;
    descriptionController2.text = oldDescription;
    descriptionController2.selection = TextSelection.fromPosition(
      TextPosition(offset: descriptionController2.text.length),
    );
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
                  controller: titleController2,

                  decoration: InputDecoration(
                    hintText: 'Edit Your Title',
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

                  controller: descriptionController2,
                  autofocus: true,
                  decoration: InputDecoration(
                    hintText: 'Edit your description',
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
            MyKeyButton(
              text: 'Save',
              onPressed: () {
                ref
                    .read(noteProvider.notifier)
                    .updateNote(
                      id: id,
                      newText: titleController2.text.trim(),
                      newSubText: descriptionController2.text.trim(),
                      timeStamp: DateTime.now(),
                    );
                if (mounted) {
                  Navigator.pop(context);
                }
              },
              backgroundColor: Colors.green.shade800,
              foregroundColor: Colors.white,
            ),
            /*
            //Save Button
            FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: Colors.green.shade800,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              onPressed: () {
                ref
                    .read(noteProvider.notifier)
                    .updateNote(
                      id: id,
                      newText: titleController2.text.trim(),
                      newSubText: descriptionController2.text.trim(),
                      timeStamp: DateTime.now(),
                    );
                if (mounted) {
                  Navigator.pop(context);
                }
              },

              child: Text(
                'Save',
                style: TextStyle(fontFamily: 'DMSerifText', fontSize: 16),
              ),
            ),
            */
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
          title: Text(
            'Delete the note?',
            style: TextStyle(fontFamily: 'DMSerifText'),
          ),
          content: Text(
            "Are you sure you want to delete this note?",
            style: TextStyle(fontFamily: 'DMSerifText'),
          ),
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
                Navigator.pop(context);
              },
              backgroundColor: Colors.red.shade400,
              foregroundColor: Colors.white,
            ),
            // //delete button
            // MaterialButton(
            //   onPressed: () {
            //     ref.read(noteProvider.notifier).deleteNote(id);
            //     Navigator.pop(context);
            //   },
            //   child: Text(
            //     'Delete',
            //     style: TextStyle(color: Colors.red, fontFamily: 'DMSerifText'),
            //   ),
            // ),
          ],
        );
      },
    );
  }

  void onSwitchPressed() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (ref.read(themeProvider) == lightMode) {
      ref.read(themeProvider.notifier).state = darkMode;

      await prefs.setBool('lightmode', false);
    } else {
      ref.read(themeProvider.notifier).state = lightMode;
      await prefs.setBool('lightmode', true);
    }
  }

  @override
  Widget build(BuildContext context) {
    //read the notes
    final notes = ref.watch(noteProvider);
    final themeMode = ref.watch(themeProvider);
    bool themeDark = themeMode == darkMode;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        actions: [
          Text(!themeDark ? 'Light Mode' : 'Dark Mode'),
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: IconButton(
              icon: !themeDark ? Icon(Icons.sunny) : Icon(Icons.dark_mode),
              onPressed: onSwitchPressed,
            ),
          ),
        ],
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
                              id: notes[index].id,
                              title: notes[index].noteText,
                              description: notes[index].noteSubText,
                              timestamp: notes[index].timestamp,
                            ),
                          ),
                        ),

                        text: notes[index].noteText,
                        subText: notes[index].noteSubText,
                        timestamp: notes[index].timestamp,
                        onEditPressed: () {
                          onEditPressed(
                            notes[index].id,
                            notes[index].noteText,
                            notes[index].noteSubText,
                          );
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
        child: FloatingActionButton.extended(
          label: Text(
            'Add a note',
            style: TextStyle(
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
          ),
          backgroundColor: Theme.of(context).colorScheme.primary,
          onPressed: onActionButtonPressed,
          icon: Icon(
            Icons.add,
            color: Theme.of(context).colorScheme.inversePrimary,
          ),
        ),
      ),
    );
  }
}
