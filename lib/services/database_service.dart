import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:story/models/user_model.dart';

/*class DatabaseService{
  static Future<User> getUserWithId(String userId) async {
    DocumentSnapshot userDocSnapshot = await usersRef.document(userId).get();
    if (userDocSnapshot.exists) {
      return User.fromDoc(userDocSnapshot);
    }
    return User();
  }
}*/
class DatabaseService {}
