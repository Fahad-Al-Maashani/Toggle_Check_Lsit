import 'package:flutter/material.dart';

void main() {
  runApp(const ToggleListApp());
}

class ToggleListApp extends StatelessWidget {
  const ToggleListApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Toggle List App',
      theme: ThemeData(
        colorSchemeSeed: Colors.indigo,
        useMaterial3: true,
        brightness: Brightness.light,
      ),
      home: const ToggleScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ToggleScreen extends StatefulWidget {
  const ToggleScreen({super.key});

  @override
  State<ToggleScreen> createState() => _ToggleScreenState();
}

class _ToggleScreenState extends State<ToggleScreen> {
  final List<Map<String, dynamic>> items = [];
  final TextEditingController _controller = TextEditingController();

  void _addItem() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        items.add({'name': _controller.text, 'isToggled': false});
        _controller.clear();
      });
    }
  }

  void _toggleItem(int index, bool value) {
    setState(() {
      items[index]['isToggled'] = value;
    });
  }

  double _getProgress() {
    if (items.isEmpty) return 0.0;
    int toggledCount = items.where((item) => item['isToggled'] as bool).length;
    return toggledCount / items.length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Toggle List Example')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      labelText: 'Enter item',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _addItem,
                  child: const Text('Add'),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(items[index]['name']),
                  trailing: Switch(
                    value: items[index]['isToggled'] as bool,
                    onChanged: (value) => _toggleItem(index, value),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                LinearProgressIndicator(
                  value: _getProgress(),
                  minHeight: 8,
                  backgroundColor: Colors.grey.shade300,
                  color: Colors.indigo,
                ),
                const SizedBox(height: 5),
                Text(
                  'Progress: ${(_getProgress() * 100).toStringAsFixed(0)}%',
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
