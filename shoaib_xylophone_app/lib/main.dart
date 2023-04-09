import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

void main() {
  runApp(XylophoneApp());
}

class XylophoneApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: XylophonePage(),
    );
  }
}

class XylophonePage extends StatefulWidget {
  @override
  _XylophonePageState createState() => _XylophonePageState();
}

class _XylophonePageState extends State<XylophonePage> {
  int _numberOfKeys = 7;
  List<Color> _keyColors = [
    Colors.red,
    Colors.orange,
    Colors.yellow,
    Colors.green,
    Colors.teal,
    Colors.blue,
    Colors.purple,
  ];
  List<String> _notePaths = [
    'note1.wav',
    'note2.wav',
    'note3.wav',
    'note4.wav',
    'note5.wav',
    'note6.wav',
    'note7.wav',
  ];
  Map<String, AssetsAudioPlayer> _players = {};


  Future<void> _initPlayers() async {
    for (int i = 0; i < _numberOfKeys; i++) {
      String notePath = _notePaths[i];
      AssetsAudioPlayer player = await _loadPlayer(notePath);
      _players[notePath] = player;
    }
  }

  Future<AssetsAudioPlayer> _loadPlayer(String notePath) async {
    final ByteData data = await rootBundle.load('assets/audio/$_notePaths');
    final tempDir = await getTemporaryDirectory();
    final file = File('${tempDir.path}/$_notePaths');
    await file.writeAsBytes(data.buffer.asUint8List(), flush: true);
    return AssetsAudioPlayer.newPlayer()
      ..open(
        Audio.file(
          file.path,
          metas: Metas(
            title: notePath,
            artist: 'Xylophone App',
            album: 'Xylophone App',
            image: MetasImage.asset('assets/images/xylophone.png'),
          ),
        ),
      );
  }

  @override
  void initState()  {
    super.initState();
     _initPlayers();
  }

  @override
  void dispose() {
    for (AssetsAudioPlayer player in _players.values) {
      player.dispose();
    }
    super.dispose();
  }

  void _playSound(int keyIndex) {
    String notePath = _notePaths[keyIndex];
    AssetsAudioPlayer player = _players[_notePaths]!;
    player.play();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Xylophone'),
        ),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              for (int i = 0; i < _numberOfKeys; i++)
                Expanded(
                  child: TextButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          _keyColors[i % _keyColors.length]),
                    ),
                    onPressed: () {
                      _playSound(i);
                    },
                    child: Container(),
                  ),
                ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              TextEditingController controller =
                  TextEditingController(text: '$_numberOfKeys');
              Color selectedColor = Colors.red;
              String selectedNote = 'note1.wav';

              return AlertDialog(
                title: const Text('Xylophone Settings'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      controller: controller,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Number of keys',
                      ),
                    ),
                    SizedBox(height: 16.0),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Color',
                      ),
                      onTap: () async {
                        Color? color = await showDialog<Color>(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text('Choose a color'),
                              content: SingleChildScrollView(
                                child: ColorPicker(
                                  pickerColor: selectedColor,
                                  onColorChanged: (color) {
                                    selectedColor = color;
                                  },
                                  showLabel: true,
                                  pickerAreaHeightPercent: 0.8,
                                ),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context, selectedColor);
                                  },
                                  child: Text('OK'),
                                ),
                              ],
                            );
                          },
                        );
                        if (color != null) {
                          selectedColor = color;
                        }
                      },
                    ),
                    SizedBox(height: 16.0),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Audio note',
                      ),
                      onTap: () async {
                        String? note = await showDialog<String>(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text('Choose an audio note'),
                              content: SingleChildScrollView(
                                child: Column(
                                  children: _notePaths
                                      .map((path) => ListTile(
                                            title: Text(path),
                                            trailing: selectedNote == path
                                                ? Icon(Icons.check)
                                                : null,
                                            onTap: () {
                                              selectedNote = path;
                                              Navigator.pop(
                                                  context, selectedNote);
                                            },
                                          ))
                                      .toList(),
                                ),
                              ),
                            );
                          },
                        );
                        if (note != null) {
                          selectedNote = note;
                        }
                      },
                    ),
                    SizedBox(height: 16.0),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          _numberOfKeys = int.parse(controller.text) + 1;
                          _keyColors = List.generate(
                            _numberOfKeys,
                            (index) => index == _numberOfKeys - 1
                                ? selectedColor
                                : _keyColors[index % _keyColors.length],
                          );
                          _notePaths = List.generate(
                            _numberOfKeys,
                            (index) => index == _numberOfKeys - 1
                                ? selectedNote
                                : 'note$index.wav',
                          );
                          _initPlayers();
                        });
                        ;
                        Navigator.pop(context);
                      },
                      child: const Text('Save'),
                    ),
                  ],
                ),
              );
            },
          );
        }));
  }
}
