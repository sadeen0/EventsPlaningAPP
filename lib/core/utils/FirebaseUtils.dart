import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:localization/Model/EventModel.dart';

class FirebaseUtils {

  static CollectionReference <EventModel> getEventCollection(){
    return FirebaseFirestore.instance.collection(EventModel.collectionName)
    .withConverter<EventModel>(
      fromFirestore: (snapshot, options) => EventModel.fromFirestore(snapshot.data()!),
      toFirestore: (event, options) => event.ToFirestore(),
    );
  }

  static Future<void> addEventToFirestore(EventModel event) {
    var collectionRef = getEventCollection();
    var docRef = collectionRef.doc(); 
    event.id = docRef.id; // create document with auto ID
    
   return docRef.set(event); 
  }

  static Future<void> updateFavorite(String id, bool isFavorite) async {
    var collectionRef = getEventCollection();
    await collectionRef.doc(id).update({
      'isFavorite': isFavorite,
    });
  }

  static Query<EventModel> getFavoriteEvents() {
  return getEventCollection().where("isFavorite", isEqualTo: true);
}


}
