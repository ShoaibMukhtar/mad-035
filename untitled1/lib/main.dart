import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Table Generator and Quiz',
    initialRoute: '/', // Set the initial route to '/splash'
    routes: {
      '/': (context) => SplashScreen(), // Add a route for the splash screen

      '/generate-table': (context) => GeneratedTableScreen(),
      '/quiz': (context) {
        final Map<String, int>? tableData =
        ModalRoute.of(context)!.settings.arguments as Map<String, int>?;
        final List<Question> questions =
        generateQuestionsFromTableData(tableData!);
        return QuizScreen(tableData: tableData, questions: questions);
      },
      '/result': (context) {
        final int? score = ModalRoute.of(context)!.settings.arguments as int?;
        return ResultScreen(score: score);
      },
    },
  ));
}


class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}





class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    // Create the animation controller and set the duration
    _controller = AnimationController(
      duration: Duration(seconds: 22), // Updated duration
      vsync: this,
    );

    // Create the animation
    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller);

    // Start the animation
    _controller.forward();

    // Navigate to the home screen after the animation has completed
    Timer(Duration(seconds: 200), () { // Updated duration
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) =>  SplashScreen()), // Updated destination screen
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(


      backgroundColor: Colors.purple.shade100,
      appBar: AppBar(

        backgroundColor: Colors.purple.shade200,


        actions: [
          Row(
            children: [
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {

                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),

                    child: IconButton(
                      icon: Icon(Icons.account_circle_outlined,
                        color: Colors.purple,),
                      onPressed: (){
                        Navigator.push(context,
                          MaterialPageRoute(
                            builder: (context) => TableGeneratorScreen(),
                          ),

                        );
                      },
                    ),
                  ),
                ),
              ),



            ],
          ),
        ],
      ),


      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 200,
              width: 200,
              child: FlareActor(
                'assets/loading_animation.flr',
                animation: 'Untitled',
              ),
            ),
            SizedBox(height: 20),
            TypewriterAnimatedTextKit(
              speed: Duration(milliseconds: 500),
              repeatForever: true,
              text: ['TGA'], // Removed hypen
              textStyle: TextStyle(
                fontSize: 40.0,
                fontWeight: FontWeight.bold,
                color: Colors.purple,
                shadows: [
                  Shadow(
                    blurRadius: 10.0,
                    color: Colors.purple.shade600,
                    offset: Offset(5.0, 5.0),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                  MaterialPageRoute(
                    builder: (context) => TableGeneratorScreen(),
                  ),
                );
              },
              child: Text(
                'Start',
                style: TextStyle(color: Colors.white),
              ),
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                ),
                padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                  EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
                ),
                backgroundColor: MaterialStateProperty.all<Color>(
                  Colors.purple,
                ),
                foregroundColor: MaterialStateProperty.all<Color>(
                  Colors.white,
                ),
                overlayColor: MaterialStateProperty.all<Color>(
                  Colors.white.withOpacity(0.3),
                ),
                textStyle: MaterialStateProperty.all<TextStyle>(
                  TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),

              ),
            ),

          ],
        ),
      ),
    );
  }
}






class TableGeneratorScreen extends StatefulWidget {
  @override
  _TableGeneratorScreenState createState() => _TableGeneratorScreenState();
}

