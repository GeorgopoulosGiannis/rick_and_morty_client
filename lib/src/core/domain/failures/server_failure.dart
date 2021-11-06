import 'failure.dart';

class ServerFailure extends Failure {
  ServerFailure(String message, int code) : super(message: message, code: code);
}
