class Task {
  final String text;

  Task(this.text);

  Task.fromJson(Map<dynamic, dynamic> json)
        : text = json['title'] as String;

  Map<dynamic, dynamic> toJson() => <dynamic, dynamic>{
        'text': text,
      };
}
