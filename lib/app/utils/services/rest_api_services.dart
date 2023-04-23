import 'package:daily_task/app/constants/app_constants.dart';
import 'package:daily_task/app/features/model/HomeModel.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:dio/src/response.dart' as DioResponse;

/// contains all service to get data from Server
class RestApiServices {
  final Dio _dio = Get.find<Dio>();

  final headers = {
    "Content-Type": "application/json",
    "Authorization": "Bearer eyJraWQiOiJhMDFmNzFjZi05NmVhLTRjMWEtYThjYy0xYjA1YTQ5MjIyNjIiLCJhbGciOiJSUzI1NiJ9.eyJzdWIiOiJ0ZXN0ZXJhYjQwNEBnbWFpbC5jb20iLCJhdWQiOiJuY2hsLWNsaWVudCIsIm5iZiI6MTY4MTgyMDYyMiwic2NvcGUiOlsibmNobC1yZWFkLXdyaXRlIl0sImlzcyI6Imh0dHA6Ly8xMjcuMC4wLjE6ODA4MCIsImV4cCI6MTY4MTg1NjYyMiwiaWF0IjoxNjgxODIwNjIyfQ.VZ_Xx1nru-Jh_LOx6brPSCxngh8xQQsqbC6zNRWG1q1NwrqkkJXPL404d4KCiXe5CyxJDVdv7AHk0B8yso050ZBvkulqlmw-3kYbITW_WntHFYlb32h-3fcpu1wuhTdZM9O-ocWDfMMtX-sc0Wh27Dejtz3yZ5mYjCCSUj9K4Dnzwxq3duib7Gi7UljqQk7_KWFz7K4jpwAjC4xUD593vXf_BkVdng6vNpvK6Ldcr9Vo4ZxRCoYh3EafWKX6ttzSAQZivfzEySoI6GMR5Gq_F1DbQecQb4uhoBidUz0KGgIMKQXut9Lp-tH0hPhIdQ-sgavEj-0XbjutYxSOH87BjQ"
  };

  Future getHomeData()async{
    try {
      DioResponse.Response response = await _dio.get(ApiConstants.getHomeData);
      logger.d(response.statusCode!);
      logger.d(response.extra!);
      logger.d(response.requestOptions!);

    } on DioError catch (e) {
      // if(e.response != null) {
      //   logger.e(e.response!.data);
      // } else {
      //   logger.e(e.requestOptions);
      //   logger.e(e.message);
      // }
    }
  }
}
