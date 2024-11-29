import 'package:employee_management/src/core/rest_client/rest_client.dart';
import 'package:http/http.dart' as http;

// coverage:ignore-start
/// Checks the [http.ClientException] and tries to parse it.
Object? checkHttpException(http.ClientException e) {
  if (e.message.contains('XMLHttpRequest error')) {
    return ConnectionException(message: e.message, cause: e);
  }

  return null;
}
// coverage:ignore-end
