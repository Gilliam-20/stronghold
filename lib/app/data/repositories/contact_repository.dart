import 'package:dio/dio.dart';
import '../models/contact_form_model.dart';
import '../services/api_service.dart';

/// Handles the one real network call on the site: submitting the enquiry
/// form from the Contact section. Wraps [ApiService]'s Dio client so the
/// controller never talks to Dio directly.
class ContactRepository {
  ContactRepository(this._api);

  final ApiService _api;

  Future<bool> submitEnquiry(ContactFormModel form) async {
    try {
      final response = await _api.dio.post(
        '/enquiries',
        data: form.toJson(),
      );
      return response.statusCode != null &&
          response.statusCode! >= 200 &&
          response.statusCode! < 300;
    } on DioException {
      // No live backend is wired up behind ApiService.baseUrl yet, so this
      // will fail in this demo build — the controller falls back to a
      // local "message received" state rather than surfacing a raw error.
      // Point ApiService.baseUrl at a real endpoint to go live.
      rethrow;
    }
  }
}
