class LoginScreenState {
  bool isLoading;
  LoginScreenState({this.isLoading = false});

  LoginScreenState copyWith({bool? isLoading}) {
    return LoginScreenState(isLoading: isLoading ?? this.isLoading);
  }
}
