import 'package:space_app/api/apiProvider.dart';

void main() async {
  print( await APIProvider.helper.getAllEvents());
}
