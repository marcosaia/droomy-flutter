import 'package:droomy/common/constants.dart';
import 'package:flutter/material.dart';

class UserProgressOverviewCard extends StatelessWidget {
  const UserProgressOverviewCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
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
            padding: const EdgeInsets.all(Constants.paddingBig),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // Display the card's title using a font size of 24 and a dark grey color
                Text("You are doing great!",
                    style: Theme.of(context).textTheme.headlineSmall),
                // Add a space between the title and the text
                Container(height: 10),
                // Display the card's text using a font size of 15 and a light grey color
                Text(
                  'Keep going! 💪\n\nOne day you will be proud you did.',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          ),
          // Add a small space between the card and the next widget
          Container(height: 5),
        ],
      ),
    );
  }
}