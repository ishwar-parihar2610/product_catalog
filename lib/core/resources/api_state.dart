enum ApiState { none, loading, done, error }

class AppDataState<T> {
  final ApiState apiState;
  final String? errorMessage;
  final T? data;

  const AppDataState({
    this.apiState = ApiState.none,
    this.errorMessage,
    this.data,
  });

  /// Useful for copying state with new values
  AppDataState<T> copyWith({
    ApiState? apiState,
    String? errorMessage,
    T? data,
  }) {
    return AppDataState<T>(
      apiState: apiState ?? this.apiState,
      errorMessage: errorMessage,
      data: data ?? this.data,
    );
  }
}
