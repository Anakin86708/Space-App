import 'package:space_app/database/apiDatabase.dart';

Future<void> main() async {
  var result = await APIDatabase.helper.getAllEvents();
  print(result);
}
