import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../const/background.dart';
import '../models/idea_model.dart';
import '../widgets/text_field.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({super.key});

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  List<String> _listIdeas = [];
  final TextEditingController _ideaController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadIdeas();
  }

  void clearText() {
    _ideaController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent.shade700,
        title: const Text('My unique ideas'),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          background(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 45, horizontal: 20),
            child: Column(
              children: [
                customTextField(
                  hintText: 'write an idea',
                  controller: _ideaController,
                  onSubmitted: ((value) {
                    setState(() {
                      if (_ideaController.text.isNotEmpty) {
                        setState(() {
                          addIdea(value);
                          _ideaController.clear();
                        });
                      }
                    });
                  }),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: _listIdeas.length,
                    itemBuilder: (context, index) {
                      return Card(
                        elevation: 8,
                        color: Colors.white54,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Column(
                          children: [
                            ListTile(
                              tileColor: Colors.deepPurpleAccent[600],
                              title: Text(_listIdeas[index]),
                              trailing: IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () => deleteIdea(index),
                              ),
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  '/Idea',
                                  arguments: Idea(
                                    valueIdea: _listIdeas.elementAt(index),
                                    indexIdea: index,
                                    editIdea: editIdea,
                                    deleteIdea: deleteIdea,
                                  ),
                                );
                                const SizedBox(height: 8);
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _loadIdeas() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> ideas = prefs.getStringList('ideas') ?? [];
    setState(() {
      _listIdeas = ideas;
    });
  }

  Future<void> _saveIdeas() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('ideas', _listIdeas);
  }

  void addIdea(String idea) {
    setState(() {
      _listIdeas.add(idea);
      _saveIdeas();
    });
  }

  void deleteIdea(int indexIdea) {
    setState(() {
      _listIdeas.remove(_listIdeas.elementAt(indexIdea));
      _saveIdeas();
    });
  }

  void editIdea(String newIdea, int indexIdea) {
    setState(() {
      _listIdeas[indexIdea] = newIdea;
      _saveIdeas();
    });
  }
}
