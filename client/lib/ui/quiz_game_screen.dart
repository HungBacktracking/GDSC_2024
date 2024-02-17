import 'package:client/utils/themes.dart';
import 'package:flutter/material.dart';
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

  void submitAnswer() {
    setState(() {
      if (!isSubmitted) {
        isSubmitted = true;
        buttonColor = selectedChoice == correctAnswer ? Colors.green : Colors.orange;
        showHint = true; // Show hint when an answer is submitted
        if (currentQuestionIndex == totalQuestions){
          buttonText = "Finish";
          buttonColor = Colors.green;
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
        }
        else {
          // Go to result screen
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'CPR for Adult',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            )
        ),
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.all(8.0),
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
            child:  ListView(
              padding: const EdgeInsets.all(5.0),
              children: choices.map((choice) {
                Color? borderColor;
                if (isSubmitted) {
                  if (choice == correctAnswer) {
                    borderColor = Colors.green; // Correct answer border
                  } else if (choice == selectedChoice) {
                    borderColor = Colors.orange; // Incorrectly selected answer border
                  }
                }
                return ChoiceCard(
                  choice: choice,
                  isSelected: selectedChoice == choice,
                  onSelect: () {
                    if (!isSubmitted) { // Prevent changing selection after submission
                      setState(() {
                        selectedChoice = choice;
                      });
                    }
                  },
                  borderColor: borderColor,
                );
              }).toList(),
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
  final Color? borderColor; // Optional parameter for border color

  const ChoiceCard({
    Key? key,
    required this.choice,
    required this.isSelected,
    required this.onSelect,
    this.borderColor, // Initialize in constructor
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 10.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        side: borderColor != null ? BorderSide(color: borderColor!, width: 2.0) : BorderSide.none, // Use borderColor if provided
      ),
      child: Theme(
        data: ThemeData(unselectedWidgetColor: Colors.blue),
        child: CheckboxListTile(
          activeColor: Colors.blue,
          checkColor: Colors.white,
          controlAffinity: ListTileControlAffinity.leading,
          title: Text(
            choice,
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w600,
              color: isSelected ? Colors.blue : Colors.black,
            ),
          ),
          value: isSelected,
          onChanged: (bool? value) {
            onSelect();
          },
        ),
      ),
    );
  }
}


class QuestionCard extends StatelessWidget {
  final String title;
  final String content;

  const QuestionCard({
    Key? key,
    required this.title,
    required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      color: MyTheme.greyColor,
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