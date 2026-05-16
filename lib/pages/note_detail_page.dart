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

  late String currentTitle;
  late String currentDescrition;
  late DateTime currentTime;

  @override
  void initState() {
    currentTitle = widget.title;
    currentDescrition = widget.description;
    currentTime = widget.timestamp;
    super.initState();
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

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
                  autofocus: isTitle ? true : false,
                  decoration: InputDecoration(
                    hintText: 'Edit your title',
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
                  autofocus: isTitle ? false : true,
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
                setState(() {
                  currentTitle = titleController.text.trim();
                  currentDescrition = descriptionController.text.trim();
                  currentTime = DateTime.now();
                });
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

  bool isTitle = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Note Details',
          style: TextStyle(fontFamily: 'DMSerifText'),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: Padding(
          padding: const EdgeInsets.only(left: 12.0),
          child: MyBackButton(),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: MyStyleButton(
              icon: Icons.delete,
              iconColor: Colors.red.shade300,
              onTap: () => onDeletePressed(widget.id),
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
              title: GestureDetector(
                onTap: () {
                  setState(() {
                    isTitle = true;
                  });
                  onEditPressed(
                    id: widget.id,
                    oldText: currentTitle,
                    oldDescription: currentDescrition,
                  );
                },
                child: Text(
                  currentTitle,
                  style: TextStyle(fontSize: 30, fontFamily: 'DMSerifText'),
                ),
              ),
              subtitle: Text(
                "${currentTime.month}/"
                "${currentTime.day}/"
                "${currentTime.year} "
                "${currentTime.hour.toString().padLeft(2, "0")}:"
                "${currentTime.minute.toString().padLeft(2, "0")}",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.tertiary,
                  fontFamily: 'DMSerifText',
                ),
              ),
            ),
            Divider(thickness: 0.5),

            //detailed text
            currentDescrition.isEmpty
                ? GestureDetector(
                    onTap: () {
                      setState(() {
                        isTitle = false;
                      });
                      onEditPressed(
                        id: widget.id,
                        oldText: currentTitle,
                        oldDescription: currentDescrition,
                      );
                    },
                    child: Text(
                      'Click here to add a description',
                      style: TextStyle(
                        fontSize: 17,
                        fontFamily: 'DMSerifText',
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                  )
                : GestureDetector(
                    onTap: () {
                      setState(() {
                        isTitle = false;
                      });
                      onEditPressed(
                        id: widget.id,
                        oldText: currentTitle,
                        oldDescription: currentDescrition,
                      );
                    },
                    child: Text(
                      currentDescrition,
                      style: TextStyle(fontSize: 17, fontFamily: 'DMSerifText'),
                    ),
                  ),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(right: 20.0),
        child: FloatingActionButton.extended(
          label: Text(
            'Edit',
            style: TextStyle(
              color: Colors.green.shade600,
              fontWeight: FontWeight.w800,
              fontFamily: 'DMSerifText',
            ),
          ),
          backgroundColor: Theme.of(context).colorScheme.primary,
          onPressed: () => onEditPressed(
            id: widget.id,
            oldText: currentTitle,
            oldDescription: currentDescrition,
          ),
          icon: Icon(Icons.edit, color: Colors.green.shade700),
        ),
      ),
    );
  }
}
