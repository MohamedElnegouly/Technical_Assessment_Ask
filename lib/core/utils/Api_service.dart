import 'package:dio/dio.dart';
import 'package:technical_assessment_task/core/utils/apitoken.dart';

class ApiService {
  final Dio _dio;
  ApiService(this._dio);
  final String _baseUrl = Apitoken.baseUrl;
  Future<Map<String, dynamic>> get({
    required String endPoint,
    String? token,
  }) async {
    Map<String, dynamic> header = {};
    if (token != null) {
      header.addAll({'Authorization': 'Bearer $token'});
    }
    var response = await _dio.get(
      '$_baseUrl$endPoint',
      options: Options(headers: header),
    );
    return response.data;
  }

  Future<dynamic> post({
    required String endpoint, //رايح فين
    required String? token, //عنده صلاحيه ولا لا
    Map<String, dynamic>? body, //فين الداتا اللى هتبعتها
  }) async {
    Map<String, dynamic> header = {};
    if (token != null) {
      header.addAll({'Authorization': 'Bearer $token'});
    }
    var response = await _dio.post(
      '$_baseUrl$endpoint',
      options: Options(headers: header),
      data: body,
    );
    return response.data;
  }

  Future<dynamic> put(
  //بتشيل كله وتحط كله تانى
  {
    required String endpoint, //رايح فين
    required String? token, //عنده صلاحيه ولا لا
    Map<String, dynamic>? body, //فين الداتا اللى هتبعتها
  }) async {
    Map<String, dynamic> header = {};
    if (token != null) {
      header.addAll({'Authorization': 'Bearer $token'});
    }
    var response = await _dio.put(
      '$_baseUrl$endpoint',
      options: Options(headers: header),
      data: body,
    );
    return response.data;
  }

  Future<dynamic> patch(
  //بتحط الحاجه اللى انت عاوزها بس
  {
    required String endpoint, //رايح فين
    required String? token, //عنده صلاحيه ولا لا
    Map<String, dynamic>? body, //فين الداتا اللى هتبعتها
  }) async {
    Map<String, dynamic> header = {};
    if (token != null) {
      header.addAll({'Authorization': 'Bearer $token'});
    }
    var response = await _dio.patch(
      '$_baseUrl$endpoint',
      options: Options(headers: header),
      data: body,
    );
    return response.data;
  }

  Future<dynamic> delete({
  required String endpoint,
  required String? token,
}) async {
  Map<String, dynamic> header = {};
  if (token != null) {
    header.addAll({'Authorization': 'Bearer $token'});
  }

  var response = await _dio.delete(
    '$_baseUrl$endpoint',
    options: Options(headers: header),
  );

  return response.data;
}

}
