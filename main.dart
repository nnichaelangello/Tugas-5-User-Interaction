import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tugas 5',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Tugas 5'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Map<String, String>> data = [
    {
      "title": "Native App",
      "platform": "Android, iOS",
      "lang": "Java, Kotlin, Swift, C#",
      "color": "red"
    },
    {
      "title": "Hybrid App",
      "platform": "Android, iOS, Web",
      "lang": "Javascript, Dart",
      "color": "blue"
    }
  ];

  var titleInput = TextEditingController();
  var platInput = TextEditingController();
  var langInput = TextEditingController();
  List<String> colors = ['blue', 'green', 'yellow'];
  List<bool> isSelected = [true, false, false];
  int colIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          return Card(
            color: () {
              if (data[index]["color"] == "blue") return Colors.blue;
              if (data[index]["color"] == "green") return Colors.green;
              if (data[index]["color"] == "yellow") return Colors.yellow;
              return Colors.red;
            }(),
            child: ListTile(
              title: Text(
                data[index]["title"] ?? '',
                style: const TextStyle(fontSize: 20),
              ),
              subtitle: Text(
                  'Platform: ${data[index]["platform"] ?? ''}\nLang: ${data[index]["lang"] ?? ''}'),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return StatefulBuilder(
                builder: (context, setDialogState) {
                  return AlertDialog(
                    title: const Text('Add Data'),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextField(
                          controller: titleInput,
                          decoration: const InputDecoration(hintText: "Title"),
                        ),
                        TextField(
                          controller: platInput,
                          decoration: const InputDecoration(hintText: "Platform"),
                        ),
                        TextField(
                          controller: langInput,
                          decoration: const InputDecoration(hintText: "Lang"),
                        ),
                        const SizedBox(height: 10),
                        ToggleButtons(
                          isSelected: isSelected,
                          onPressed: (int index) {
                            setDialogState(() {
                              for (int i = 0; i < isSelected.length; i++) {
                                isSelected[i] = i == index;
                              }
                              colIndex = index;
                            });
                          },
                          children: const [
                            Icon(Icons.circle, color: Colors.blue),
                            Icon(Icons.circle, color: Colors.green),
                            Icon(Icons.circle, color: Colors.yellow),
                          ],
                        ),
                      ],
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            data.add({
                              "title": titleInput.text,
                              "platform": platInput.text,
                              "lang": langInput.text,
                              "color": colors[colIndex]
                            });
                          });

                          // Reset form values after saving
                          titleInput.clear();
                          platInput.clear();
                          langInput.clear();
                          setDialogState(() {
                            for (var i = 0; i < isSelected.length; i++) {
                              isSelected[i] = i == 0;
                            }
                            colIndex = 0;
                          });

                          Navigator.pop(context);
                        },
                        child: const Text('Save'),
                      ),
                    ],
                  );
                },
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
