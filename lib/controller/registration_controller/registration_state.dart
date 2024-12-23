class RegistrationScreenState {
  bool isLoading;
  RegistrationScreenState({this.isLoading = false});
  RegistrationScreenState copyWith({bool? isLoading}) {
    return RegistrationScreenState(isLoading: isLoading ?? this.isLoading);
  }
}
