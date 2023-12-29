import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
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
      home: const MyHomePage(title: 'Home'),
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
            Text('Completed 3 steps out of 4'),
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
