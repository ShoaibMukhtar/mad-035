import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;


class HomeScreen extends StatelessWidget {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:Colors.deepPurpleAccent.withOpacity(0.8),
        title: Text('Notice Board APP'),
        actions: [
          IconButton(
            icon: Icon(Icons.account_box),
            onPressed: () {
              showMenu(
                color: Colors.deepPurpleAccent.withOpacity(0.5),
                context: context,
                position: RelativeRect.fromLTRB(85, 90,0, 60),
                items: [
                  PopupMenuItem<String>(
                    value: 'Option 1',
                    child: Container(
                      // Set the desired background color
                      child: ElevatedButton(
                        child: Text(
                          'Login as Admin',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromRGBO(168, 169, 232, 0.98),
                          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          elevation: 2.0,
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => LoginPage()),
                          );
                        },
                      ),

                    ),
                  ),
                  PopupMenuItem<String>(
                    value: 'Option 2',
                    child: Container(
                      // Set the desired background color
                      child:ElevatedButton(
                        child: Text(
                          'Login as User',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromRGBO(168, 169, 232, 0.98),

                          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          elevation: 2.0,
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => UserLoginPage()),
                          );
                        },
                      ),

                    ),
                  ),
                ],
              );
            },
          ),

        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/bg.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: _firestore.collection('notices').snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            }

            final notices = snapshot.data?.docs ?? [];

            if (notices.isEmpty) {
              return Text('No notices found.');
            }

            return ListView.builder(
              itemCount: notices.length,
              itemBuilder: (BuildContext context, int index) {
                final notice = notices[index].data();

                final noticeTitle = notice['notices'] ?? ''; // Ensure the value is not null
                final noticeDescription = notice['description'] ?? ''; // Ensure the value is not null
                final addedBy = notice['addedBy'] ?? ''; // Ensure the value is not null

                return Container(
                  margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  decoration: ShapeDecoration(
                    color: Colors.blueAccent.withOpacity(0.1),

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      side: BorderSide(color: Colors.blue.withOpacity(0.5), width: 3.0),
                    ),
                  ),
                  child: ListTile(
                    title: Text(noticeTitle,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 22)),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(' $noticeDescription',style: TextStyle(color: Colors.white,)),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:Colors.deepPurpleAccent.withOpacity(0.8),
        title: Text('Admin Login'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/bg.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(

          padding: EdgeInsets.all(16.0),
          child: Column(

            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _emailController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Email',
                  labelStyle: TextStyle(color: Colors.white),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(width: 2.0, color: Colors.white), // Increased border weight
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 2.0, color: Colors.white), // Increased border weight
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 2.0, color: Colors.white), // Increased border weight
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 2.0, color: Colors.red), // Increased border weight
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 2.0, color: Colors.red), // Increased border weight
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              TextFormField(
                style: TextStyle(color: Colors.white),
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  labelStyle: TextStyle(color: Colors.white),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(width: 2.0, color: Colors.white), // Increased border size
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 2.0, color: Colors.white), // Increased border size
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 2.0, color: Colors.white), // Increased border size
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),

                ),
                obscureText: true,
              ),
              SizedBox(height: 32.0),
              ElevatedButton(
                style:ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Color.fromRGBO(168, 169, 232, 0.98),
                  ),
                  minimumSize: MaterialStateProperty.all(Size(200, 60)), // Set the minimum size
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))), // Optional: Set the button shape
                  side: MaterialStateProperty.all(BorderSide(color: Colors.white)), // Optional: Set the outline color
                ),
                child: Text('Login'),
                onPressed: () {
                  _login(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _login(BuildContext context) async {
    final String email = _emailController.text.trim();
    final String password = _passwordController.text;

    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = userCredential.user;
      if (user != null) {
        // User logged in successfully, navigate to admin screen
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AdminScreen()),
        );
      }
    } catch (e) {
      print('Login failed: $e');
      // Handle login failure, display an error message to the user
    }
  }
}

class UserLoginPage extends StatefulWidget {
  @override
  _UserLoginPageState createState() => _UserLoginPageState();
}

