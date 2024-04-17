import 'package:chat_app/core/components/domain/entity/error_data.dart';

class ErrorResponse {
  final String message;

  ErrorResponse(this.message);

  ErrorData toEntity() => ErrorData(message: message);
}
