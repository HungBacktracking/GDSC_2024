class StepViewModel {

  final Map<String, List<String>> stepsForEachCategory = {
    "Burn": [
      "Ensure surroundings are safe.",
      "Remove person from the source of the burn.",
      "Determine burn severity (first, second, or third-degree).",
      "Cool the burn with running water (10-20 minutes).",
      "Remove tight items before swelling.",
      "Cover burn with sterile, non-stick bandage or cloth.",
      "Consider over-the-counter pain relievers if needed.",
      "Seek medical attention for severe burns or critical areas.",
      "Avoid applying ice directly to the burn.",
      "Resist popping blisters; seek professional advice."
    ],
    "Bleeding": [
      "Apply direct pressure to the wound with a clean cloth or sterile bandage.",
      "Maintain pressure to control bleeding; do not remove the cloth or bandage.",
      "If blood soaks through, add more layers and continue applying pressure.",
      "Elevate the injured limb if possible, unless it causes further injury.",
      "If bleeding doesn't stop, use a tourniquet above the wound as a last resort.",
      "Seek medical attention promptly."
    ],
    "CPR for Adult": [
      "Check for responsiveness.",
      "Call for help or instruct someone to call.",
      "Open the airway by tilting the head back.",
      "Check for breathing for 5-10 seconds.",
      "If not breathing, start chest compressions.",
      "Provide two rescue breaths after 30 compressions.",
      "Continue cycle until help arrives or breathing resumes.",
      "Use an AED if available."
    ],
    "CPR for Child": [
      "Check for responsiveness.",
      "Call for help or instruct someone to call.",
      "Open the airway by tilting the head back slightly.",
      "Check for breathing for 5-10 seconds.",
      "If not breathing, start chest compressions.",
      "Provide two rescue breaths after 30 compressions.",
      "Continue cycle until help arrives or breathing resumes.",
      "Use an AED if available."
    ],
    "CPR for Baby": [
      "Check for responsiveness.",
      "Call for help or instruct someone to call.",
      "Open the airway by tilting the head back slightly.",
      "Check for breathing for 5-10 seconds.",
      "If not breathing, start chest compressions with two fingers.",
      "Provide two rescue breaths after 30 compressions.",
      "Continue cycle until help arrives or breathing resumes.",
      "Use an AED if available."
    ]
  };

  List<String> getStepsForCategory(String category) {
    if (!stepsForEachCategory.containsKey(category)) {
      return stepsForEachCategory["CPR for Adult"]!;
    }
    return stepsForEachCategory[category]!;
  }
}
