// I have kept all the steps in the same file for now, but it might be worth
// to separate them in individual classes in the future.
import 'package:droomy/data/models/action_item.dart';
import 'package:droomy/data/models/action_plan.dart';
import 'package:droomy/data/models/workflow_step.dart';

class DefaultWorkflowSteps {
  static final demo = WorkflowStep(
    identifier: "demo",
    displayName: "Demo",
    shortDescription:
        "Record the best demo you can, memorize and internalize your song and concept",
    actionPlan: ActionPlan(actionItems: [
      ActionItem.simpleGoal("Find or produce a good instrumental"),
      ActionItem.simpleGoal("Record the best demo you can"),
      ActionItem.simpleGoal("Send your demo to your producer and friends")
    ]),
  );

  static final recording = WorkflowStep(
      identifier: "recording",
      displayName: "Recording",
      shortDescription: "Book a studio session to record your new song",
      actionPlan: ActionPlan(actionItems: [
        ActionItem.simpleGoal("Book an appointment for a recording session"),
        ActionItem.simpleGoal("Reharse your track and memorize it"),
        ActionItem.simpleGoal("Complete the recording session"),
      ]));

  static final mixing = WorkflowStep(
      identifier: "mixing",
      displayName: "Mixing",
      shortDescription:
          "The track needs to be mixed now, if it isn't already send it to somebody to mix it",
      actionPlan: ActionPlan(actionItems: [
        ActionItem.simpleGoal(
            "Find one or more reference tracks that you like"),
        ActionItem.simpleGoal(
            "Send the reference tracks and your recordings to somebody that can mix your song"),
        ActionItem.simpleGoal("Receive your final mixed track"),
      ]));

  static final mastering = WorkflowStep(
    identifier: "mastering",
    displayName: "Mastering",
    shortDescription:
        "The tracks needs to be mastered to be spotify ready! We're almost there.",
    actionPlan: ActionPlan(actionItems: [
      ActionItem.simpleGoal("Find one or more reference tracks that you like"),
      ActionItem.simpleGoal(
          "Send the reference tracks and your mixed track to somebody that can master your song"),
      ActionItem.simpleGoal("Receive your final mastered track"),
    ]),
  );
}
