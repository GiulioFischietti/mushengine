import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:mushroom_finder/model/query_response.dart';
import 'package:mushroom_finder/model/result_query.dart';
import 'package:mushroom_finder/repository/constants.dart';

Future<QueryResponse> uploadImage(File file) async {
  String fileName = file != null ? file.path.split('/').last : "";
  FormData formData = FormData.fromMap({
    "file": file != null
        ? await MultipartFile.fromFile(file.path, filename: fileName)
        : null,
  });
  Response<Map> response = await Dio().post(
    host,
    data: formData,
  );
  QueryResponse _results = QueryResponse(response.data);

  return _results;
  // print(response.data);
}