class _TableGeneratorScreenState extends State<TableGeneratorScreen> {
  double tableSliderValue = 1.0;
  double startSliderValue = 1.0;
  double endSliderValue = 10.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Table Generator and Quiz',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.purple.shade200, // Set app bar color to purple
      ),
      backgroundColor: Colors.purple.shade100, // Set body background color to purple with opacity
      body: Padding(
        padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 5.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 5.0),
              child: Text(
                'Table Number: ${tableSliderValue.toInt()}',
                style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),
              ),
            ),
            Slider(
              value: tableSliderValue,
              min: 1,
              max: 100,
              onChanged: (newValue) {
                setState(() {
                  tableSliderValue = newValue;
                });
              },
              activeColor: Colors.purple, // Set slider color to purple
              inactiveColor: Colors.grey, // Set slider inactive color to grey
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Start Number: ${startSliderValue.toInt()}',
                style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),
              ),
            ),
            Slider(
              value: startSliderValue,
              min: 1,
              max: 100,
              onChanged: (newValue) {
                setState(() {
                  startSliderValue = newValue;
                });
              },
              activeColor: Colors.purple, // Set slider color to purple
              inactiveColor: Colors.grey, // Set slider inactive color to grey
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'End Number: ${endSliderValue.toInt()}',
                style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),
              ),
            ),
            Slider(
              value: endSliderValue,
              min: 1,
              max: 100,
              onChanged: (newValue) {
                setState(() {
                  endSliderValue = newValue;
                });
              },
              activeColor: Colors.purple, // Set slider color to purple
              inactiveColor: Colors.grey, // Set slider inactive color to grey
            ),
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: ElevatedButton(
                child: Text('Generate Table',style: TextStyle(

                  fontWeight: FontWeight.w700,
                    color: Colors.white
                ),),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)
                  ),
                  primary: Colors.purple, // Set button color to purple
                  onPrimary: Colors.white, // Set button text color to white
                ),
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    '/generate-table',
                    arguments: {
                      'tableNumber': tableSliderValue.toInt(),
                      'startNumber': startSliderValue.toInt(),
                      'endNumber': endSliderValue.toInt(),
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class GeneratedTableScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Map<String, int>? tableData =
    ModalRoute.of(context)!.settings.arguments as Map<String, int>?;

    List<TableRow> rows = [];
    if (tableData != null) {
      for (int i = tableData['startNumber']!; i <= tableData['endNumber']!; i++) {
        rows.add(
          TableRow(
            children: [
              TableCell(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    '${tableData['tableNumber']} x $i',
                    style: TextStyle(fontSize: 18.0),
                  ),
                ),
              ),
              TableCell(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    '${tableData['tableNumber']! * i}',
                    style: TextStyle(fontSize: 18.0),
                  ),
                ),
              ),
            ],
          ),
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple.shade200,
        title: Text('Generated Table'),
      ),
      backgroundColor: Colors.purple.shade100,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: Column(
            children: [
              Table(
                border: TableBorder.all(),
                children: rows,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.purple, // Set button color to purple
                      onPrimary: Colors.white,
                    shape:
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0)
                      )

                  ),
                  child: Text('Quiz'),
                  onPressed: () {
                    Navigator.pushNamed(context, '/quiz', arguments: tableData);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class QuizScreen extends StatefulWidget {
  final Map<String, int>? tableData;
  final List<Question> questions;

  QuizScreen({required this.tableData, required this.questions});

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int currentQuestionIndex = 0;
  int score = 0;
  bool submitted = false;

  String get currentQuestion => widget.questions[currentQuestionIndex].question;
  List<String> get currentOptions =>
      widget.questions[currentQuestionIndex].options;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple.shade200,
        title: Text('Quiz'),
      ),
      backgroundColor: Colors.purple.shade100,
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              currentQuestion,
              style: TextStyle(fontSize: 18.0),
            ),
          ),
          Column(
            children: currentOptions
                .asMap()
                .entries
                .map(
                  (option) => RadioListTile(
                title: Text(option.value),
                value: option.key,
                groupValue:
                widget.questions[currentQuestionIndex].selectedAnswerIndex,
                onChanged: (value) {
                  setState(() {
                    widget.questions[currentQuestionIndex].selectedAnswerIndex =
                    value as int;
                  });
                },
              ),
            )
                .toList(),
          ),
          Container(
            width: 400,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.purple, // Set button color to purple
                      onPrimary: Colors.white,
                      shape:
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0)
                      )

                  ),
                  child: Text('Previous'),
                  onPressed: () {
                    setState(() {
                      currentQuestionIndex =
                          (currentQuestionIndex - 1).clamp(0, 9);
                    });
                  },
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.purple, // Set button color to purple
                      onPrimary: Colors.white,
                      shape:
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0)
                      )

                  ),
                  child: Text('Next'),
                  onPressed: () {
                    setState(() {
                      if (currentQuestionIndex == 3) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Submit Quiz'),
                              content: Text('All questions Completed Please Submit the quiz'),
                              actions: [
                                TextButton(
                                  child: Text('OK'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      } else {
                        currentQuestionIndex = (currentQuestionIndex + 1).clamp(0, 9);
                      }
                    });
                  },
                ),

              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: Colors.purple, // Set button color to purple
                  onPrimary: Colors.white,
                  shape:
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0)
                  )

              ),
              child: Text(submitted ? 'Restart Quiz' : 'Submit Quiz'),
              onPressed: () {
                if (submitted) {
                  setState(() {
                    currentQuestionIndex = 0;
                    score = 0;
                    submitted = false;
                    widget.questions.forEach(
                          (question) => question.selectedAnswerIndex = -1,
                    );
                  });
                } else {
                  int numCorrectAnswers = 0;
                  widget.questions.forEach((question) {
                    if (question.selectedAnswerIndex ==
                        question.correctAnswerIndex) {
                      numCorrectAnswers++;
                    }
                  });

                  setState(() {
                    score = numCorrectAnswers;
                    submitted = true;
                  });

                  Navigator.pushNamed(context, '/result', arguments: score);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ResultScreen extends StatelessWidget {
  final int? score;

  ResultScreen({required this.score});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple.shade200,
        title: Text('Quiz Result'),
      ),
      backgroundColor: Colors.purple.shade100,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Your Score: $score',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: Colors.purple, // Set button color to purple
                  onPrimary: Colors.white,
                  shape:
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0)
                  )

              ),
              child: Text('Play Again'),

              onPressed: () {
                Navigator.popUntil(context, ModalRoute.withName('/'));
              },
            ),
          ],
        ),
      ),
    );
  }
}

class Question {
  final String question;
  final List<String> options;
  final int correctAnswerIndex;
  int selectedAnswerIndex;

  Question({
    required this.question,
    required this.options,
    required this.correctAnswerIndex,
    this.selectedAnswerIndex = -1,
  });
}

List<Question> generateQuestionsFromTableData(Map<String, int> tableData) {
  List<Question> questions = [];
  List<int> indices = [1, 2, 3, 4];
  indices.shuffle(); // Randomize the sequence of indices
  int y=tableData['startNumber']!;
  for (int i = 0; i < 4; i++) {
    int x = indices[i];
    String question = '${tableData['tableNumber']} x $y = ?';
    List<String> options = [
      '${tableData['tableNumber']! * y}',
      '${tableData['tableNumber']! * (y + 1)}',
      '${tableData['tableNumber']! * (y + 2)}',
      '${tableData['tableNumber']! * (y + 3)}',
    ];
    int correctAnswerIndex = 0;
    questions.add(
      Question(
        question: question,
        options: options,
        correctAnswerIndex: correctAnswerIndex,
      ),
    );
    y++;
  }

  return questions;
}