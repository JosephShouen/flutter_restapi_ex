import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:flutter_restapi_ex/constants.dart';
import 'package:flutter_restapi_ex/photo_model.dart';

class ApiService {
  Future<List<Photo>?> getPhotos() async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.usersEndpoint);
      var response = await http.get(url);
      if (response.statusCode == 200) {
        List<Photo> _model = photoFromJson(response.body);
        return _model;
      }
    } catch (e) {
      log(e.toString());
    }
  }
}