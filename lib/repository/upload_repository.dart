import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:mushroom_finder/model/query_response.dart';
import 'package:mushroom_finder/model/result_query.dart';

Future<QueryResponse> uploadImage(File file) async {
  String fileName = file != null ? file.path.split('/').last : "";
  FormData formData = FormData.fromMap({
    "file": file != null
        ? await MultipartFile.fromFile(file.path, filename: fileName)
        : null,
  });
  Response<Map> response = await Dio().post(
    "http://2341-35-231-196-150.ngrok.io/uploadimage",
    data: formData,
  );
  QueryResponse _results = QueryResponse(response.data);

  return _results;
  // print(response.data);
}
