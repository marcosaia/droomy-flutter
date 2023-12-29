import 'package:droomy/view/loading_screen.dart';
import 'package:droomy/view/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'firebase_options.dart';

void main() {
  runApp(
    // For widgets to be able to read providers, we need to wrap the entire
    // application in a "ProviderScope" widget.
    // This is where the state of our providers will be stored.
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future:  Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform),
        builder: (context, snapshot) {
          // Check for errors
          if (snapshot.hasError) {
            return const Center(child: Text("Something went wrong screen is missing"));
          }

          // Once complete, show your application
          if (snapshot.connectionState == ConnectionState.done) {
            return MaterialApp(
              title: 'Droomy',
              theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
                useMaterial3: true,
              ),
              darkTheme: ThemeData(
                colorScheme: const ColorScheme.dark(),
              ),
              themeMode: ThemeMode.dark,
              home: const LoginScreen(),
            );
          }

          // Otherwise, show something whilst waiting for initialization to complete
          return const Center(
            child: CircularProgressIndicator(
                backgroundColor: Colors.black,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.red))
          );
        },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Hello,\nJohnny Johnson',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            const Padding(padding: EdgeInsets.symmetric(vertical: 8),),
            Card(
  // Set the shape of the card using a rounded rectangle border with a 8 pixel radius
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(8),
  ),
  // Set the clip behavior of the card
  clipBehavior: Clip.antiAliasWithSaveLayer,
  // Define the child widgets of the card
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      // Add a container with padding that contains the card's title, text, and buttons
      Container(
        padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Display the card's title using a font size of 24 and a dark grey color
            Text(
              "Your progress",
              style: Theme.of(context).textTheme.headlineSmall
            ),
            // Add a space between the title and the text
            Container(height: 10),
            // Display the card's text using a font size of 15 and a light grey color
            Text(
              'Here you can see your progress',
              style: TextStyle(
                fontSize: 15,
                color: Colors.grey[500],
              ),
            ),
            Container(height: 40),
            const Text('Completed 3 steps out of 4'),
            Container(height: 8),
            LinearProgressIndicator(
          value: 0.7,
          backgroundColor: Colors.grey[300],
          valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
        ),
          ],
        ),
      ),
      // Add a small space between the card and the next widget
      Container(height: 5),
    ],
  ),
),
          ],
        ),
      ),
    );
  }
}
