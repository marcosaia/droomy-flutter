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
      ActionItem.simpleGoal("Find, record or produce a good instrumental"),
      ActionItem.simpleGoal(
          "Record the best demo you can (you can even do it with your phone)"),
      ActionItem.simpleGoal(
          "Send your demo to your producer, or let some friends listen to it")
    ]),
  );

  static final recording = WorkflowStep(
      identifier: "recording",
      displayName: "Recording",
      shortDescription: "Book a studio session to record your new song",
      actionPlan: ActionPlan(actionItems: [
        ActionItem.simpleGoal(
            "Text or call your producer, or book an appointment in a professional studio"),
        ActionItem.simpleGoal(
            "Reharse your track, try to memorize it, you will have more energy and fun in the studio")
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
            "Send the reference tracks and your recordings to somebody for mixing your song"),
      ]));

  static final mastering = WorkflowStep(
    identifier: "mastering",
    displayName: "Mastering",
    shortDescription:
        "The tracks needs to be mastered to be spotify ready! We're almost there.",
    actionPlan: ActionPlan(actionItems: [
      ActionItem.simpleGoal("Find one or more reference tracks that you like"),
      ActionItem.simpleGoal(
          "Send the reference tracks and your recordings to somebody for mastering your song"),
    ]),
  );
}
