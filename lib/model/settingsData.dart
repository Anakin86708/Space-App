class SettingsData {
  static const availableUpdatesFrequency = [
    '30 min',
    '1h',
    '2h',
    '6h',
    '12h',
    '1d'
  ];
  bool _eventNotificationsState = false;
  bool onlyFavoriteState = false;
  String updateFrequencyValue = SettingsData.availableUpdatesFrequency[0];

  get eventNotificationsState => _eventNotificationsState;
  set eventNotificationsState(value) {
    if (value is int) {
      value = value == 1 ? true : false;
    }
    _eventNotificationsState = value;
    // Permite desligar o switch de favoritos junto ao de notificação
    if (!value) {
      onlyFavoriteState = value;
    }
  }

  @override
  String toString() {
    return "Settings model:\n\tNotification state: $eventNotificationsState\n\tOnly favorite state: $onlyFavoriteState\n\tFrequency update: $updateFrequencyValue\n";
  }
}
