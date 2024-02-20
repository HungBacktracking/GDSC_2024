import 'package:client/utils/themes.dart';
import 'package:flutter/material.dart';

import 'complete_quiz_screen.dart';
class QuizScreen extends StatefulWidget {
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int currentQuestionIndex = 1; // assuming starting from question 7
  int totalQuestions = 10;
  String correctAnswer = "Mine";
  String question = "In an emergency situation, who’s safety is priority?";
  List<String> choices = ['Mine', 'The ill', 'The elder', 'Bystander'];
  String selectedChoice = '';
  bool isSubmitted = false; // Move this outside build
  Color buttonColor = MyTheme.submitBtn; // Initialize with default color
  String buttonText = "Submit"; // Initial button text
  bool showHint = false;
  Color questionCardColor = MyTheme.lightRedBackGround;
  bool isCorrect = false;
  int correctQuestions = 0;

  void submitAnswer() {
    setState(() {
      if (!isSubmitted) {
        isSubmitted = true;
        isCorrect = selectedChoice == correctAnswer;
        buttonColor = selectedChoice == correctAnswer ? MyTheme.correctBtn : MyTheme.wrongBtn;
        showHint = true; // Show hint when an answer is submitted
        questionCardColor = selectedChoice == correctAnswer ? MyTheme.correctBtn.withOpacity(0.1) : MyTheme.wrongBtn.withOpacity(0.1);
        if (isCorrect) {
          correctQuestions++;
        }
        if (currentQuestionIndex == totalQuestions){
          buttonText = "Finish";
          buttonColor = MyTheme.correctBtn;
        }
        else{
          buttonText = "Next Question";
        }
      }
      else{
        // Go to next question or show result
        if (currentQuestionIndex < totalQuestions){
          currentQuestionIndex++;
          question = "In an emergency situation, who’s safety is priority?";
          choices = ['Mine', 'The ill', 'The elder', 'Bystander'];
          selectedChoice = '';
          isSubmitted = false;
          buttonColor = MyTheme.submitBtn;
          buttonText = "Submit";
          showHint = false; // Hide hint when moving to the next question
          questionCardColor = MyTheme.lightRedBackGround;
        }
        else {
          // Go to result screen
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => CompleteScreen(
                imageUrl: 'https://raw.githubusercontent.com/BaoNinh2808/Jetpack-Compose/main/images/cpr%20(1)%201.png?token=GHSAT0AAAAAACJ6YV2UULTBIV7XLUZ7NNMIZOTLGWQ',
                time: '3:21',
                correctQuestions: correctQuestions,
                totalQuestions: totalQuestions,
                title: 'CPR for Adult',
              ),
            ),
          );
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
            'CPR for Adult',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            )
        ),
        leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                '$currentQuestionIndex/$totalQuestions',
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 50),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                QuestionCard(
                  title: 'Question $currentQuestionIndex',
                  content: question,
                  backgroundColor: questionCardColor,
                ),
                const Positioned(
                  top: -50,
                  left: 0,
                  right: 0,
                  child: CircleAvatar(
                    radius: 42,
                    child: Text(
                      '15',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  )
              ),
            ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 25.0, right: 25.0, top: 10.0, bottom: 10.0), // Add padding if needed
            height: 180, // Specify a fixed height for the container
            decoration: BoxDecoration(
              border: Border.all(
                color: showHint ? MyTheme.darkGreen : Colors.black, // Specify the color of the border
                width: 3.0, // Specify the width of the border
              ),
              borderRadius: BorderRadius.circular(10.0), // Rounded corners
            ),
            child: showHint
                ? Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(width: 10),
                        Image.asset('assets/icons/ic_hint.png', width: 30, height: 30),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Text(
                            "In case of emergency situation, let you safe firstly.", // Hint text
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18.0, // Font size for hint text
                              fontWeight: FontWeight.w500, // Font weight for hint text
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                )
                : ClipRRect( // Use ClipRRect for rounded corners
                  borderRadius: BorderRadius.circular(10.0), // Match Container's borderRadius
                  child: Image.asset(
                    'assets/images/question_image.png', // Your image asset path
                    fit: BoxFit.cover, // Scales the image to cover the container size while maintaining the aspect ratio
                  ),
            ),
          ),
          Expanded(
            child:  ListView.builder(
              padding: const EdgeInsets.all(5.0),
              itemCount: choices.length,
              itemBuilder: (context, index) {
                String choice = choices[index];
                bool isCorrectChoice = choice == correctAnswer;
                Color? borderColor = isSubmitted
                    ? (isCorrectChoice ? Colors.green : (selectedChoice == choice ? Colors.orange : null))
                    : null;

                return ChoiceCard(
                  choice: choice,
                  isSelected: selectedChoice == choice,
                  onSelect: () {
                    if (!isSubmitted) {
                      setState(() {
                        selectedChoice = choice;
                      });
                    }
                  },
                  borderColor: borderColor,
                  isCorrect: isCorrectChoice,
                  isSubmitted: isSubmitted,
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                backgroundColor: (isSubmitted || selectedChoice.isNotEmpty) ? buttonColor : MyTheme.greyColor,
              ),
              onPressed: ((selectedChoice.isNotEmpty && !isSubmitted) || isSubmitted)? submitAnswer : null,
              child: Text(
                buttonText,
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 20
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ChoiceCard extends StatelessWidget {
  final String choice;
  final bool isSelected;
  final VoidCallback onSelect;
  final Color? borderColor;
  final bool isCorrect;
  final bool isSubmitted;

  const ChoiceCard({
    Key? key,
    required this.choice,
    required this.isSelected,
    required this.onSelect,
    this.borderColor,
    required this.isCorrect,
    required this.isSubmitted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget? leadingWidget;
    if (isSubmitted) {
      if (isSelected && isCorrect) {
        leadingWidget = Image.asset('assets/icons/correct_checkbox.png', width: 24, height: 24);
      } else if (isSelected && !isCorrect) {
        leadingWidget = Image.asset('assets/icons/incorrect_checkbox.png', width: 24, height: 24);
      }
      else if (!isSelected && isCorrect) {
        leadingWidget = Image.asset('assets/icons/checkbox.png', width: 24, height: 24, color: MyTheme.darkGreen);
      }
      else {
        leadingWidget = Image.asset('assets/icons/checkbox.png', width: 24, height: 24);
      }
    }
    else {
      leadingWidget = isSelected
          ? Image.asset('assets/icons/selected_checkbox.png', width: 24, height: 24)
          : Image.asset('assets/icons/checkbox.png', width: 24, height: 24);
    }

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 10.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        side: borderColor != null ? BorderSide(color: borderColor!, width: 2.0) : BorderSide.none,
      ),
      child: ListTile(
        leading: leadingWidget,
        title: Text(
          choice,
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w600,
            color: isSelected ? borderColor : Colors.black,
          ),
        ),
        onTap: onSelect,
        tileColor: isSelected ? borderColor?.withOpacity(0.2) : null,
      ),
    );
  }
}




class QuestionCard extends StatelessWidget {
  final String title;
  final String content;
  final Color backgroundColor;

  const QuestionCard({
    Key? key,
    required this.title,
    required this.content,
    required this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      color: backgroundColor,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
            ),
            SizedBox(height: 8.0), // Space between title and content
            Text(
              content,
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}