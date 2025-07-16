import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PRGenie',
      theme: ThemeData.dark(),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  static const List<Widget> _pages = [
    HomeScreen(),
    SearchScreen(),
    NotificationScreen(),
    AccountScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("PRGenie - ${_titles[_selectedIndex]}")),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.white,
        backgroundColor: Colors.black,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notify',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Account'),
        ],
      ),
    );
  }
}

const List<String> _titles = ['Home', 'Search', 'Notify', 'Account'];

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _captionController = TextEditingController();
  bool _autoSchedule = true;
  DateTime? _manualDateTime;

  void _pickDateTime() async {
    DateTime now = DateTime.now();
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now,
      lastDate: now.add(const Duration(days: 30)),
    );
    if (picked != null) {
      TimeOfDay? time = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );
      if (time != null) {
        setState(() {
          _manualDateTime = DateTime(
            picked.year,
            picked.month,
            picked.day,
            time.hour,
            time.minute,
          );
        });
      }
    }
  }

  void _sharePost() {
    if (_captionController.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Please enter a caption")));
      return;
    }

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Post Ready"),
        content: Text(
          "Caption: ${_captionController.text}\n"
          "Schedule: ${_autoSchedule ? "Auto" : _manualDateTime.toString()}",
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text("Upload feature disabled in Web Preview."),
        const SizedBox(height: 10),
        TextField(
          controller: _captionController,
          decoration: const InputDecoration(
            labelText: 'Enter Caption',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 10),
        CheckboxListTile(
          value: _autoSchedule,
          onChanged: (val) {
            setState(() {
              _autoSchedule = val!;
            });
          },
          title: const Text("Auto Schedule"),
        ),
        if (!_autoSchedule)
          ElevatedButton.icon(
            onPressed: _pickDateTime,
            icon: const Icon(Icons.schedule),
            label: Text(
              _manualDateTime == null
                  ? "Pick Date & Time"
                  : "Scheduled: ${_manualDateTime.toString()}",
            ),
          ),
        const SizedBox(height: 20),
        ElevatedButton.icon(
          onPressed: _sharePost,
          icon: const Icon(Icons.send),
          label: const Text("Share Post"),
          style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
        ),
      ],
    );
  }
}

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("Search Screen (Coming Soon)"));
  }
}

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("Notifications will appear here."));
  }
}

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("Your Account Details"));
  }
}
