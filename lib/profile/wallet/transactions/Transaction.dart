class Transaction {
  final String date;
  final String owner;
  final String title;
  final int value;

  Transaction(this.date, this.owner, this.title, this.value);

  Transaction.fromJson(Map<dynamic, dynamic> json)
        : date = json['date'] as String,
        owner = json['owner'] as String,
        title = json['title'] as String,
        value = json['value'] as int;

  Map<dynamic, dynamic> toJson() => <dynamic, dynamic>{
        'date': date,
        'owner': owner,
        'title': title,
        'value': value,
      };
}
