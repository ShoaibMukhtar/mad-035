import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Resume App',
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/bg.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Profile section
                    Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                        color: Colors.black.withOpacity(0.3), // set opacity to 0.5
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 80,
                            backgroundImage:
                                AssetImage('assets/images/img.jpg'),
                          ),
                          SizedBox(height: 16),
                          Text(
                            'Shoaib Mukhtar',
                            style: TextStyle(
                                fontSize: 24,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Software Developer',
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Main Multan Road Sabzazar Lahore\n0316-6628674\nshoaibmukhtar2015@gmail.com',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 14, color: Colors.white),
                          ),
                          SizedBox(height: 16),
                          Text(
                            'Experienced software developer with a passion for creating innovative solutions that solve real-world problems.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),

                    // Education section

                    Container(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Education',
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.blue,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 8),
                          Row(children:
                          [
                            Icon(Icons.abc_outlined),
                            SizedBox(width: 8),
                            Text(
                              'Bachelor of Computer Science ',
                              style: TextStyle(fontSize: 16),
                            ),
                          ]),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              Icon(Icons.school),
                              SizedBox(width: 8),
                              Text(
                                'Comsats University Islamabad',
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          Row(
                            children: [],
                          ),
                        ],
                      ),
                    ),

                    // Skills section
                    Container(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Skills & Expertise',
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.blue,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              Icon(Icons.code),
                              SizedBox(width: 8),
                              Text(
                                'Programming Languages:',
                                style: TextStyle(fontSize: 16),
                              ),
                              SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  'Dart, C++',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              Icon(Icons.developer_mode),
                              SizedBox(width: 8),
                              Text(
                                'Frameworks & Libraries:',
                                style: TextStyle(fontSize: 16),
                              ),
                              SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  'Flutter, React',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              Icon(Icons.settings),
                              SizedBox(width: 8),
                              Text(
                                'Tools & Technologies:',
                                style: TextStyle(fontSize: 16),
                              ),
                              SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  'Git, AWS',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // Hobbies section
                    Container(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Hobbies',
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.blue,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              Icon(Icons.videogame_asset_outlined),
                              SizedBox(width: 8),
                              Text(
                                'Playing Games',
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          ),

                          SizedBox(height: 8),
                          Row(
                            children: [
                              Icon(Icons.music_note),
                              SizedBox(width: 8),
                              Text(
                                'Playing guitar',
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              Icon(Icons.camera_alt),
                              SizedBox(width: 8),
                              Text(
                                'Photography',
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              Icon(Icons.fitness_center),
                              SizedBox(width: 8),
                              Text(
                                'Fitness',
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // Achievements section
                    Container(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Achievements',
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.blue,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              Icon(Icons.star),
                              SizedBox(width: 8),
                              Text(
                                'PRESIDENT of Gaming and \n Programming Society',
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              Icon(Icons.star),
                              SizedBox(width: 8),
                              Text(
                                'PRESIDENT of Student Reading Club',
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              Icon(Icons.local_activity),
                              SizedBox(width: 8),
                              Text(
                                '3rd Position At Visio Spark 2023',
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
