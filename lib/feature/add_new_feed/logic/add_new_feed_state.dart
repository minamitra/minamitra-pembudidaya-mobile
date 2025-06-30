part of 'add_new_feed_cubit.dart';

class AddNewFeedState extends Equatable {
  const AddNewFeedState({
    this.status = GlobalState.initial,
    this.errorMessage = '',
    this.unitList = const [],
    this.supplierList = const [],
  });

  final GlobalState status;
  final String errorMessage;
  final List<UnitResponseData> unitList;
  final List<SuplierResponseData> supplierList;

  AddNewFeedState copyWith({
    GlobalState? status,
    String? errorMessage,
    List<UnitResponseData>? unitList,
    List<SuplierResponseData>? supplierList,
  }) {
    return AddNewFeedState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      unitList: unitList ?? this.unitList,
      supplierList: supplierList ?? this.supplierList,
    );
  }

  @override
  List<Object> get props => [
        status,
        errorMessage,
        unitList,
        supplierList,
      ];
}
