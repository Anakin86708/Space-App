import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:space_app/model/userData.dart';

class FavoriteDatabase {
  static UserData user;
  static FavoriteDatabase helper = FavoriteDatabase._createInstance();
  static List<int> favoritesIDs = [];
  static String _favoriteCollectionName = 'my_favorites';

  FavoriteDatabase._createInstance();

  final CollectionReference favoritesCollection =
      FirebaseFirestore.instance.collection('favorites');

  Future<List<int>> getFavorites() async {
    List<int> favorites = [];
    DocumentSnapshot snapshot = await favoritesCollection.doc(user.uid).get();
    // for (var doc in snapshot.data()) {
    //   List list = (doc.data() as Map)['index'];
    // }
    favorites.addAll((snapshot.data() as Map)['index'].whereType<int>());
    favoritesIDs = favorites;
    return favorites;
  }

  prepareUserFavorite() {
    try {
      favoritesCollection.doc(user.uid).set({'index':[]});
    } on Exception catch (e) {
      print('Cannot prepare user ${user.uid}');
    }
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
        // .collection(_favoriteCollectionName)
        // .doc('index')
        .set({'index': currentList});
  }
}
