import 'package:flutter/material.dart';
import 'mainPage.dart'; 
import 'package:http/http.dart' as http;


const List<String> imgs = [
  'assets/chaos.png',
  'assets/OneAfter.jpg',
  'assets/todo.png'
];

const List<String> words = [
  '"When everything is at the edge of ultimate mess"',
  '"Start small, pick a small chunck at a time"',
  '"Orgainze Your Life Achieve Your Goals One Task At A Time"'
];
const List<String> btn = ["Continue", "Continue", "Get Started"];
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Navigation Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => MyWidget(),
        '/tasks': (context) => TasksPage(),
      },
    );
  }
}

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  int idx = 0;

  void _nextImage() {
    if (idx == imgs.length - 1) {
      Navigator.pushNamed(context, '/tasks');
    } else {
      setState(() {
        idx += 1;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: const Text('Engine'),
        backgroundColor: Color.fromARGB(255, 238, 235, 235),
      ),
      body: Column(
        children: [
          Container(
            color: Color.fromARGB(215, 215, 217, 255),
            child: Image(image: AssetImage(imgs[idx])),
          ),
          Spacer(),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Text(
              words[idx],
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int i = 0; i < imgs.length; i++)
                  Container(
                    width: 40,
                    height: 5,
                    margin: const EdgeInsets.symmetric(horizontal: 2),
                    decoration: BoxDecoration(
                      color: i == idx
                          ? const Color.fromARGB(255, 197, 232, 255)
                          : const Color.fromARGB(255, 215, 217, 255),
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
              ],
            ),
          ),
          // const SizedBox(height: 20),
          Spacer(),
          Align(
            alignment: Alignment.bottomCenter,
            child: TextButton(
              onPressed: _nextImage,
              child: Text(btn[idx]),
              style: TextButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 100, vertical: 8),
                textStyle: const TextStyle(fontSize: 20),
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
              ),
            ),
          )
        ],
      ),
    ));
  }
}
