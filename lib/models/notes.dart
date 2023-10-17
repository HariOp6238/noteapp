class Notes {
  int id;
  String title;
  String content;
  DateTime Modifiedtime;

  Notes({
    required this.id,
    required this.Modifiedtime,
    required this.content,
    required this.title,
  });
}

List<Notes> Samplenotes = [
  Notes(
      id: 1,
      Modifiedtime: DateTime(2000),
      content: "welcome to notepad",
      title: "my notepad"),
  Notes(
      id: 1,
      Modifiedtime: DateTime(2000),
      content: '''hai da kuttah
      ninnuk sugam anno
      njan vitil pokuva
      ''',
      title: "sugam anno"),
];
