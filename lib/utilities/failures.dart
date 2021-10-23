abstract class Failure {}

class ServerFailure implements Failure {
  final String? error;
  ServerFailure({required this.error});

  @override
  String toString() {
    return error!;
  }
}

class InputFailure implements Failure {
  final String? errorMessage;
  InputFailure({required this.errorMessage});

  @override
  String toString() {
    return errorMessage!;
  }
}

class BadAuthFailure implements Failure {
  final String? errorMessage;
  BadAuthFailure({this.errorMessage});

  @override
  String toString() {
    return errorMessage!;
  }
}

class NetworkFailure implements Failure {}

class UnknownFailure implements Failure {
  final String? errorMessage;
  UnknownFailure({this.errorMessage});

  @override
  String toString() {
    return errorMessage!;
  }
}
