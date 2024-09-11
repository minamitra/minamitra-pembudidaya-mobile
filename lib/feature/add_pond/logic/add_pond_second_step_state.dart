part of 'add_pond_second_step_cubit.dart';

class AddPondSecondStepState extends Equatable {
  const AddPondSecondStepState({
    this.status = GlobalState.initial,
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
  final ProvinceResponse? provinceData;
  final DistrictResponse? districtData;
  final SubDistrictResponse? subDistrictData;
  final VillageResponse? villageData;
  final ProvinceResponseData? selectedProvince;
  final DistrictResponseData? selectedDistrict;
  final SubDistrictResponseData? selectedSubDistrict;
  final VillageResponseData? selectedVillage;

  AddPondSecondStepState copyWith({
    GlobalState? status,
    ProvinceResponse? provinceData,
    DistrictResponse? districtData,
    SubDistrictResponse? subDistrictData,
    VillageResponse? villageData,
    ProvinceResponseData? selectedProvince,
    DistrictResponseData? selectedDistrict,
    SubDistrictResponseData? selectedSubDistrict,
    VillageResponseData? selectedVillage,
  }) {
    return AddPondSecondStepState(
      status: status ?? this.status,
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
  List<Object> get props => [
        provinceData ?? '',
        districtData ?? '',
        subDistrictData ?? '',
        villageData ?? '',
        selectedProvince ?? '',
        selectedDistrict ?? '',
        selectedSubDistrict ?? '',
        selectedVillage ?? '',
      ];
}
