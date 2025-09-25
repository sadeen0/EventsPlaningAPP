class UserModel {
  static const String collectionName = 'users';
  
  String id;
  String name;
  String email;
  String image;
  

  UserModel({
    this.id = '',
    required this.name,
    required this.email,
    this.image = '',
  });
    
  // object to json(map)
  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'email': email,
      'image': image,
    };
  }

  // From json to object
  UserModel.fromFirestore(Map<String, dynamic> data, String documentId)
    : this(
        id: documentId,
        name: data['name'],
        email: data['email'],
        image: data['image'] ?? ''
        );
}
