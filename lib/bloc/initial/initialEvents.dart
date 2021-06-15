abstract class InitialEvents {}

class RequestListData extends InitialEvents {}

class RequestListFavorite extends InitialEvents {
  final List<int> favoritesIDs;

  RequestListFavorite(this.favoritesIDs);
}
