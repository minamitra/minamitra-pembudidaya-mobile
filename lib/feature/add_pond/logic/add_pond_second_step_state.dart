part of 'add_pond_second_step_cubit.dart';

class AddPondSecondStepState extends Equatable {
  const AddPondSecondStepState({
    this.status = GlobalState.initial,
    this.errorMessage = '',
    this.provinceData,
    this.districtData,
    this.subDistrictData,
    this.villageData,
    this.selectedProvince,
    this.selectedDistrict,
    this.selectedSubDistrict,
    this.selectedVillage,
    this.latitude = "",
    this.longitude = "",
    this.snapshotMap,
    this.urlImage = "",
  });

  final GlobalState status;
  final String errorMessage;
  final ProvinceResponse? provinceData;
  final DistrictResponse? districtData;
  final SubDistrictResponse? subDistrictData;
  final VillageResponse? villageData;
  final ProvinceResponseData? selectedProvince;
  final DistrictResponseData? selectedDistrict;
  final SubDistrictResponseData? selectedSubDistrict;
  final VillageResponseData? selectedVillage;
  final String? latitude;
  final String? longitude;
  final Uint8List? snapshotMap;
  final String urlImage;

  AddPondSecondStepState copyWith({
    GlobalState? status,
    String? errorMessage,
    ProvinceResponse? provinceData,
    DistrictResponse? districtData,
    SubDistrictResponse? subDistrictData,
    VillageResponse? villageData,
    ProvinceResponseData? selectedProvince,
    DistrictResponseData? selectedDistrict,
    SubDistrictResponseData? selectedSubDistrict,
    VillageResponseData? selectedVillage,
    String? latitude,
    String? longitude,
    Uint8List? snapshotMap,
    String? urlImage,
  }) {
    return AddPondSecondStepState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      provinceData: provinceData,
      districtData: districtData,
      subDistrictData: subDistrictData,
      villageData: villageData,
      selectedProvince: selectedProvince,
      selectedDistrict: selectedDistrict,
      selectedSubDistrict: selectedSubDistrict,
      selectedVillage: selectedVillage,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      snapshotMap: snapshotMap ?? this.snapshotMap,
      urlImage: urlImage ?? this.urlImage,
    );
  }

  @override
  List<Object> get props => [
        status,
        errorMessage,
        provinceData ?? '',
        districtData ?? '',
        subDistrictData ?? '',
        villageData ?? '',
        selectedProvince ?? '',
        selectedDistrict ?? '',
        selectedSubDistrict ?? '',
        selectedVillage ?? '',
        latitude ?? '',
        longitude ?? '',
        snapshotMap ?? '',
        urlImage,
      ];
}
