import 'package:rick_and_morty_client/core/domain/failures/failure.dart';

class ServerFailure extends Failure {
  ServerFailure(String message, int code) : super(message: message, code: code);
}
