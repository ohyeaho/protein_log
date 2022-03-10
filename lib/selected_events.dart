import 'event.dart';

class SelectedEvents {
  DateTime dateTime;
  List<Event> event;

  SelectedEvents(this.dateTime, this.event);

  SelectedEvents.fromJson(Map<String, dynamic> json)
      : dateTime = DateTime.parse(json['dateTime']),
        event = List<Event>.from(json['event'].map((e) => Event.fromJson(e)));

  Map<String, dynamic> toJson() => {
        'dateTime': dateTime.toIso8601String(),
        'event': event,
      };

  // SelectedEvents.fromJson(Map<DateTime, dynamic> json)
  //     : dateTime = json['dateTime'],
  //       event = json['event'];
  //
  // Map<String, dynamic> toJson() => {
  //       'dateTime': dateTime,
  //       'event': event,
  //     };
}
