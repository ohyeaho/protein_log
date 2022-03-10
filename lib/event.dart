class Event {
  String title;

  Event(this.title);

  dynamic toJson() => title;

  String toString() => title;

  Event.fromJson(Map<String, dynamic> json) : title = json['title'];
}