class _UserLoginPageState extends State<UserLoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _roleController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:Colors.deepPurpleAccent.withOpacity(0.8),
        title: Text('User Login'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/bg.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _emailController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Email',
                  labelStyle: TextStyle(color: Colors.white),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(width: 2.0, color: Colors.white), // Increased border weight
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 2.0, color: Colors.white), // Increased border weight
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 2.0, color: Colors.white), // Increased border weight
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 2.0, color: Colors.red), // Increased border weight
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 2.0, color: Colors.red), // Increased border weight
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              TextFormField(
                style: TextStyle(color: Colors.white),
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  labelStyle: TextStyle(color: Colors.white),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(width: 2.0, color: Colors.white), // Increased border size
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 2.0, color: Colors.white), // Increased border size
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 2.0, color: Colors.white), // Increased border size
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),

                ),
                obscureText: true,
              ),
              SizedBox(height: 32.0),
              ElevatedButton(
                style:ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Color.fromRGBO(168, 169, 232, 0.98),
                  ),
                  minimumSize: MaterialStateProperty.all(Size(200, 60)), // Set the minimum size
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))), // Optional: Set the button shape
                  side: MaterialStateProperty.all(BorderSide(color: Colors.white)), // Optional: Set the outline color
                ),
                child: Text('Login'),
                onPressed: () {
                  _login(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _login(BuildContext context) async {
    final String email = _emailController.text.trim();
    final String password = _passwordController.text;
    final String role = _roleController.text.trim();

    String? fcmToken = await FirebaseMessaging.instance.getToken();

    try {
      QuerySnapshot<Map<String, dynamic>> snapshot = await _firestore
          .collection('users')
          .where('email', isEqualTo: email)
          .where('password', isEqualTo: password)
          .limit(1)
          .get();

      if (snapshot.docs.isNotEmpty) {
        // User logged in successfully, save the FCM token and navigate to user screen
        String userId = snapshot.docs[0].id;
        await _firestore.collection('users').doc(userId).update({
          'fcmToken': fcmToken,
        });
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => UserScreen()),
        );
      } else {
        print('Invalid credentials');
        // Display an error message to the user
      }
    } catch (e) {
      print('Login failed: $e');
      // Handle login failure, display an error message to the user
    }
  }
}

