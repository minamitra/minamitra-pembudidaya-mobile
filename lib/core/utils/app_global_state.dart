enum GlobalState {
  initial,
  loading,
  loaded,
  showDialogLoading,
  hideDialogLoading,
  error,
  refresh,
  successSubmit,
  onUpdating,
}

extension GlobalStateExtension on GlobalState {
  bool get isInitial => this == GlobalState.initial;
  bool get isLoading => this == GlobalState.loading;
  bool get isLoaded => this == GlobalState.loaded;
  bool get isShowDialogLoading => this == GlobalState.showDialogLoading;
  bool get isHideDialogLoading => this == GlobalState.hideDialogLoading;
  bool get isError => this == GlobalState.error;
  bool get isRefresh => this == GlobalState.refresh;
  bool get isSuccessSubmit => this == GlobalState.successSubmit;
  bool get isOnUpdating => this == GlobalState.onUpdating;
}
