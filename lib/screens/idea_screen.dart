import 'package:flutter/material.dart';
import '../const/background.dart';
import '../models/idea_model.dart';
import '../widgets/text_field.dart';

class IdeaScreen extends StatefulWidget {
  const IdeaScreen({super.key});

  @override
  State<IdeaScreen> createState() => _IdeaScreenState();
}

class _IdeaScreenState extends State<IdeaScreen> {
  @override
  Widget build(BuildContext context) {
    var argument = ModalRoute.of(context)?.settings.arguments as Idea;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(argument.valueIdea),
        actions: [
          IconButton(
            onPressed: () {
              argument.deleteIdea(argument.indexIdea);
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.delete_rounded),
          ),
        ],
      ),
      body: Stack(
        children: [
          background(),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 100,
                horizontal: 30,
              ),
              child: customTextField(
                controller: TextEditingController(),
                hintText: 'editor idea',
                onSubmitted: ((value) {
                  argument.editIdea(value, argument.indexIdea);
                  Navigator.of(context).pop();
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
