class User {
  final String name;
  final String image;
  final int tasks;

  User(this.name, this.tasks, this.image);

  User.fromJson(Map<dynamic, dynamic> json)
      : name = json['userName'] as String,
        tasks = json["tasksDone"] as int,
        image = json["image"] as String;

  Map<dynamic, dynamic> toJson() => <dynamic, dynamic>{
    'name': name,
    'tasks': tasks,
    'image': image,
  };
}