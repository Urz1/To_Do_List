import 'package:flutter/material.dart';
import 'package:expandable_menu/expandable_menu.dart'; // Ensure this package is added in pubspec.yaml
import 'package:table_calendar/table_calendar.dart';
import 'api_services.dart';

const List<String> words = [
  '"When everything is at the edge of ultimate mess"',
  '"Start small, pick a small chunck at a time"',
  '"Orgainze Your Life Achieve Your Goals One Task At A Time"'
];
int idx = 0;
final ApiService apiService = ApiService();

void main() {
  runApp(TasksApp());
}

class TasksApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TasksPage(),
    );
  }
}

class TasksPage extends StatefulWidget {
  @override
  State<TasksPage> createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
  DateTime _selectedValue = DateTime.now();
  bool _isMenuOpen = false;

  void _toggleMenu() {
    setState(() {
      _isMenuOpen = !_isMenuOpen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          color: Colors.blue,
          icon: Icon(Icons.menu),
          onPressed: () {
            _toggleMenu();
            AddTasks();
          },
        ),
        title: Text('My App'),
      ),
      body: _isMenuOpen
          ? AddTasks()
          : Column(
              children: [
                for (int i = 0; i < words.length; i++) TaskCard(index: i),
              ],
            ),
    );
  }
}

class TaskCard extends StatelessWidget {
  final int index;

  TaskCard({required this.index});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Container(
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Color.fromARGB(255, 210, 210, 210)),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(words[index]),
            ),
            IconButton(
              color: Colors.blue,
              onPressed: () {},
              icon: Icon(Icons.edit),
            ),
            IconButton(
              color: Colors.blue,
              onPressed: () {},
              icon: Icon(Icons.delete),
            ),
            SizedBox(width: 8),
          ],
        ),
      ),
    );
  }
}

class AddTasks extends StatefulWidget {
  const AddTasks({super.key});

  @override
  State<AddTasks> createState() => _AddTasksState();
}

class _AddTasksState extends State<AddTasks> {
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();
  final TextEditingController _titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40),
      child: Container(
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 207, 207, 207),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40), topRight: Radius.circular(40)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Text(
                "Task Title",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _titleController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Add Title',
                ),
              ),
              SizedBox(height: 20),
              TableCalendar(
                firstDay: DateTime.utc(2000, 1, 1),
                lastDay: DateTime.utc(2100, 12, 31),
                focusedDay: _focusedDay,
                selectedDayPredicate: (day) {
                  return isSameDay(_selectedDay, day);
                },
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    _selectedDay = selectedDay;
                    _focusedDay = focusedDay;
                  });
                },
              ),
              SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () async {
                    String taskday = _focusedDay.toIso8601String();
                    List<dynamic> inputData = [taskday, _titleController.text];
                    try {
                      final response =
                          await apiService.sendData(inputData as dynamic);
                      print(response); // Handle response in the UI (optional)
                    } catch (e) {
                      print('error: $e');
                    }
                  },
                  child: Text("Save"),
                  style: TextButton.styleFrom(
                    iconColor: Colors.white,
                    backgroundColor: Colors.blue,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    textStyle: TextStyle(fontSize: 16),
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
