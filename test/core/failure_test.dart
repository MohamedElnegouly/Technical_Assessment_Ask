import 'package:flutter_test/flutter_test.dart';
import 'package:technical_assessment_task/core/errors/failure.dart';

void main() {
  group('ServerError.fromResponse', () {
    test('extracts the message field for 400/401/403', () {
      final failure = ServerError.fromResponse(401, {'message': 'Invalid email or password'});
      expect(failure.errMessage, 'Invalid email or password');
    });

    test('returns a generic message for 404', () {
      final failure = ServerError.fromResponse(404, <String, dynamic>{});
      expect(failure.errMessage, 'Your request was not found, please try later!');
    });

    test('returns a generic message for 500', () {
      final failure = ServerError.fromResponse(500, <String, dynamic>{});
      expect(failure.errMessage, 'Internal server error, please try later!');
    });

    test('handles a non-map response body gracefully', () {
      final failure = ServerError.fromResponse(400, 'not a map');
      expect(failure.errMessage, isNotEmpty);
    });
  });
}
