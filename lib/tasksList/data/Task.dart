class Task {
  final String date;
  final String description;
  final String image;
  final String state;
  final String location;
  final String owner;
  final String title;
  final int upvotes;

  Task(this.date, this.description, this.image, this.state, this.location, this.owner, this.title, this.upvotes);

  Task.fromJson(Map<dynamic, dynamic> json)
        : date = json['date'] as String,
        description = json['description'] as String,
        image = json['image'] as String,
        state = json['state'] as String,
        location = json['localization'] as String,
        owner = json['owner'] as String,
        title = json['title'] as String,
        upvotes = json['upvotes'] as int;

  Map<dynamic, dynamic> toJson() => <dynamic, dynamic>{
        'date': date,
        'description': description,
        'image': image,
        'state': state,
        'localization': location,
        'owner': owner,
        'title': title,
        'upvotes': upvotes,
      };

  @override
  String toString(){
    return "Title: " + title + " description: " + description + " date: " + date + " image: " + image + " location: " + location + " owner: " + owner + " state: " + state;
  }
}
