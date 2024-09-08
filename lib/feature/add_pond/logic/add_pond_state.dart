part of 'add_pond_cubit.dart';

class AddPondState extends Equatable {
  const AddPondState({
    this.status = GlobalState.initial,
    this.errorMessage = '',
    this.index = 0,
    this.provinceData,
    this.districtData,
    this.subDistrictData,
    this.villageData,
    this.selectedProvince,
    this.selectedDistrict,
    this.selectedSubDistrict,
    this.selectedVillage,
  });

  final GlobalState status;
  final String errorMessage;
  final int index;
  final ProvinceResponse? provinceData;
  final DistrictResponse? districtData;
  final SubDistrictResponse? subDistrictData;
  final VillageResponse? villageData;
  final ProvinceResponseData? selectedProvince;
  final DistrictResponseData? selectedDistrict;
  final SubDistrictResponseData? selectedSubDistrict;
  final VillageResponseData? selectedVillage;

  AddPondState copyWith({
    GlobalState? status,
    String? errorMessage,
    int? index,
    ProvinceResponse? provinceData,
    DistrictResponse? districtData,
    SubDistrictResponse? subDistrictData,
    VillageResponse? villageData,
    ProvinceResponseData? selectedProvince,
    DistrictResponseData? selectedDistrict,
    SubDistrictResponseData? selectedSubDistrict,
    VillageResponseData? selectedVillage,
  }) {
    return AddPondState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      index: index ?? this.index,
      provinceData: provinceData,
      districtData: districtData,
      subDistrictData: subDistrictData,
      villageData: villageData,
      selectedProvince: selectedProvince,
      selectedDistrict: selectedDistrict,
      selectedSubDistrict: selectedSubDistrict,
      selectedVillage: selectedVillage,
    );
  }

  @override
  List<Object?> get props => [
        status,
        errorMessage,
        index,
        provinceData,
        districtData,
        subDistrictData,
        villageData,
        selectedProvince,
        selectedDistrict,
        selectedSubDistrict,
        selectedVillage,
      ];
}
