import 'package:flutter/material.dart';
import 'package:assets_audio_player/assets_audio_player.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Xylophone'),
        ),
        body: Xylo(),
      ),
    );
  }
}

class Xylo extends StatefulWidget {
  const Xylo({Key? key}) : super(key: key);

  @override
  State<Xylo> createState() => _XyloState();
}

class _XyloState extends State<Xylo> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          color: Colors.blue,
          child: TextButton(
              onPressed: () {
                AssetsAudioPlayer.newPlayer()
                    .open(Audio('assets/audio/assets_note1.wav'));
              },
              child: Text('Button 01')),
        ),
        SizedBox(height: 10,),
        Container(
          color: Colors.blue,
          child: TextButton(
              onPressed: () {
                AssetsAudioPlayer.newPlayer()
                    .open(Audio('assets/audio/assets_note2.wav'));
              },
              child: Text('Button 01')),
        ),
        SizedBox(height: 10,),
        Container(
          color: Colors.blue,
          child: TextButton(
              onPressed: () {
                AssetsAudioPlayer.newPlayer()
                    .open(Audio('assets/audio/assets_note3.wav'));
              },
              child: Text('Button 01')),
        ),
        SizedBox(height: 10,),
        Container(
          color: Colors.blue,
          child: TextButton(
              onPressed: () {
                AssetsAudioPlayer.newPlayer()
                    .open(Audio('assets/audio/assets_note4.wav'));
              },
              child: Text('Button 01')),
        ),
        SizedBox(height: 10,),
        Container(
          color: Colors.blue,
          child: TextButton(
              onPressed: () {
                AssetsAudioPlayer.newPlayer()
                    .open(Audio('assets/audio/assets_note5.wav'));
              },
              child: Text('Button 01')),
        ),
        SizedBox(height: 10,),
        Container(
          color: Colors.blue,
          child: TextButton(
              onPressed: () {
                AssetsAudioPlayer.newPlayer()
                    .open(Audio('assets/audio/assets_note6.wav'));
              },
              child: Text('Button 01')),
        ),
        SizedBox(height: 10,),
        Container(
          color: Colors.blue,
          child: TextButton(
              onPressed: () {
                AssetsAudioPlayer.newPlayer()
                    .open(Audio('assets/audio/assets_note7.wav'));
              },
              child: Text('Button 01')),
        )

      ],
    );
  }
}