class Task {
  final String text;
  final String state;

  Task(this.text, this.state);

  Task.fromJson(Map<dynamic, dynamic> json)
        : text = json['title'] as String,
        state = json['state'] as String;

  Map<dynamic, dynamic> toJson() => <dynamic, dynamic>{
        'text': text,
        'state': state,
      };
}
