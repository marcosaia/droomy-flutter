import 'package:droomy/common/constants.dart';
import 'package:flutter/material.dart';

class UserProgressOverviewCard extends StatelessWidget {
  const UserProgressOverviewCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(Constants.paddingBig),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("You are doing great!",
                    style: Theme.of(context).textTheme.headlineSmall),
                Container(height: 10),
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
          Container(height: 5),
        ],
      ),
    );
  }
}
