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

  List<Map<String, dynamic>> _questions = [ {
    'question': 'Flutter uses the Dart programming language.',
    'answer': true,
  },
    {
      'question': 'Flutter apps can only be developed on macOS.',
      'answer': false,
    },
    {
      'question': 'Flutter provides a rich set of pre-built widgets.',
      'answer': true,
    },
    {
      'question': 'Flutter is a hybrid app development framework.',
      'answer': false,
    },
    {
      'question': 'Flutter has native support for hot-reload.',
      'answer': true,
    },
    {
      'question': 'Flutter apps can only be deployed on the Google Play Store.',
      'answer': false,
    },
    {
      'question': 'Flutter provides built-in support for unit testing.',
      'answer': true,
    },
    {
      'question': 'Flutter is a popular choice for developing web apps.',
      'answer': false,
    },
    {
      'question': 'Flutter can be used to develop desktop apps.',
      'answer': true,
    },
    {
      'question': 'Flutter is a free and open-source software development kit.',
      'answer': true,
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
                child: Text('Your score is $_score', style: TextStyle(
                    color: Colors.white,
                    fontSize: 24),
                ),
              )
          )
      );
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
              Text(
                'Question ${_currentQuestionIndex +
                    1}: ${_questions[_currentQuestionIndex]['question']}',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, color: Colors.white,
                ),
              ),
              SizedBox(height: 30),
              SizedBox(
                height: 30,
                child: ElevatedButton(
                  child: Text('True'),
                  onPressed: () {
                    if (_questions[_currentQuestionIndex]['answer'] == true) {
                      _score++;
                    }
                    setState(() {
                      _currentQuestionIndex++;
                    });
                  },
                ),
              ),
              SizedBox(height: 30),
              SizedBox(
                height: 30,
                child: ElevatedButton(
                  child: Text('False'),
                  onPressed: () {
                    if (_questions[_currentQuestionIndex]['answer'] == false) {
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
    {
      'question': 'What is Dart?',
      'options': [
        'A type of bird',
        'A type of drink',
        'A programming language',
        'A type of dance'
      ],
      'answer': 'A type of bird',
    },
    {
      'question': 'What is a widget in Flutter?',
      'options': [
        'A type of plant',
        'A user interface element',
        'A type of animal',
        'A type of mineral'
      ],
      'answer': 'A user interface element',
    },
    {
      'question': 'What is hot-reload in Flutter?',
      'options': [
        'A type of coffee',
        'A feature for fast development',
        'A type of car',
        'A type of food'
      ],
      'answer': 'A feature for fast development',
    },
    {
      'question': 'What is a scaffold in Flutter?',
      'options': [
        'A type of tool',
        'A user interface element',
        'A type of building',
        'A type of bird'
      ],
      'answer': 1,
    },
    {
      'question': 'What is a stateful widget in Flutter?',
      'options': [
        'A widget that can change',
        'A widget that cannot change',
        'A type of bird',
        'A type of plant'
      ],
      'answer': 'A widget that can change',
    },
    {
      'question': 'What is a future in Dart?',
      'options': [
        'A type of event',
        'A type of plant',
        'A type of bird',
        'A type of asynchronous operation'
      ],
      'answer': 'A type of event',
    },
    {
      'question': 'What is an async function in Dart?',
      'options': [
        'A function that runs synchronously',
        'A function that runs asynchronously',
        'A type of bird',
        'A type of plant'
      ],
      'answer': 'A function that runs synchronously',
    },
    {
      'question': 'What is a stream in Dart?',
      'options': [
        'A type of water',
        'A type of event',
        'A type of plant',
        'A type of bird'
      ],
      'answer': 'A type of event',
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
          image: AssetImage(
              "assets/quiz.jpg"), // replace with your own image path
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
                'Question ${_currentQuestionIndex +
                    1}: ${_questions[_currentQuestionIndex]['question']}',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, color: Colors.white,
                ),

              ),
              SizedBox(height: 20),
              for (String option in _questions[_currentQuestionIndex]['options'])
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