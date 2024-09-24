import 'dart:io';
export 'dart:async';
export 'dart:convert';
export 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/foundation.dart';

import 'package:get/get.dart';

import '../../../constans/const_local_keys.dart';
import '../../../main.dart';
import 'log_interceptor.dart' as LogInterceptor;


const _defaultConnectTimeout = Duration.millisecondsPerMinute;
const _defaultReceiveTimeout = Duration.millisecondsPerMinute;

setContentType() {
  return "application/json";
}

class DioClient {
  String baseUrl;

  static late Dio _dio;
  static Dio get instance => _dio;

  final List<Interceptor>? interceptors;

  DioClient(
      this.baseUrl,
      Dio dio, {
        this.interceptors,
      }) {
    _dio = dio;
    _dio
      ..options.baseUrl = baseUrl
      ..options.connectTimeout = _defaultConnectTimeout.milliseconds
      ..options.receiveTimeout = _defaultReceiveTimeout.milliseconds
      ..httpClientAdapter
      ..options.contentType = setContentType()
      ..options.headers = {
        'Content-Type': setContentType(),
      };

    if (interceptors?.isNotEmpty ?? false) {
      _dio.interceptors.addAll(interceptors!);
    }
    if (kDebugMode) {
      _dio.interceptors.add(LogInterceptor.LogInterceptor(
          responseBody: true,
          error: true,
          requestHeader: true,
          responseHeader: false,
          request: false,
          requestBody: true));
    }
    /* if(kIsWeb){
      HttpClient client = HttpClient();
      client.badCertificateCallback =((X509Certificate cert, String  host, int port) => true);

       (_dio.httpClientAdapter as DefaultHttpClientAdapter).createHttpClient!()
        .badCertificateCallback = ((X509Certificate cert, String host, int port) {
          final isValidHost = ["192.168.1.67"].contains(host); // <-- allow only hosts in array
          return isValidHost;
        });
    } */

// Handling Bad SSL Certificates
    if (!kIsWeb) {
      (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (HttpClient client) {
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
        return client;
      };
    } /*(_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =

        (HttpClient dioClient ) {

      dioClient.badCertificateCallback =
      ((X509Certificate cert, String host, int port) => true);
      return dioClient;
    };*/
  }
// Https method get
  Future<dynamic> get(String uri,
      {data,
        Map<String, dynamic>? queryParameters,
        Options? options,
        CancelToken? cancelToken,
        ProgressCallback? onReceiveProgress,
        bool? skipAuth = false
      }) async {
    try {
      if (skipAuth == false) {
        var token = await storage.read(LOCALKEY_token);
        debugPrint("token ${token}");
        if (token != null) {
          options = Options(headers: {"Authorization": "Bearer $token"});
        }
      } else {
        options = Options(headers: {
          "Content-Type": "application/json",
        });
      }
      print(" i am here, well i am rocked...");
      var response = await _dio.get(
        uri,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return response.data;
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    } on FormatException catch (_) {
      throw FormatException("Unable to process the data");
    } catch (e) {
      throw e;
    }
  }

// fpdart? POST Method
  Future<dynamic> post(String uri,
      {data,
        Map<String, dynamic>? queryParameters,
        Options? options,
        CancelToken? cancelToken,
        ProgressCallback? onSendProgress,
        ProgressCallback? onReceiveProgress,
        bool? skipAuth}) async {
    try {
      if (skipAuth == false) {
        var token = await storage.read(LOCALKEY_token);
        // var token = await storage.read(RefreshToken);
        debugPrint("authorization============ $token");
        print("hellp i am rock");

        if (token != null) {
          if (options == null) {
            options = Options(headers: {"Authorization": "Bearer $token"});
          }
        }
      }

      var response = await _dio.post(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      print(response);
      return response.data;
    } on FormatException catch (_) {
      throw const FormatException("Unable to process the data");
    } catch (e) {
      throw e;
    }
  }
//   Future<dynamic> post(String uri,
//     {data,
//     Map<String, dynamic>? queryParameters,
//     Options? options,
//     CancelToken? cancelToken,
//     ProgressCallback? onSendProgress,
//     ProgressCallback? onReceiveProgress,
//     bool? skipAuth}) async {
//   try {
//     if (skipAuth == false) {
//       var token = await storage.read(LOCALKEY_token);
//       debugPrint("authorization============ $token");
//       print("hello i am rock");

//       if (token != null) {
//         if (options == null) {
//           options = Options(headers: {"Authorization": "Bearer $token"});
//         }
//       }
//     }

//     var response = await _dio.post(
//       uri,
//       data: data,
//       queryParameters: queryParameters,
//       options: options,
//       cancelToken: cancelToken,
//       onSendProgress: onSendProgress,
//       onReceiveProgress: onReceiveProgress,
//     );

//     return response.data;
//   } on DioError catch (e) {
//     if (e.response?.statusCode == 401) {
//       // Unauthorized, attempt token refresh
//       var refreshToken = await storage.read(RefreshToken);
//       if (refreshToken != null) {
//         try {
//           // Call your token refresh API
//           var refreshedToken = await refreshTokenAPI(refreshToken);

//           // Update the token in storage
//           await storage.write(LOCALKEY_token, refreshedToken);

//           // Retry the original request with the new token
//           options?.headers?["Authorization"] = "Bearer $refreshedToken";
//           var retryResponse = await _dio.post(
//             uri,
//             data: data,
//             queryParameters: queryParameters,
//             options: options,
//             cancelToken: cancelToken,
//             onSendProgress: onSendProgress,
//             onReceiveProgress: onReceiveProgress,
//           );

//           return retryResponse.data;
//         } catch (refreshError) {
//           // Token refresh failed, handle logout or other actions
//           await logoutApiCall(); // Implement logout method
//           throw refreshError;
//         }
//       } else {
//         // No refresh token found, handle logout or other actions
//         await logoutApiCall(); // Implement logout method
//       }
//     }
//     // For other Dio errors, rethrow
//     throw e;
//   } on FormatException catch (_) {
//     throw const FormatException("Unable to process the data");
//   } catch (e) {
//     throw e;
//   }
// }

// Future<String> refreshTokenAPI(String refreshToken) async {
//   // Implement your token refresh logic here
//   // Call your refresh token API with the provided refreshToken
//   // Return the refreshed access token
// }

// put method
  Future<dynamic> put(String uri,
      {data,
        Map<String, dynamic>? queryParameters,
        Options? options,
        CancelToken? cancelToken,
        ProgressCallback? onSendProgress,
        ProgressCallback? onReceiveProgress,
        bool? skipAuth}) async {
    try {
      if (skipAuth == false) {
        var token = await storage.read(LOCALKEY_token);
        debugPrint("authorization============ $token");

        if (token != null) {
          if (options == null) {
            options = Options(headers: {"Authorization": "Bearer $token"});
          }
        }
      }
      var response = await _dio.put(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response.data;
    } on FormatException catch (_) {
      throw FormatException("Unable to process the data");
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> delete(String uri,
      {data,
        Map<String, dynamic>? queryParameters,
        Options? options,
        CancelToken? cancelToken,
        ProgressCallback? onSendProgress,
        ProgressCallback? onReceiveProgress,
        bool? skipAuth}) async {
    try {
      // if skipauth is false its automatically handle the auth token or options value no need to reinitialize it.ok

      if (skipAuth == false) {
        var token = await storage.read(LOCALKEY_token);
        debugPrint("authorization============ $token");

        if (token != null) {
          if (options == null) {
            options = Options(headers: {"Authorization": "Bearer $token"});
          }
        }
      }
      var response = await _dio.delete(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        // onSendProgress: onSendProgress,
        // onReceiveProgress: onReceiveProgress,
      );
      return response.data;
    } on FormatException catch (_) {
      throw FormatException("Unable to process the data");
    } catch (e) {
      throw e;
    }
  }

  // patch method
  Future<dynamic> patch(String uri,
      {data,
        Map<String, dynamic>? queryParameters,
        Options? options,
        CancelToken? cancelToken,
        ProgressCallback? onSendProgress,
        ProgressCallback? onReceiveProgress,
        bool? skipAuth}) async {
    try {
      if (skipAuth == false) {
        var token = await storage.read(LOCALKEY_token);
        debugPrint("authorization============ $token");

        if (token != null) {
          if (options == null) {
            options = Options(headers: {"Authorization": "Bearer $token"});
          }
        }
      }
      var response = await _dio.patch(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response.data;
    } on FormatException catch (_) {
      throw FormatException("Unable to process the data");
    } catch (e) {
      throw e;
    }
  }


}
