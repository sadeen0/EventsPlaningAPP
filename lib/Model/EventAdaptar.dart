import 'package:hive_flutter/hive_flutter.dart';
import 'package:localization/Model/EventModel.dart';

class EventAdapter extends TypeAdapter<EventModel> { 
  
   @override
  // 0 - 233
  int get typeId => 0;

  @override
  EventModel read(BinaryReader reader) {
    return EventModel(
      Id: reader.readString(), 
      Title: reader.readString(),
      Date: reader.readString(),
      );
  }


  @override
  void write(BinaryWriter writer, EventModel obj) {
    // TODO: implement write
    writer.writeString(obj.Id);
    writer.writeString(obj.Title);
    writer.writeString(obj.Date);
  }
}