class AdminScreen extends StatefulWidget {
  @override
  _AdminScreenState createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  final TextEditingController _roleController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<bool> _onWillPop() async {
    return (await showDialog(
      context: context,
      builder: (context) => Container(

        child: AlertDialog(
          backgroundColor:  Colors.deepPurpleAccent.withOpacity(0.7),
          title: Text('Logout',style: TextStyle(color: Colors.white)),
          content: Text('Are you sure you want to log out?',style: TextStyle(color: Colors.white)),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text('No',style: TextStyle(color: Colors.white)),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text('Yes',style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    )) ??
        false;
  }

  void _getUsers() async {
    try {
      QuerySnapshot<Map<String, dynamic>> snapshot =
      await _firestore.collection('users').get();

      if (snapshot.docs.isNotEmpty) {
        print('Users:');
        for (QueryDocumentSnapshot<Map<String, dynamic>> doc
        in snapshot.docs) {
          print('ID: ${doc.id}, Email: ${doc['email']}, Role: ${doc['role']}');
        }
      } else {
        print('No users found');
      }
    } catch (e) {
      print('Failed to get users: $e');
    }
  }

  void _addUser() async {
    final String role = _roleController.text.trim();
    final String email = _emailController.text.trim();
    final String password = _passwordController.text;

    // Get the FCM token for the new user
    String? fcmToken = await FirebaseMessaging.instance.getToken();

    try {
      DocumentReference docRef = await _firestore.collection('users').add({
        'role': role,
        'email': email,
        'password': password,
        'fcmToken': fcmToken,
      });
      print('User added successfully with ID: ${docRef.id}');
    } catch (e) {
      print('Failed to add user: $e');
    }
  }
  void _updateUser(String userId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String updatedRole = '';
        String updatedEmail = '';
        String updatedPassword = '';

        return AlertDialog(
          backgroundColor:  Colors.deepPurpleAccent.withOpacity(0.7),
          title: Text('Update User'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                style: TextStyle(color: Colors.white),
                onChanged: (value) {
                  updatedRole = value;
                },
                decoration: InputDecoration(
                  labelText: 'Role',
                  labelStyle: TextStyle(color: Colors.white),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(width: 2.0, color: Colors.white), // Increased border weight
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 2.0, color: Colors.white), // Increased border weight
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 2.0, color: Colors.white), // Increased border weight
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 2.0, color: Colors.red), // Increased border weight
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 2.0, color: Colors.red), // Increased border weight
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              TextFormField(
                style: TextStyle(color: Colors.white),
                onChanged: (value) {
                  updatedEmail = value;
                },
                decoration: InputDecoration(
                  labelText: 'Email',
                  labelStyle: TextStyle(color: Colors.white),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(width: 2.0, color: Colors.white), // Increased border weight
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 2.0, color: Colors.white), // Increased border weight
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 2.0, color: Colors.white), // Increased border weight
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 2.0, color: Colors.red), // Increased border weight
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 2.0, color: Colors.red), // Increased border weight
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                style: TextStyle(color: Colors.white),
                onChanged: (value) {
                  updatedPassword = value;
                },
                decoration: InputDecoration(
                  labelText: 'Password',
                  labelStyle: TextStyle(color: Colors.white),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(width: 2.0, color: Colors.white), // Increased border weight
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 2.0, color: Colors.white), // Increased border weight
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 2.0, color: Colors.white), // Increased border weight
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 2.0, color: Colors.red), // Increased border weight
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 2.0, color: Colors.red), // Increased border weight
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: Text('Update'),
              onPressed: () async {
                try {
                  final Map<String, dynamic> updateData = {};

                  if (updatedRole.isNotEmpty) {
                    updateData['role'] = updatedRole;
                  }

                  if (updatedEmail.isNotEmpty) {
                    updateData['email'] = updatedEmail;
                  }

                  if (updatedPassword.isNotEmpty) {
                    updateData['password'] = updatedPassword;
                  }

                  await _firestore.collection('users').doc(userId).update(updateData);
                  print('User updated successfully');
                  Navigator.of(context).pop();
                } catch (e) {
                  print('Failed to update user: $e');
                  // You can show an error message here if desired
                }
              },
            ),
          ],
        );
      },
    );
  }




  void _deleteUser(String userId) async {
    try {
      await _firestore.collection('users').doc(userId).delete();
      print('User deleted successfully');
    } catch (e) {
      print('Failed to delete user: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor:Colors.deepPurpleAccent.withOpacity(0.8),
          title: Text('Admin Screen'),
          actions:[
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/home');
              },
              icon: Icon(Icons.logout),
            )
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/bg.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    style: TextStyle(color: Colors.white),
                    controller: _roleController,
                    decoration: InputDecoration(
                      labelText: 'Role',
                      labelStyle: TextStyle(color: Colors.white),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(width: 2.0, color: Colors.white), // Increased border size
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 2.0, color: Colors.white), // Increased border size
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 2.0, color: Colors.white), // Increased border size
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),

                    ),
                  ),
                  SizedBox(height: 32.0),
                  TextFormField(
                    style: TextStyle(color: Colors.white),
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      labelStyle: TextStyle(color: Colors.white),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(width: 2.0, color: Colors.white), // Increased border size
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 2.0, color: Colors.white), // Increased border size
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 2.0, color: Colors.white), // Increased border size
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),

                    ),
                  ),
                  SizedBox(height: 32.0),
                  TextFormField(
                    style: TextStyle(color: Colors.white),
                    controller: _passwordController,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: TextStyle(color: Colors.white),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(width: 2.0, color: Colors.white), // Increased border size
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 2.0, color: Colors.white), // Increased border size
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 2.0, color: Colors.white), // Increased border size
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),

                    ),
                    obscureText: true,
                  ),
                  SizedBox(height: 32.0),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Color.fromRGBO(168, 169, 232, 0.98),
                      ),
                      minimumSize: MaterialStateProperty.all(Size(200, 60)), // Set the minimum size
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))), // Optional: Set the button shape
                      side: MaterialStateProperty.all(BorderSide(color: Colors.white)), // Optional: Set the outline color
                    ),
                    child: Text('Add User'),
                    onPressed: _addUser,
                  ),
                  SizedBox(height: 16.0),
                  Text('Users:'),
                  SizedBox(height: 8.0),
                  StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                    stream: _firestore.collection('users').snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      }

                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      }

                      final users = snapshot.data?.docs ?? [];

                      if (users.isEmpty) {
                        return Text('No users found.');
                      }

                      return ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: users.length,
                        itemBuilder: (BuildContext context, int index) {
                          final user = users[index].data();

                          final userId = users[index].id;
                          final userEmail = user['email'] ?? '';
                          final userRole = user['role'] ?? '';

                          return Container(
                            margin: EdgeInsets.symmetric(vertical: 5.0, horizontal:0.0),
                            decoration: ShapeDecoration(
                              color: Colors.blueAccent.withOpacity(0.1),

                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                                side: BorderSide(color: Colors.blue.withOpacity(0.5), width: 3.0),
                              ),
                            ),
                            child: ListTile(
                              title: Text(userEmail),
                              subtitle: Text('Role: $userRole'),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all(Color.fromRGBO(168, 169, 232, 0.98),
                                      ),
                                      minimumSize: MaterialStateProperty.all(Size(40, 40)), // Set the minimum size
                                      shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))), // Optional: Set the button shape
                                      side: MaterialStateProperty.all(BorderSide(color: Colors.white)), // Optional: Set the outline color
                                    ),
                                    child: Text('Update'),
                                    onPressed: () {
                                      _updateUser(userId);
                                    },
                                  ),
                                  SizedBox(width: 8),
                                  ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all(Color.fromRGBO(168, 169, 232, 0.98),
                                      ),
                                      minimumSize: MaterialStateProperty.all(Size(40, 40)), // Set the minimum size
                                      shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))), // Optional: Set the button shape
                                      side: MaterialStateProperty.all(BorderSide(color: Colors.white)), // Optional: Set the outline color
                                    ),
                                    child: Text('Delete'),
                                    onPressed: () {
                                      _deleteUser(userId);
                                    },
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

}

