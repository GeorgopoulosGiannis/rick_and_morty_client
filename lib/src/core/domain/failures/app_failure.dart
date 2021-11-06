import 'package:rick_and_morty_client/src/core/domain/failures/failure.dart';

class ApplicationFailure extends Failure {
  ApplicationFailure(String message) : super(message: message, code: 0);
}
