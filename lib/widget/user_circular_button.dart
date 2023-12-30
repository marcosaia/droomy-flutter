import 'package:flutter/material.dart';

class UserCircularButton extends StatelessWidget {
  final String? displayName;
  final String? imageUrl;
  final double size;
  final VoidCallback? onPressed;

  const UserCircularButton({
    Key? key,
    this.displayName,
    this.imageUrl,
    this.size = 48.0,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: ClipOval(
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onPressed,
            child: Stack(
              children: [
                if (imageUrl != null)
                  Image.network(
                    imageUrl!,
                    width: size,
                    height: size,
                    fit: BoxFit.cover,
                  ),
                if (imageUrl == null &&
                    displayName != null &&
                    displayName!.isNotEmpty)
                  Container(
                    width: size,
                    height: size,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.blue, // Change the color as needed
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      displayName![0].toUpperCase(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: size * 0.4,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
