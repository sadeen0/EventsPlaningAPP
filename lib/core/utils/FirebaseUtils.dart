import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:localization/Model/EventModel.dart';
import 'package:localization/Model/UserModel.dart';

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

  static Future<void> updateEventInFirestore(EventModel event) async {
    var collectionRef = getEventCollection();
    await collectionRef.doc(event.id).update(event.ToFirestore());
  }

  static Future<void> DeleteEventFromFirestore(EventModel event) async {
    var collectionRef = getEventCollection();
    await collectionRef.doc(event.id).delete();
  }

  static CollectionReference <UserModel> getUserCollection(){
    return FirebaseFirestore.instance.collection(UserModel.collectionName)
    .withConverter<UserModel>(
      fromFirestore: (snapshot, options) => UserModel.fromFirestore(snapshot.data()!, snapshot.id),
      toFirestore: (user, options) => user.toFirestore(),
    );
  }

  static Future<void> addUserToFirestore(UserModel user) {
    var collectionRef = getUserCollection();
    var uid = FirebaseAuth.instance.currentUser!.uid;
    user.id = uid; // set user ID

    return collectionRef.doc(uid).set(user);
  }

  static Future<UserModel?> getUserFromFirestore(String uid) async {
    var collectionRef = getUserCollection();
    var docSnapshot = await collectionRef.doc(uid).get();
    return docSnapshot.data();
  }
}
