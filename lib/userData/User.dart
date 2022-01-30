class User {
  final String name;
  final String image;
  final int tasks;
  final bool isTeacher;

  User(this.name, this.tasks, this.image, this.isTeacher);

  User.fromJson(Map<dynamic, dynamic> json)
      : name = json['userName'] as String,
        tasks = json["tasksDone"] as int,
        image = json["image"] as String,
        isTeacher = json["isTeacher"] as bool;

  Map<dynamic, dynamic> toJson() => <dynamic, dynamic>{
    'name': name,
    'tasks': tasks,
    'image': image,
    'isTeacher': isTeacher,
  };
}