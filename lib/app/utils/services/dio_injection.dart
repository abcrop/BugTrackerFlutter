import 'package:daily_task/app/constants/app_constants.dart';
import 'package:daily_task/app/utils/services/rest_api_services.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class DioInitInjection {
  static Future<bool> init() async {
    var interceptors = InterceptorsWrapper(
      onRequest: (options, handler) {
        logger.d("Before BugTracker HTTP request was send");
        //we can intercept and reject of resolve request
        return handler.next(options);
      },
        onResponse: (response, handler) {
          logger.i("BugTracker HTTP response was received");
          //we can intercept and reject of resolve request
          return handler.next(response);
        },
      onError: (DioError e, handler) {
        logger.e("BugTracker HTTP Error Occurred");
        if(e.response != null) {
          logger.e(e.response!.data);
        } else {
          // logger.e(e.requestOptions!.data);
          logger.e(e.message);
        }

        //handler.resolve(customResponse) we can send custom error message
        return handler.next(e);
      }
    );

    var options = BaseOptions(
      baseUrl: ApiConstants.baseURL,
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 3),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer eyJraWQiOiJhMDFmNzFjZi05NmVhLTRjMWEtYThjYy0xYjA1YTQ5MjIyNjIiLCJhbGciOiJSUzI1NiJ9.eyJzdWIiOiJ0ZXN0ZXJhYjQwNEBnbWFpbC5jb20iLCJhdWQiOiJuY2hsLWNsaWVudCIsIm5iZiI6MTY4MTgyMDYyMiwic2NvcGUiOlsibmNobC1yZWFkLXdyaXRlIl0sImlzcyI6Imh0dHA6Ly8xMjcuMC4wLjE6ODA4MCIsImV4cCI6MTY4MTg1NjYyMiwiaWF0IjoxNjgxODIwNjIyfQ.VZ_Xx1nru-Jh_LOx6brPSCxngh8xQQsqbC6zNRWG1q1NwrqkkJXPL404d4KCiXe5CyxJDVdv7AHk0B8yso050ZBvkulqlmw-3kYbITW_WntHFYlb32h-3fcpu1wuhTdZM9O-ocWDfMMtX-sc0Wh27Dejtz3yZ5mYjCCSUj9K4Dnzwxq3duib7Gi7UljqQk7_KWFz7K4jpwAjC4xUD593vXf_BkVdng6vNpvK6Ldcr9Vo4ZxRCoYh3EafWKX6ttzSAQZivfzEySoI6GMR5Gq_F1DbQecQb4uhoBidUz0KGgIMKQXut9Lp-tH0hPhIdQ-sgavEj-0XbjutYxSOH87BjQ"
      },
      method: "cors",
    );

    var dio = Dio(options);
    dio.interceptors.add(interceptors);

    //Initializing getconnect
    Get.put<Dio>(dio);

    //Initializing Rest Api
    Get.put<RestApiServices>(RestApiServices());

    return Future.value(true);
  }
}
