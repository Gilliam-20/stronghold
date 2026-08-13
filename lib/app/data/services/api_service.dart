import 'package:dio/dio.dart';
import 'package:get/get.dart';

/// App-wide Dio client, exposed as a [GetxService] so it survives for the
/// lifetime of the app and is available to every repository via
/// `Get.find<ApiService>()`.
///
/// The site's content (programs, trainers, pricing, testimonials) ships
/// with the app as static data — a marketing page for a single gym has no
/// real need for a backend for that part. Dio is wired in for the one
/// interaction that genuinely is a network call: submitting the contact /
/// enquiry form. Point [baseUrl] at a real endpoint (e.g. a Cloud Function
/// or a form-relay service) when one exists.
class ApiService extends GetxService {
  late final Dio dio;

  static const String baseUrl = 'https://api.stronghold.example.com';

  Future<ApiService> init() async {
    dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        headers: {'Content-Type': 'application/json'},
      ),
    );

    dio.interceptors.add(
      InterceptorsWrapper(
        onError: (error, handler) {
          // Centralised place to log / report network failures.
          handler.next(error);
        },
      ),
    );

    return this;
  }
}
