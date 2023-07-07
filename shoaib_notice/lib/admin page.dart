class UserScreen extends StatefulWidget {
  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  bool _hideNotices = false; // Add a boolean variable to control the visibility of notices on the home screen

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent.withOpacity(0.8),
        title: Text('User Screen'),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text(_hideNotices ? 'Show Notices' : 'Hide Notices'), // Update button text based on _hideNotices value
          onPressed: () {
            setState(() {
              _hideNotices = !_hideNotices; // Toggle _hideNotices value
            });
          },
        ),
      ),
    );
  }
}
