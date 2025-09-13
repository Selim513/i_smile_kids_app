// import 'package:dio/dio.dart';

// class ApiServices {
//   final Dio dio;

//   ApiServices(this.dio) {
//     dio.options.baseUrl = "https://ismilekids-api.runasp.net/api";
//     dio.interceptors.add(
//       InterceptorsWrapper(
//         onRequest: (options, handler) {
//           // Add the API key to the header
//           options.headers['x-api-key'] =
//               '97b98665ea4d4672f793b70fed1c71fc23dff48e92fca2137254f9acb259c280';
//           return handler.next(options); // لازم ترجعها
//         },
//         onError: (DioException e, handler) {
//           // ممكن تتعامل مع الأخطاء هنا لو حابب
//           return handler.next(e);
//         },
//         onResponse: (response, handler) {
//           // هنا ممكن تعمل logging أو أي حاجة
//           return handler.next(response);
//         },
//       ),
//     );
//   }
//   Future<dynamic> get({required String endPoint}) async {
//     Response res = await dio.get(endPoint);
//     return res.data;
//   }

//   Future<dynamic> post({
//     required String endPoint,
//     required Object? data,
//   }) async {
//     Response res = await dio.post(endPoint, data: data);
//     return res.data;
//   }

//   Future<dynamic> delet({required String endPoint}) async {
//     Response res = await dio.delete(endPoint);
//     return res.data;
//   }
// }
import 'package:dio/dio.dart';

class ApiServices {
  final Dio _dio;

  ApiServices(this._dio) {
    _dio.options.baseUrl = "https://ismilekids-api.runasp.net/api";
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          options.headers['x-api-key'] =
              '97b98665ea4d4672f793b70fed1c71fc23dff48e92fca2137254f9acb259c280';
          return handler.next(options);
        },
        onError: (DioException e, handler) {
          return handler.next(e);
        },
        onResponse: (response, handler) {
          return handler.next(response);
        },
      ),
    );
  }

  /// Getter للـ Dio
  Dio get dio => _dio;

  Future<dynamic> get({required String endPoint}) async {
    Response res = await _dio.get(endPoint);
    return res.data;
  }

  Future<dynamic> post({
    required String endPoint,
    required Object? data,
  }) async {
    Response res = await _dio.post(endPoint, data: data);
    return res.data;
  }

  Future<dynamic> delet({required String endPoint}) async {
    Response res = await _dio.delete(endPoint);
    return res.data;
  }
}
