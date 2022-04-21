import 'package:mushroom_finder/repository/constants.dart';

class ResultQuery {
  String file_name;
  String file_class;
  double distance;

  ResultQuery(data) {
    this.file_class = data['file_class'];
    this.file_name = (host +
        (data['file_name'] as String).split("Dataset/")[1]);
    this.distance = (double.parse(data['distance']));
  }
}
