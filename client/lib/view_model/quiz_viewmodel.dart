import '../models/quiz_model.dart';

class QuizViewModel{
  final Map<String, List<Map<String, dynamic>>> firstAidQuestions = {
    "Burn" : [
      {
        "case": "burn",
        "question": "What is the first step in providing first aid for a burn?",
        "image_link": "https://d2jx2rerrg6sh3.cloudfront.net/image-handler/picture/2018/11/By_corbac401.jpg",
        "options": ["Applying ice directly to the burn", "Checking for responsiveness", "Removing tight items", "Popping blisters"],
        "correct_answer": "Checking for responsiveness"
      },
      {
        "case": "burn",
        "question": "How long should you cool a burn with running water?",
        "image_link": "https://d2jx2rerrg6sh3.cloudfront.net/image-handler/picture/2018/11/By_corbac401.jpg",
        "options": ["5 minutes", "10-20 minutes", "30 seconds", "1 hour"],
        "correct_answer": "10-20 minutes"
      },
      {
        "case": "burn",
        "question": "Why is it important to remove tight items around the burn area?",
        "image_link": "https://d2jx2rerrg6sh3.cloudfront.net/image-handler/picture/2018/11/By_corbac401.jpg",
        "options": ["To prevent swelling", "To apply ointment", "To speed up the healing process", "To pop blisters"],
        "correct_answer": "To prevent swelling"
      },
      {
        "case": "burn",
        "question": "What should you cover a burn with after cooling it with water?",
        "image_link": "https://d2jx2rerrg6sh3.cloudfront.net/image-handler/picture/2018/11/By_corbac401.jpg",
        "options": ["Ice pack", "Sterile bandage or cloth", "Butter", "Hot compress"],
        "correct_answer": "Sterile bandage or cloth"
      },
      {
        "case": "burn",
        "question": "When seeking medical attention for a burn, what should you mention to the healthcare provider?",
        "image_link": "https://d2jx2rerrg6sh3.cloudfront.net/image-handler/picture/2018/11/By_corbac401.jpg",
        "options": ["The burn's color", "The tight items removed", "The cool water temperature", "The time spent cooling the burn"],
        "correct_answer": "The tight items removed"
      },
      {
        "case": "burn",
        "question": "How does the severity of a burn affect the need for professional medical assistance?",
        "image_link": "https://d2jx2rerrg6sh3.cloudfront.net/image-handler/picture/2018/11/By_corbac401.jpg",
        "options": ["Severe burns don't require medical attention", "All burns should be treated by professionals", "Mild burns don't need medical attention", "Professional help is only needed for burns on the face"],
        "correct_answer": "All burns should be treated by professionals"
      },
      {
        "case": "burn",
        "question": "What is the purpose of avoiding direct application of ice to a burn?",
        "image_link": "https://d2jx2rerrg6sh3.cloudfront.net/image-handler/picture/2018/11/By_corbac401.jpg",
        "options": ["Ice accelerates healing", "Ice may cause frostbite", "Ice reduces pain", "Ice prevents infection"],
        "correct_answer": "Ice may cause frostbite"
      },
      {
        "case": "burn",
        "question": "How can you assist someone with a burn while waiting for medical help?",
        "image_link": "https://d2jx2rerrg6sh3.cloudfront.net/image-handler/picture/2018/11/By_corbac401.jpg",
        "options": ["Applying oil to the burn", "Blowing on the burn", "Keeping the burn exposed", "Elevating the burned area"],
        "correct_answer": "Elevating the burned area"
      },
      {
        "case": "burn",
        "question": "Which over-the-counter pain reliever is generally recommended for burn-related pain?",
        "image_link": "https://d2jx2rerrg6sh3.cloudfront.net/image-handler/picture/2018/11/By_corbac401.jpg",
        "options": ["Aspirin", "Ibuprofen", "Acetaminophen", "Naproxen"],
        "correct_answer": "Ibuprofen"
      },
      {
        "case": "burn",
        "question": "Why is it crucial to resist popping blisters on a burn?",
        "image_link": "https://d2jx2rerrg6sh3.cloudfront.net/image-handler/picture/2018/11/By_corbac401.jpg",
        "options": ["Popping blisters speeds up healing", "Popped blisters reduce pain", "Popped blisters prevent infection", "Popping blisters can lead to infection and scarring"],
        "correct_answer": "Popped blisters prevent infection and scarring"
      }
    ],

    "Bleeding" : [
      {
        "case": "bleeding",
        "question": "What is the initial step to control bleeding from a wound?",
        "image_link": "https://articles-1mg.gumlet.io/articles/wp-content/uploads/2019/02/first-aid-for-cuts-and-bleeding.jpg",
        "options": ["Apply direct pressure", "Elevate the injured limb", "Remove any blood clots", "Apply heat to the wound"],
        "correct_answer": "Apply direct pressure"
      },
      {
        "case": "bleeding",
        "question": "Should you remove the cloth or bandage if it becomes soaked with blood during bleeding control?",
        "image_link": "https://articles-1mg.gumlet.io/articles/wp-content/uploads/2019/02/first-aid-for-cuts-and-bleeding.jpg",
        "options": ["Yes", "No", "Only if the bleeding is severe", "Only if the person requests it"],
        "correct_answer": "No"
      },
      {
        "case": "bleeding",
        "question": "In what situation might you consider using a tourniquet for bleeding control?",
        "image_link": "https://articles-1mg.gumlet.io/articles/wp-content/uploads/2019/02/first-aid-for-cuts-and-bleeding.jpg",
        "options": ["For any bleeding", "If direct pressure doesn't stop the bleeding", "Only for minor cuts", "Always as the first step"],
        "correct_answer": "If direct pressure doesn't stop the bleeding"
      },
      {
        "case": "bleeding",
        "question": "How does elevation of the injured limb assist in controlling bleeding?",
        "image_link": "https://articles-1mg.gumlet.io/articles/wp-content/uploads/2019/02/first-aid-for-cuts-and-bleeding.jpg",
        "options": ["It slows down blood clotting", "It prevents swelling", "It increases blood flow", "It has no effect on bleeding"],
        "correct_answer": "It prevents swelling"
      },
      {
        "case": "bleeding",
        "question": "What is the purpose of adding more layers and continuing to apply pressure if blood soaks through the initial bandage?",
        "image_link": "https://articles-1mg.gumlet.io/articles/wp-content/uploads/2019/02/first-aid-for-cuts-and-bleeding.jpg",
        "options": ["To keep the wound warm", "To avoid staining clothing", "To control bleeding more effectively", "To make the bandage more comfortable"],
        "correct_answer": "To control bleeding more effectively"
      },
      {
        "case": "bleeding",
        "question": "When applying direct pressure to control bleeding, what is the recommended position for the injured limb?",
        "image_link": "https://articles-1mg.gumlet.io/articles/wp-content/uploads/2019/02/first-aid-for-cuts-and-bleeding.jpg",
        "options": ["Lower than the heart", "Higher than the heart", "At the same level as the heart", "Elevated and rotated"],
        "correct_answer": "Lower than the heart"
      },
      {
        "case": "bleeding",
        "question": "Why is applying heat not recommended for wound care in cases of bleeding?",
        "image_link": "https://articles-1mg.gumlet.io/articles/wp-content/uploads/2019/02/first-aid-for-cuts-and-bleeding.jpg",
        "options": ["Heat promotes bacterial growth", "Heat causes blood vessels to constrict", "Heat may increase bleeding", "Heat speeds up the healing process"],
        "correct_answer": "Heat may increase bleeding"
      },
      {
        "case": "bleeding",
        "question": "What is the primary objective when using a tourniquet for bleeding control?",
        "image_link": "https://articles-1mg.gumlet.io/articles/wp-content/uploads/2019/02/first-aid-for-cuts-and-bleeding.jpg",
        "options": ["Completely stop blood flow", "Control bleeding temporarily", "Prevent infection", "Improve circulation"],
        "correct_answer": "Completely stop blood flow"
      },
      {
        "case": "bleeding",
        "question": "When controlling bleeding, what information should you relay to emergency services?",
        "image_link": "https://articles-1mg.gumlet.io/articles/wp-content/uploads/2019/02/first-aid-for-cuts-and-bleeding.jpg",
        "options": ["The color of the blood", "Whether the person is conscious", "The person's age", "The size of the wound"],
        "correct_answer": "The size of the wound"
      },
      {
        "case": "bleeding",
        "question": "In what circumstances should you avoid using a tourniquet?",
        "image_link": "https://articles-1mg.gumlet.io/articles/wp-content/uploads/2019/02/first-aid-for-cuts-and-bleeding.jpg",
        "options": ["For any bleeding", "If direct pressure doesn't stop the bleeding", "Only for minor cuts", "Always as the first step"],
        "correct_answer": "For any bleeding"
      }
    ],
  };

  List<QuizModel> getListQuestionsForCategory(String category){
    List<QuizModel> questions = [];
    for (var question in firstAidQuestions[category]!) {
      questions.add(QuizModel(
        question: question["question"],
        imageUrl: question["image_link"],
        options: question["options"],
        correctAnswer: question["correct_answer"]
      ));
    }
    return questions;
  }
}