class Todo {
  int? id;
  final String item;

  Todo({this.id, required this.item});

  Map<String, dynamic> toMap() {
    return {
      "item": this.item,
    };
  }
}
