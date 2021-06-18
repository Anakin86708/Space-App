import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:space_app/model/userData.dart';

class FavoriteDatabase {
  static UserData user;
  static FavoriteDatabase helper = FavoriteDatabase._createInstance();
  static List<int> favoritesIDs = [];

  FavoriteDatabase._createInstance();

  final CollectionReference favoritesCollection =
      FirebaseFirestore.instance.collection('favorites');

  Future<List<int>> getFavorites() async {
    DocumentSnapshot snapshot = await favoritesCollection.doc(user.uid).get();
    try {
      if (snapshot.data() == null) {
        throw Exception();
      }
      favoritesIDs.addAll((snapshot.data() as Map)['index'].whereType<int>());
    } on Exception catch (_) {
      print('Empty favorites');
    }
    return favoritesIDs;
  }

  insertFavorite(int indexToInsert) async {
    List currentList = await getFavorites()
      ..add(indexToInsert);
    await favoritesCollection.doc(user.uid).set({'index': currentList});
  }

  removeFavorite(int indexToRemove) async {
    List currentList = await getFavorites()
      ..remove(indexToRemove);
    await favoritesCollection.doc(user.uid)
        .set({'index': currentList});
  }
}
