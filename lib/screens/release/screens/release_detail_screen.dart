import 'package:droomy/common/constants.dart';
import 'package:droomy/data/models/project.dart';
import 'package:droomy/screens/release/controllers/release_detail_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class ReleaseDetailScreen extends ConsumerStatefulWidget {
  final Project project;

  const ReleaseDetailScreen({super.key, required this.project});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _ReleaseDetailScreenState();
  }
}

class _ReleaseDetailScreenState extends ConsumerState<ReleaseDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(releaseDetailControllerProvider(widget.project));
    final bestReleaseDate = state.bestReleaseDate;
    if (bestReleaseDate == null) {
      return Container();
    }

    final bestReleaseDateStr = DateFormat('dd/MM/yyyy').format(bestReleaseDate);

    return Scaffold(
      appBar: AppBar(title: const Text('Plan your release')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(Constants.paddingRegular),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(widget.project.title,
                style: Theme.of(context).textTheme.displayMedium),
            const SizedBox(
              height: Constants.paddingRegular,
            ),
            Text(
                "Now it's time to let the world know about your song. It's not going to promote itself!",
                style: Theme.of(context).textTheme.bodyLarge),
            const SizedBox(
              height: Constants.paddingRegular,
            ),
            Padding(
              padding: const EdgeInsets.all(Constants.paddingSmall),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(Constants.paddingRegular),
                  child: Row(
                    children: [
                      const Icon(Icons.computer, size: 32),
                      const SizedBox(width: Constants.paddingRegular),
                      Expanded(
                        child: Text(
                            "PRO-TIP: use a computer for every step if possible",
                            style: Theme.of(context).textTheme.titleMedium),
                      )
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: Constants.paddingRegular,
            ),
            RichText(
              text: TextSpan(
                  text: "First step: ",
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary),
                  children: [
                    TextSpan(
                        text:
                            "Login on your distribution service (eg. Distrokid or Tunecore) and prepare your release.",
                        style: Theme.of(context).textTheme.titleMedium),
                  ]),
            ),
            const SizedBox(
              height: Constants.paddingRegular,
            ),
            ReleaseCard(
              icon: const Icon(Icons.date_range),
              title: "Release Date",
              text:
                  'Here is the best release date for increasing the chance you get into a featured playlist and having enough time to promote your song',
              footer: Column(
                children: [
                  Text(bestReleaseDateStr,
                      style: Theme.of(context).textTheme.displaySmall?.copyWith(
                          color: Theme.of(context).colorScheme.primary)),
                  const SizedBox(height: Constants.paddingSmall),
                  Text('at 12 am (EST)',
                      style: Theme.of(context).textTheme.titleMedium)
                ],
              ),
              buttonText: "CHANGE DATE",
            ),

            const SizedBox(
              height: Constants.paddingRegular,
            ),

            // Release Date
            const ReleaseCard(
              icon: Icon(Icons.photo),
              title: "Artwork",
              text:
                  'It\'s very important that you come up with some artwork for your song. Follow these guidelines:',
              footer: Column(
                children: [
                  Text(
                      '- The image should be a square\n- Minimum size: 640 x 640 px\n- Maximum size: 3000 x 3000 px\n- File format: JPEG or PNG\n- File size: Up to 4 MB'),
                ],
              ),
              buttonText: "VERIFY ARTWORK",
            ),

            const SizedBox(
              height: Constants.paddingRegular,
            ),

            // Release Date
            const ReleaseCard(
              icon: Icon(Icons.audiotrack),
              title: "Audio File",
              text:
                  'Make sure you are uploading a WAV (tipically 16-bit, 44.1 kHz WAV)',
              buttonText: "VERIFY AUDIO FILE",
            ),
          ]),
        ),
      ),
    );
  }
}

class ReleaseCard extends StatelessWidget {
  final Widget icon;
  final String title;
  final String text;
  final Widget? footer;
  final String? buttonText;
  final void Function()? onButtonTap;

  const ReleaseCard(
      {super.key,
      required this.icon,
      required this.title,
      required this.text,
      this.footer,
      this.buttonText,
      this.onButtonTap});

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
                Row(
                  children: [
                    icon,
                    const SizedBox(width: Constants.paddingSmall),
                    Text(title,
                        style: Theme.of(context).textTheme.headlineSmall),
                  ],
                ),
                Container(height: 10),
                Text(
                  text,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey[500],
                  ),
                ),
                footer != null
                    ? Column(children: [
                        const SizedBox(height: Constants.paddingRegular),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [footer!],
                        )
                      ])
                    : Container(),
                buttonText != null
                    ? Column(children: [
                        const SizedBox(height: Constants.paddingBig),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            OutlinedButton(
                                onPressed: onButtonTap,
                                child: Text(buttonText ?? "MORE")),
                          ],
                        )
                      ])
                    : Container(),
              ],
            ),
          ),
          Container(height: 5),
        ],
      ),
    );
  }
}
