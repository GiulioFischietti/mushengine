import 'package:mushroom_finder/model/result_query.dart';

class QueryResponse {
  List<ResultQuery> resultQuery = [];
  double query_time;

  QueryResponse(data) {
    for (var item in data['data']) {
      this.resultQuery.add(ResultQuery(item));
    }
    this.query_time = data['query_time'];
  }
}
