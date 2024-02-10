import 'package:droomy/common/constants.dart';
import 'package:droomy/data/models/project.dart';
import 'package:droomy/helpers/audio_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';

class ProjectReadyScreen extends ConsumerStatefulWidget {
  final Project project;

  const ProjectReadyScreen({super.key, required this.project});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _ProjectReadyScreenState();
  }
}

class _ProjectReadyScreenState extends ConsumerState<ProjectReadyScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final audioHelper = ref.read(audioHelperProvider);
      audioHelper.playVictorySound();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(Constants.paddingBig),
                child: RichText(
                  text: TextSpan(
                    text: "Your song ",
                    style: Theme.of(context).textTheme.headlineLarge,
                    children: [
                      TextSpan(
                          text: widget.project.title,
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                      const TextSpan(text: ' is finally '),
                      TextSpan(
                          text: 'ready ',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.primary)),
                      const TextSpan(
                        text: 'for ',
                      ),
                      TextSpan(
                          text: 'distribution',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.primary)),
                      const TextSpan(
                          text: "!",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ))
                    ],
                  ),
                ),
              ),
              Container(
                  alignment: Alignment.center,
                  child: Lottie.asset("assets/animations/anim_rocket.json")),
              Container(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: Constants.paddingExtraBig),
                    child: ElevatedButton(
                        onPressed: () {
                          _navigateToDashboard();
                        },
                        child: const Text("GO TO DASHBOARD")),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  _navigateToDashboard() {
    final audioHelper = ref.read(audioHelperProvider);
    audioHelper.stop();
    Navigator.of(context).popUntil((route) => route.isFirst);
  }
}
