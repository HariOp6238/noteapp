import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class editscreen extends StatefulWidget {
  const editscreen({super.key});

  @override
  State<editscreen> createState() => _editscreenState();
}

class _editscreenState extends State<editscreen> {
  TextEditingController titlecontroller = TextEditingController();
  TextEditingController contentcontroller = TextEditingController();

  List<Map<String, dynamic>> newnotes = [];

  final _notebox = Hive.box('notebox');
  @override
  void initState() {
    super.initState();
    refreshitem();
  }

  void refreshitem() {
    final data = _notebox.keys.map((Key) {
      final _item = _notebox.get(Key);
      return {
        "key": Key,
        "title": _item["title"],
        "content": _item['content'],
        "date": _item['date']
      };
    }).toList();
    setState(() {
      newnotes = data.reversed.toList();
      print(newnotes.length);
    });
  }

  Future<void> createitem(Map<String, dynamic> newitem) async {
    await _notebox.add(newitem);
    refreshitem();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          elevation: 10,
          onPressed: () {
            createitem({
              "title": titlecontroller.text,
              "content": contentcontroller.text
            });
            Navigator.pop(
                context, [titlecontroller.text, contentcontroller.text]);
          },
          child: Center(child: Icon(Icons.save)),
        ),
        backgroundColor: Colors.grey.shade900,
        body: Padding(
          padding: EdgeInsets.fromLTRB(16, 10, 16, 20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            color: Colors.grey.shade800.withOpacity(.8),
                            borderRadius: BorderRadius.circular(8)),
                        child: Icon(
                          Icons.arrow_back_ios_new,
                          color: Colors.white,
                        ),
                      ))
                ],
              ),
              Expanded(
                  child: ListView(
                children: [
                  TextField(
                    controller: titlecontroller,
                    style: TextStyle(color: Colors.white, fontSize: 30),
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Title",
                        hintStyle:
                            TextStyle(color: Colors.white, fontSize: 30)),
                  ),
                  TextField(
                    controller: contentcontroller,
                    style: TextStyle(color: Colors.white, fontSize: 20),
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Type something here...",
                        hintStyle:
                            TextStyle(color: Colors.white, fontSize: 20)),
                  )
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
