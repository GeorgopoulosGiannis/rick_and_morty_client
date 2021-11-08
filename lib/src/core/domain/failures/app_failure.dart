import 'failure.dart';

class ApplicationFailure extends Failure {
  final StackTrace trace;
  ApplicationFailure(
    String message,
    this.trace,
  ) : super(
          message: message,
          code: 0,
        );
}