class UserScreen extends StatefulWidget {
  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  final TextEditingController _noticeTextController = TextEditingController();
  final TextEditingController _noticedesController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  bool _showNotices = true;

  String? _currentUserId;

  @override
  void initState() {
    super.initState();
    _getCurrentUser();
  }
  Future<bool> _onWillPop() async {
    return (await showDialog(
      context: context,
      builder: (context) => Container(

        child: AlertDialog(
          backgroundColor:  Colors.deepPurpleAccent.withOpacity(0.7),
          title: Text('Logout',style: TextStyle(color: Colors.white)),
          content: Text('Are you sure you want to log out?',style: TextStyle(color: Colors.white)),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text('No',style: TextStyle(color: Colors.white)),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text('Yes',style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    )) ??
        false;
  }

  void _getCurrentUser() async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      setState(() {
        _currentUserId = currentUser.uid;
      });

      // Retrieve the FCM token for the current user
      String? fcmToken = await FirebaseMessaging.instance.getToken();
      print('FCM Token: $fcmToken');

    }
  }

  void _addNotice() async {
    final String noticeText = _noticeTextController.text.trim();
    final String noticedes = _noticedesController.text.trim();

    try {
      if (_currentUserId != null) {
        await FirebaseFirestore.instance.collection('notices').add({
          'notices': noticeText,
          'description': noticedes,
          'addedBy': _currentUserId,
        });

        print('Notice added successfully');

        // After adding the notice, send notifications to all users
        await _sendNotifications(noticeText);
      } else {
        print('User not logged in');
      }
    } catch (e) {
      print('Failed to add notice: $e');
    }
  }

  Future<void> _sendNotifications(String noticeText) async {
    try {
      // Get the FCM server API key from the Firebase Console
      final serverKey = 'AAAABUCGtEM:APA91bFWhj5EYfE-8WZJpWAd6Aa1QyaxCH1r0etFhSO_F_eYhA3vcAD2_10b5ait5tgbmwFepf2PT9dT5TQ1oBKFRGdMMytiq-javAuYk1GuZzHPhnnTo_dptlkD48SUMCCsarAWH15-';

      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'key=$serverKey',
      };

      // Get all user tokens from Firestore
      QuerySnapshot<Map<String, dynamic>> snapshot = await _firestore.collection('users').get();
      final List<String> fcmTokens = snapshot.docs
          .map((documentSnapshot) => documentSnapshot.data()['fcmToken'] as String?)
          .where((token) => token != null)
          .cast<String>()
          .toList();

      // If there are no tokens, return
      if (fcmTokens.isEmpty) {
        print('No registration tokens found.');
        return;
      }

      // Prepare the notification payload
      final message = {
        'notification': {
          'title': 'New Notice',
          'body': noticeText,
        },
        'registration_ids': fcmTokens,
        // You can also use 'tokens' instead of 'registration_ids', depending on the FCM version you are using.
      };

      // Send the notification using HTTP POST request
      final response = await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: headers,
        body: jsonEncode(message),
      );

      if (response.statusCode == 200) {
        print('Notification sent successfully.');
      } else {
        print('Failed to send notification. Error: ${response.body}');
      }
    } catch (e) {
      print('Failed to send notification: $e');
    }
  }

  void _deleteNotice(String noticeId) async {
    try {
      await _firestore.collection('notices').doc(noticeId).delete();
      print('Notice deleted successfully');
    } catch (e) {
      print('Failed to delete notice: $e');
    }
  }

  void _updateNotice(String noticeId, String newText, String newDes) async {
    try {
      await _firestore.collection('notices').doc(noticeId).update({
        'notices': newText,
        'description': newDes,
      });
      print('Notice updated successfully');
    } catch (e) {
      print('Failed to update notice: $e');
    }
  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor:Colors.deepPurpleAccent.withOpacity(0.8),
          title: Text('User Screen'),
          actions:[
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context,'/home' );
              },
              icon: Icon(Icons.logout),
            )
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/bg.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 32.0),
                  TextFormField(
                    style: TextStyle(color: Colors.white),
                    controller: _noticeTextController,
                    decoration: InputDecoration(
                      labelText: 'Tittle',
                      labelStyle: TextStyle(color: Colors.white),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(width: 2.0, color: Colors.white), // Increased border size
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 2.0, color: Colors.white), // Increased border size
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 2.0, color: Colors.white), // Increased border size
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),

                    ),
                  ),
                  SizedBox(height: 32.0),
                  TextFormField(
                    style: TextStyle(color: Colors.white),
                    controller: _noticedesController,
                    decoration: InputDecoration(
                      labelText: 'Description',
                      labelStyle: TextStyle(color: Colors.white),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(width: 2.0, color: Colors.white), // Increased border size
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 2.0, color: Colors.white), // Increased border size
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 2.0, color: Colors.white), // Increased border size
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),

                    ),
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Color.fromRGBO(168, 169, 232, 0.98),
                      ),
                      minimumSize: MaterialStateProperty.all(Size(40, 40)), // Set the minimum size
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))), // Optional: Set the button shape
                      side: MaterialStateProperty.all(BorderSide(color: Colors.white)), // Optional: Set the outline color
                    ),
                    child: Text('Add Notice'),
                    onPressed: _addNotice,
                  ),
                  SizedBox(height: 16.0),
                  _showNotices ? _buildNoticeList() : SizedBox(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNoticeList() {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore
          .collection('notices')
          .where('addedBy', isEqualTo: _currentUserId)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return CircularProgressIndicator();
        }

        List<Widget> noticeWidgets = [];
        for (QueryDocumentSnapshot doc in snapshot.data!.docs) {
          String noticeId = doc.id;
          String noticeText = doc['notices'];

          noticeWidgets.add(
            Container(
              margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              decoration: ShapeDecoration(
                color: Colors.blueAccent.withOpacity(0.1),

                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  side: BorderSide(color: Colors.blue.withOpacity(0.5), width: 3.0),
                ),
              ),
              child: ListTile(
                title: Text(noticeText, style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18, // Set the text size to 18
                )),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(

                      icon: Icon(Icons.edit,color: Colors.white),
                      onPressed: () {
                        _showUpdateDialog(noticeId, noticeText);
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.delete,color: Colors.white),
                      onPressed: () {
                        _deleteNotice(noticeId);
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        }

        return Column(
          children: noticeWidgets,
        );
      },
    );
  }


  void _showUpdateDialog(String noticeId, String currentText) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        TextEditingController textEditingController = TextEditingController(text: currentText);
        TextEditingController desEditingController = TextEditingController(text: currentText);

        return AlertDialog(
          backgroundColor:  Colors.deepPurpleAccent.withOpacity(0.7),
          title: Text('Update Notice'),
          content: ListView(
            shrinkWrap: true,
            children: [
              TextFormField(
                style: TextStyle(color: Colors.white),
                controller: textEditingController,
                decoration: InputDecoration(
                  labelText: 'New Tittle',
                  labelStyle: TextStyle(color: Colors.white),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(width: 2.0, color: Colors.white), // Increased border size
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 2.0, color: Colors.white), // Increased border size
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 2.0, color: Colors.white), // Increased border size
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),

                ),
              ),
              SizedBox(height: 16.0),
              TextFormField(
                style: TextStyle(color: Colors.white),
                controller: desEditingController,
                decoration: InputDecoration(
                  labelText: 'New Descrition',
                  labelStyle: TextStyle(color: Colors.white),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(width: 2.0, color: Colors.white), // Increased border size
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 2.0, color: Colors.white), // Increased border size
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 2.0, color: Colors.white), // Increased border size
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),

                ),
              ),
            ],
          ),


          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel', style: TextStyle(color: Colors.white)),
            ),
            TextButton(
              onPressed: () {
                _updateNotice(noticeId, textEditingController.text, desEditingController.text); // Update the method call
                Navigator.of(context).pop();
              },
              child: Text('Update', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }
}

class UserModel {
  final String id;
  final String role;
  final String email;
  final String password;

  UserModel({
    required this.id,
    required this.role,
    required this.email,
    required this.password,
  });
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    routes: {
      '/': (context) => SplashScreen(),
      '/home': (context) => HomeScreen(),
      // Define other routes here
    },
    debugShowCheckedModeBanner: false,
   // home: SplashScreen(),
  ));
}


class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      Duration(seconds: 4),
          () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );

      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/bg.jpg'), // Replace with your background image path
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Image.asset('assets/logo.png', height: 250, width: 250), // Replace with your game logo image path
        ),
      ),
    );
  }
}