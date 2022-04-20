import 'package:mushroom_finder/model/classification_result.dart';
import 'package:mushroom_finder/model/result_query.dart';

class QueryResponse {
  List<ResultQuery> resultQuery = [];
  ClassificationResult classificationResult;
  double query_time;

  QueryResponse(data) {
    for (var item in data['data']) {
      this.resultQuery.add(ResultQuery(item));
    }
    this.classificationResult =
        ClassificationResult(data['classification_result']);
    this.query_time = data['query_time'];
  }
}
