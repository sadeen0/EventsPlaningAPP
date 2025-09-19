class EventModel {
  static const String collectionName = 'events';

  String id;
  String title;
  String description;
  DateTime dateTime;
  String time;
  //String location;
  bool isFavorite;
  String eventName;

EventModel({
  this.id = '',
  required this.title,
  required this.description,
  required this.dateTime,
  required this.time,
  //required this.location,
  this.isFavorite = false,
  required this.eventName,
});

// object to json(map)
  Map<String, dynamic> ToFirestore() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'dateTime': dateTime.millisecondsSinceEpoch,
      'time': time,
      //'location': location,
      'isFavorite': isFavorite,
      'eventName': eventName,
    };
  }
// From json to object
  EventModel.fromFirestore(Map<String, dynamic> data)
      : this (
        id: data['id'],
        title: data['title'],
        description: data['description'],
        dateTime: DateTime.fromMillisecondsSinceEpoch(data['dateTime']),
        time: data['time'],
        //location: data['location'],
        isFavorite: data['isFavorite'],
        eventName: data['eventName'],
      );

}