import 'package:flutter/material.dart';

class ImageHeaderCard extends StatelessWidget {
  final String imagePath;
  final String text;
  final double cardHeight;
  final Widget contentWidget;

  const ImageHeaderCard({
    super.key,
    required this.imagePath,
    required this.text,
    required this.cardHeight,
    required this.contentWidget,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0, // Add elevation as needed
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(8.0), // Adjust the border radius as needed
      ),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: cardHeight,
            width: double.infinity,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.network(
                  imagePath,
                  fit: BoxFit.cover,
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(text,
                        style: Theme.of(context).textTheme.displaySmall),
                  ),
                ),
              ],
            ),
          ),
          contentWidget,
        ],
      ),
    );
  }
}
