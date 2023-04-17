import 'package:flutter/material.dart';
import 'dart:async';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Quiz',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: QuizHomePage(title: 'Flutter Quiz Home Page'),
    );
  }
}

class QuizHomePage extends StatefulWidget {
  QuizHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _QuizHomePageState createState() => _QuizHomePageState();
}

class _QuizHomePageState extends State<QuizHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/quiz.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(10.0),
                child: ElevatedButton(
                  child: Text('True/False Quiz'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TrueFalseQuizPage()),
                    );
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: ElevatedButton(
                  child: Text('MCQ Quiz'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => McqQuizPage()),
                    );
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

class TrueFalseQuizPage extends StatefulWidget {
  @override
  _TrueFalseQuizPageState createState() => _TrueFalseQuizPageState();
}

class _TrueFalseQuizPageState extends State<TrueFalseQuizPage> {
  int _currentQuestionIndex = 0;
  int _score = 0;
  bool _timerIsRunning = true;
  Timer? _timer;

  List<Map<String, dynamic>> _questions = [
    {
      'question': 'Flutter uses the Dart programming language.',
      'answer': true,
    },
    {
      'question': 'The "main" function is the entry point of a Flutter app.',
      'answer': true,
    },
    {
      'question': 'Widgets in Flutter are immutable.',
      'answer': false,
    },
    {
      'question': 'Flutter was developed by Google.',
      'answer': true,
    },
  ];

  List<bool> _attemptedQuestions = [false, false, false, false];

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_timerIsRunning) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _onAnswerSelected(bool answer) {
    if (_questions[_currentQuestionIndex]['answer'] == answer) {
      _score++;
    }
    _attemptedQuestions[_currentQuestionIndex] = true;
    setState(() {
      _currentQuestionIndex++;
    });
  }

  void _onPreviousQuestion() {
    if (_currentQuestionIndex > 0) {
      setState(() {
        _currentQuestionIndex--;
      });
    }
  }

  void _onNextQuestion() {
    if (_currentQuestionIndex < _questions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_currentQuestionIndex >= _questions.length) {
      _timerIsRunning = false;
      return Scaffold(
          appBar: AppBar(
            title: Text('True/False Quiz Results'),
          ),
          body: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/quiz.jpg"),
                  // replace with your own image path
                  fit: BoxFit.cover,
                ),
              ),
              child: Center(
                child: Text(
                  'Your score is $_score',
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
              )));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('True/False Quiz'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/quiz.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      child: Text('Prev'),
                      onPressed: () {
                        _onPreviousQuestion();
                      },
                    ),
                    Text(
                      'Question ${_currentQuestionIndex + 1}: ${_questions[_currentQuestionIndex]['question']}',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    ElevatedButton(
                      child: Text('Next'),
                      onPressed: () {
                        _onNextQuestion();
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),
              SizedBox(
                height: 30,
                child: ElevatedButton(
                  child: Text('True'),
                  onPressed: () => _onAnswerSelected(true),
                ),
              ),
              SizedBox(height: 30),
              SizedBox(
                height: 30,
                child: ElevatedButton(
                  child: Text('False'),
                  onPressed: () => _onAnswerSelected(false),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Time: ${_timer?.tick ?? 0} seconds',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  _questions.length,
                  (index) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: _buildQuestionIndicator(index),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuestionIndicator(int index) {
    bool isAnswered = index < _currentQuestionIndex;
    IconData iconData = isAnswered ? Icons.check : Icons.close;
    Color color = isAnswered ? Colors.green : Colors.red;
    return GestureDetector(
      onTap: () {
        setState(() {
          _currentQuestionIndex = index;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: isAnswered ? color.withOpacity(0.5) : null,
          shape: BoxShape.circle,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(
            iconData,
            color: isAnswered ? color : Colors.white,
            size: 20,
          ),
        ),
      ),
    );
  }
}

class McqQuizPage extends StatefulWidget {
  @override
  _McqQuizPageState createState() => _McqQuizPageState();
}

class _McqQuizPageState extends State<McqQuizPage> {
  int _currentQuestionIndex = 0;
  int _score = 0;
  bool _timerIsRunning = true;
  Timer? _timer;

  List<Map<String, dynamic>> _questions = [
    {
      'question': 'What is Flutter?',
      'options': [
        'A programming language',
        'A hybrid app development framework',
        'A mobile app SDK',
        'An operating system'
      ],
      'answer': 'A programming language',
    },
  ];

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_timerIsRunning) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_currentQuestionIndex >= _questions.length) {
      _timerIsRunning = false;
      return Scaffold(
        appBar: AppBar(
          title: Text('MCQ Quiz Results'),
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                  "assets/quiz.jpg"), // replace with your own image path
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: Text(
              'Your score is $_score',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
        ),
      );
    }
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image:
              AssetImage("assets/quiz.jpg"), // replace with your own image path
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Text('MCQ Quiz'),
        ),
        backgroundColor: Colors.transparent,
        // set the background color to transparent
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Question ${_currentQuestionIndex + 1}: ${_questions[_currentQuestionIndex]['question']}',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 20),
              for (String option in _questions[_currentQuestionIndex]
                  ['options'])
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: ElevatedButton(
                    child: Text(option),
                    onPressed: () {
                      if (option ==
                          _questions[_currentQuestionIndex]['answer']) {
                        _score++;
                      }
                      setState(() {
                        _currentQuestionIndex++;
                      });
                    },
                  ),
                ),
              SizedBox(height: 20),
              Text(
                'Time: ${_timer?.tick ?? 0} seconds',
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
