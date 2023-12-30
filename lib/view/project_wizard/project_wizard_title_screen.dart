import 'package:droomy/common/constants.dart';
import 'package:flutter/material.dart';

class TitleInputScreen extends StatefulWidget {
  const TitleInputScreen({super.key});

  @override
  TitleInputScreenState createState() => TitleInputScreenState();
}

class TitleInputScreenState extends State<TitleInputScreen> {
  final TextEditingController _titleController = TextEditingController();
  bool isNextButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    _titleController.addListener(_updateNextButtonState);
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  void _updateNextButtonState() {
    setState(() {
      isNextButtonEnabled =
          _titleController.text.length >= Constants.projectTitleMinLength;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Project'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Enter a title for your project',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Please provide a title (maximum ${Constants.projectTitleMaxLength} characters) for your new project:',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 32),
            TextFormField(
              controller: _titleController,
              maxLength: Constants.projectTitleMaxLength,
              style: Theme.of(context).textTheme.headlineMedium,
              decoration: const InputDecoration(
                labelText: 'Project Title',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                _updateNextButtonState();
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a title';
                }

                if (value.length < Constants.projectTitleMinLength) {
                  return 'Title should be at least ${Constants.projectTitleMinLength} characters long';
                }

                if (value.length > Constants.projectTitleMaxLength) {
                  return 'Title should not exceed ${Constants.projectTitleMaxLength} characters';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            10.0), // Set your desired border radius here
                      ),
                    ),
                    onPressed: isNextButtonEnabled
                        ? () {
                            // Navigate to the next screen and pass entered title
                            if (_titleController.text.isNotEmpty) {}
                          }
                        : null,
                    child: const Text('Next'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
