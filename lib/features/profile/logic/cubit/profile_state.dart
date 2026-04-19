sealed class ProfileState {}

class Initial extends ProfileState {}

class Loading extends ProfileState {}

class Success extends ProfileState {
  final String message;
  Success(this.message);
}

class Failure extends ProfileState {
  final String error;
  Failure(this.error);
}
