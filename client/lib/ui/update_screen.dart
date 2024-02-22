import 'package:flutter/material.dart';

class UpdateInfoScreen extends StatefulWidget {
  final List<String> titles;
  final List<String> contents;
  final String appBarTitle;

  const UpdateInfoScreen({
    Key? key,
    required this.appBarTitle,
    required this.titles,
    required this.contents,
  }) : super(key: key);

  @override
  _UpdateInfoScreenState createState() => _UpdateInfoScreenState();
}

class _UpdateInfoScreenState extends State<UpdateInfoScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _appBarTitle;
  // Use a Map to track the updated values
  Map<String, TextEditingController> controllers = {};

  @override
  void initState() {
    super.initState();

    _appBarTitle = widget.appBarTitle;
    // Initialize the text editing controllers with the old data
    for (int i = 0; i < widget.titles.length; i++) {
      controllers[widget.titles[i]] = TextEditingController(text: widget.contents[i]);
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Here, you would update your backend or local storage with the new values
      // For demonstration, we'll just print the updated values to the console
      // controllers.forEach((title, controller) {
      //   print('$title: ${controller.text}');
      // });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Information Updated!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'Update $_appBarTitle',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            )
        ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () => Navigator.of(context).pop(),
          )
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                for (var title in widget.titles)
                  TextFormField(
                    controller: controllers[title],
                    decoration: InputDecoration(labelText: title),
                    validator: (value) {
                      // Simple validation: ensure the field is not empty
                      if (value == null || value.isEmpty) {
                        return 'Please enter your $title';
                      }
                      return null;
                    },
                  ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _submitForm,
                  child: const Text('Update Information'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Dispose of the controllers to avoid memory leaks
    controllers.forEach((_, controller) => controller.dispose());
    super.dispose();
  }
}
