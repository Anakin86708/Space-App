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
      // favoritesIDs = [];
      favoritesIDs.addAll((snapshot.data() as Map)['index'].whereType<int>());
    } on Exception catch (_) {
      print('Empty favorites');
    }
    return favoritesIDs;
  }

  insertFavorite(int indexToInsert) async {
    favoritesIDs = await getFavorites()..add(indexToInsert);
    favoritesIDs = Set.from(favoritesIDs).toList().cast<int>();
    await favoritesCollection.doc(user.uid).set({'index': favoritesIDs});
  }

  removeFavorite(int indexToRemove) async {
    favoritesIDs = await getFavorites();
    favoritesIDs = Set.from(favoritesIDs).toList().cast<int>();
    favoritesIDs.remove(indexToRemove);
    await favoritesCollection.doc(user.uid).set({'index': favoritesIDs});
  }
}
