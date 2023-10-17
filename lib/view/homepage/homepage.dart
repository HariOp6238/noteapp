import 'dart:math';

import 'package:flutter/material.dart';

import 'package:notepad/constant/colors.dart';
import 'package:notepad/models/editnotes.dart';
import 'package:notepad/models/notes.dart';

class homescreen extends StatefulWidget {
  const homescreen({super.key});

  @override
  State<homescreen> createState() => _homescreenState();
}

class _homescreenState extends State<homescreen> {
  getrandomcolor() {
    Random random = Random();
    return backgroundcolor[random.nextInt(backgroundcolor.length)];
  }

  void deletedata(int index) {
    setState(() {
      Samplenotes.removeAt(index);
    });
  }

  // void onsearchtextchange(String searchtext) {
  //   setState(() {
  //     Samplenotes = Samplenotes;
  //     Samplenotes.where((Notes) =>
  //             Notes.content.toLowerCase().contains(searchtext.toLowerCase()) ||
  //             Notes.title.toLowerCase().contains(searchtext.toLowerCase()))
  //         .toList();
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => editscreen(),
              ));
          if (result != null) {
            setState(() {
              Samplenotes.add(Notes(
                  id: Samplenotes.length,
                  Modifiedtime: DateTime.now(),
                  content: result[1],
                  title: result[0]));
            });
          }
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      backgroundColor: Colors.grey.shade900,
      // appBar: AppBar(),
      body: Padding(
          padding: const EdgeInsets.fromLTRB(16, 10, 16, 20),
          child: SingleChildScrollView(
            child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Notes",
                    style: TextStyle(color: Colors.white, fontSize: 30),
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            color: Colors.grey.shade800.withOpacity(.8),
                            borderRadius: BorderRadius.circular(8)),
                        child: Icon(
                          Icons.sort,
                          color: Colors.white,
                        ),
                      ))
                ],
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                  // onChanged: onsearchtextchange,
                  style: TextStyle(color: Colors.white, fontSize: 16),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 12),
                    hintText: "search Notes..",
                    hintStyle: TextStyle(color: Colors.grey),
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.grey,
                    ),
                    filled: true,
                    fillColor: Colors.grey.shade800,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(color: Colors.transparent),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(color: Colors.transparent),
                    ),
                  )),
              SizedBox(
                height: 10,
              ),
              Container(
                width: double.infinity,
                height: 700,
                child: ListView.builder(
                  itemCount: Samplenotes.length,
                  itemBuilder: (context, index) => Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: ListTile(
                      title: RichText(
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        text: TextSpan(
                          text: '${Samplenotes[index].title}: \n',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              height: 1.5),
                          children: [
                            TextSpan(
                              text: '${Samplenotes[index].content}: \n',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  height: 1.5),
                            )
                          ],
                        ),
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Text('${Samplenotes[index].Modifiedtime}: \n'),
                      ),
                      trailing: IconButton(
                        onPressed: () async {
                          final result = await showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  backgroundColor: Colors.grey.shade200,
                                  icon: Icon(
                                    Icons.info,
                                    color: Colors.grey,
                                  ),
                                  title: Text(
                                    "Do you want to delete",
                                    style:
                                        TextStyle(color: Colors.grey.shade900),
                                  ),
                                  content: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      ElevatedButton(
                                        onPressed: () {
                                          Navigator.pop(context, true);
                                        },
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.green),
                                        child: SizedBox(
                                          width: 60,
                                          child: Text(
                                            "Yes",
                                            textAlign: TextAlign.center,
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          Navigator.pop(context, false);
                                        },
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.red),
                                        child: SizedBox(
                                          width: 60,
                                          child: Text(
                                            "no",
                                            textAlign: TextAlign.center,
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              });
                          if (result) {
                            deletedata(index);
                          }
                        },
                        icon: Icon(
                          Icons.delete,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ]),
          )),
    );
  }
}
