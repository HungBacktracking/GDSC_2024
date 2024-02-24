import 'package:client/utils/scaler.dart';
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
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Scaler().init(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final scaler = Scaler();
    print("Text scale: ${scaler.textScaleFactor}, h: ${scaler.heightScaleFactor}, w: ${scaler.widthScaleFactor}");
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'CPR for Adult',
            style: TextStyle(
              fontSize: 20.0 * scaler.widthScaleFactor / scaler.textScaleFactor,
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
            padding: EdgeInsets.all(8.0 * scaler.widthScaleFactor),
            child: Center(
              child: Text(
                '$currentQuestionIndex/$totalQuestions',
                style: TextStyle(
                  fontSize: 20.0 * scaler.widthScaleFactor / scaler.textScaleFactor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(top: 50 * Scaler().widthScaleFactor),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  QuestionCard(
                    title: 'Question $currentQuestionIndex',
                    content: question,
                    backgroundColor: questionCardColor,
                  ),
                  Positioned(
                    top: -50 * Scaler().heightScaleFactor,
                    left: 0,
                    right: 0,
                    child: CircleAvatar(
                      radius: 42 * Scaler().widthScaleFactor,
                      child: Text(
                        '15',
                        style: TextStyle(
                          fontSize: 25 * scaler.widthScaleFactor / scaler.textScaleFactor,
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
              margin: EdgeInsets.only(left: 25.0 * scaler.widthScaleFactor, right: 25.0 * scaler.widthScaleFactor, top: 10.0 * scaler.heightScaleFactor, bottom: 10.0 * scaler.heightScaleFactor), // Add padding if needed
              height: 180 * scaler.widthScaleFactor, // Specify a fixed height for the container
              decoration: BoxDecoration(
                border: Border.all(
                  color: showHint ? MyTheme.darkGreen : Colors.black, // Specify the color of the border
                  width: 3.0 * scaler.widthScaleFactor, // Specify the width of the border
                ),
                borderRadius: BorderRadius.circular(10.0 * scaler.widthScaleFactor), // Rounded corners
              ),
              child: showHint
                  ? Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      SizedBox(height: 10 * scaler.heightScaleFactor),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(width: 10 * scaler.heightScaleFactor),
                          Image.asset('assets/icons/ic_hint.png', width: 30 * scaler.widthScaleFactor, height: 30 * scaler.heightScaleFactor),
                        ],
                      ),
                      SizedBox(height: 10 * scaler.heightScaleFactor),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Text(
                              "In case of emergency situation, let you safe firstly.", // Hint text
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18.0 * scaler.widthScaleFactor / scaler.textScaleFactor, // Font size for hint text
                                fontWeight: FontWeight.w500, // Font weight for hint text
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                  : ClipRRect( // Use ClipRRect for rounded corners
                    borderRadius: BorderRadius.circular(10.0 * scaler.widthScaleFactor), // Match Container's borderRadius
                    child: Image.asset(
                      'assets/images/question_image.png', // Your image asset path
                      fit: BoxFit.cover, // Scales the image to cover the container size while maintaining the aspect ratio
                    ),
              ),
            ),
            Container(
              height: 300 * scaler.widthScaleFactor,
              child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                padding: EdgeInsets.all(5.0 * scaler.heightScaleFactor),
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
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(left: 16.0 * scaler.widthScaleFactor, right: 16.0 * scaler.widthScaleFactor, bottom: 10.0 * scaler.widthScaleFactor),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            minimumSize: Size.fromHeight(50 * scaler.widthScaleFactor),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30 * scaler.widthScaleFactor),
            ),
            backgroundColor: (isSubmitted || selectedChoice.isNotEmpty) ? buttonColor : MyTheme.greyColor,
          ),
          onPressed: ((selectedChoice.isNotEmpty && !isSubmitted) || isSubmitted)? submitAnswer : null,
          child: Text(
            buttonText,
            style: TextStyle(
              color: Colors.black,
              fontSize: 20 * scaler.widthScaleFactor / scaler.textScaleFactor,
            ),
          ),
        ),
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
        leadingWidget = Image.asset('assets/icons/correct_checkbox.png', width: 24 * Scaler().widthScaleFactor, height: 24 * Scaler().widthScaleFactor);
      } else if (isSelected && !isCorrect) {
        leadingWidget = Image.asset('assets/icons/incorrect_checkbox.png', width: 24 * Scaler().widthScaleFactor, height: 24 * Scaler().widthScaleFactor);
      }
      else if (!isSelected && isCorrect) {
        leadingWidget = Image.asset('assets/icons/checkbox.png', width: 24 * Scaler().widthScaleFactor, height: 24 * Scaler().widthScaleFactor, color: MyTheme.darkGreen);
      }
      else {
        leadingWidget = Image.asset('assets/icons/checkbox.png', width: 24 * Scaler().widthScaleFactor, height: 24 * Scaler().widthScaleFactor);
      }
    }
    else {
      leadingWidget = isSelected
          ? Image.asset('assets/icons/selected_checkbox.png', width: 24 * Scaler().widthScaleFactor, height: 24 * Scaler().widthScaleFactor)
          : Image.asset('assets/icons/checkbox.png', width: 24 * Scaler().widthScaleFactor, height: 24 * Scaler().widthScaleFactor);
    }

    return Container(
      margin: EdgeInsets.only(bottom: 10.0 * Scaler().widthScaleFactor, left: 10.0 * Scaler().widthScaleFactor, right: 10.0 * Scaler().widthScaleFactor),
      height: 60 * Scaler().widthScaleFactor,
      decoration: BoxDecoration(
        color: MyTheme.lightRedBackGround, // Background color of the Container
        borderRadius: BorderRadius.circular(10.0 * Scaler().widthScaleFactor), // Rounded corners
        border: Border.all(
          color: borderColor ?? Colors.transparent, // Use borderColor if provided, otherwise transparent
          width: 2.0 * Scaler().widthScaleFactor, // Border width
        ),
      ),
      child: InkWell(
        onTap: onSelect,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0 * Scaler().widthScaleFactor),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              leadingWidget, // Check if leadingWidget is not null
              SizedBox(width: 10.0 * Scaler().widthScaleFactor), // Space between leading widget and text (if any
              Expanded(
                child: Text(
                  choice,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 18.0 * Scaler().widthScaleFactor / Scaler().textScaleFactor,
                    fontWeight: FontWeight.w600,
                    color: isSelected ? borderColor : Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
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
      margin: EdgeInsets.all(8.0 * Scaler().widthScaleFactor),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0 * Scaler().widthScaleFactor),
      ),
      color: backgroundColor,
      child: Padding(
        padding: EdgeInsets.all(16.0 * Scaler().widthScaleFactor),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 24.0 * Scaler().widthScaleFactor / Scaler().textScaleFactor,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
            ),
            SizedBox(height: 8.0 * Scaler().widthScaleFactor), // Space between title and content
            Text(
              content,
              style: TextStyle(
                fontSize: 20.0 * Scaler().widthScaleFactor/ Scaler().textScaleFactor,
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