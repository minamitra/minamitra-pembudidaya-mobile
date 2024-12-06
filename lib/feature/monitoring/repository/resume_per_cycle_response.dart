import 'dart:convert';

class ResumePerCycleResponse {
  final List<ResumePerCycleResponseData>? data;
  final Pagination? pagination;

  ResumePerCycleResponse({
    this.data,
    this.pagination,
  });

  factory ResumePerCycleResponse.fromJson(String str) =>
      ResumePerCycleResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ResumePerCycleResponse.fromMap(Map<String, dynamic> json) =>
      ResumePerCycleResponse(
        data: json['data'] == null
            ? []
            : List<ResumePerCycleResponseData>.from(
                json['data']!.map((x) => ResumePerCycleResponseData.fromMap(x)),
              ),
        pagination: json['pagination'] == null
            ? null
            : Pagination.fromMap(json['pagination']),
      );

  Map<String, dynamic> toMap() => {
        'data':
            data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
        'pagination': pagination?.toMap(),
      };
}

class ResumePerCycleResponseData {
  final String? id;
  final String? memberId;
  final String? fishpondId;
  final String? fishpondcycleId;
  final String? status;
  final DateTime? tebarDate;
  final double? tebarBobot;
  final DateTime? periodeSiklusStart;
  final DateTime? periodeSiklusEnd;
  final String? memberAddress;
  final String? memberAddressLatitude;
  final String? memberAddressLongitude;
  final String? memberAddressProvinceId;
  final String? memberAddressProvinceName;
  final String? memberAddressCityId;
  final String? memberAddressCityName;
  final String? memberAddressSubdistrictId;
  final String? memberAddressSubdistrictName;
  final String? memberAddressVillageId;
  final String? memberAddressVillageName;
  final String? fishpondName;
  final double? fishpondAreaLength;
  final double? fishpondAreaWidth;
  final double? fishpondAreaTotal;
  final double? fishpondAreaDepth;
  final int? tebarFishTotal;
  final double? densitas;
  final String? fishseedId;
  final String? fishseedName;
  final String? fishseedVarietasId;
  final String? fishseedVarietasName;
  final String? fishseedHatcheryId;
  final String? fishseedHatcheryName;
  final double? totalBiomasa;
  final double? targetPanenBobot;
  final DateTime? estimationPanenDate;
  final DateTime? actualPanenDate;
  final double? estimationPanenTonase;
  final String? totalTonasePanen;
  final String? kriteriaHasilPanen;
  final String? nilaiSrKeseluruhan;
  final String? nilaiEppKeseluruhan;
  final String? nilaiFcrKeseluruhan;
  final String? pertumbuhanIkanKeseluruhan;
  final String? produktivitasKeseluruhan;
  final List<Pakan>? pakan;
  final DateTime? tanggalPanen;
  final double? totalPanen;
  final int? doc;
  final double? mbwAkhir;
  final double? jumlahIkanAkhir;
  final double? sr;
  final double? totalPakan;
  final double? epp;
  final double? fcr;
  final double? adg;
  final double? produktivitas;
  final double? totalPendapatan;
  final double? totalBiayaProduksi;

  ResumePerCycleResponseData({
    this.id,
    this.memberId,
    this.fishpondId,
    this.fishpondcycleId,
    this.status,
    this.tebarDate,
    this.tebarBobot,
    this.periodeSiklusStart,
    this.periodeSiklusEnd,
    this.memberAddress,
    this.memberAddressLatitude,
    this.memberAddressLongitude,
    this.memberAddressProvinceId,
    this.memberAddressProvinceName,
    this.memberAddressCityId,
    this.memberAddressCityName,
    this.memberAddressSubdistrictId,
    this.memberAddressSubdistrictName,
    this.memberAddressVillageId,
    this.memberAddressVillageName,
    this.fishpondName,
    this.fishpondAreaLength,
    this.fishpondAreaWidth,
    this.fishpondAreaTotal,
    this.fishpondAreaDepth,
    this.tebarFishTotal,
    this.densitas,
    this.fishseedId,
    this.fishseedName,
    this.fishseedVarietasId,
    this.fishseedVarietasName,
    this.fishseedHatcheryId,
    this.fishseedHatcheryName,
    this.totalBiomasa,
    this.targetPanenBobot,
    this.estimationPanenDate,
    this.actualPanenDate,
    this.estimationPanenTonase,
    this.totalTonasePanen,
    this.kriteriaHasilPanen,
    this.nilaiSrKeseluruhan,
    this.nilaiEppKeseluruhan,
    this.nilaiFcrKeseluruhan,
    this.pertumbuhanIkanKeseluruhan,
    this.produktivitasKeseluruhan,
    this.pakan,
    this.tanggalPanen,
    this.totalPanen,
    this.doc,
    this.mbwAkhir,
    this.jumlahIkanAkhir,
    this.sr,
    this.totalPakan,
    this.epp,
    this.fcr,
    this.adg,
    this.produktivitas,
    this.totalPendapatan,
    this.totalBiayaProduksi,
  });

  factory ResumePerCycleResponseData.fromJson(String str) =>
      ResumePerCycleResponseData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ResumePerCycleResponseData.fromMap(Map<String, dynamic> json) =>
      ResumePerCycleResponseData(
        id: json['id'],
        memberId: json['member_id'],
        fishpondId: json['fishpond_id'],
        fishpondcycleId: json['fishpondcycle_id'],
        status: json['status'],
        tebarDate: json['tebar_date'] == null
            ? null
            : DateTime.parse(json['tebar_date']),
        tebarBobot: json['tebar_bobot'].toDouble(),
        periodeSiklusStart: json['periode_siklus_start'] == null
            ? null
            : DateTime.parse(json['periode_siklus_start']),
        periodeSiklusEnd: json['periode_siklus_end'] == null
            ? null
            : DateTime.parse(json['periode_siklus_end']),
        memberAddress: json['member_address'],
        memberAddressLatitude: json['member_address_latitude'],
        memberAddressLongitude: json['member_address_longitude'],
        memberAddressProvinceId: json['member_address_province_id'],
        memberAddressProvinceName: json['member_address_province_name'],
        memberAddressCityId: json['member_address_city_id'],
        memberAddressCityName: json['member_address_city_name'],
        memberAddressSubdistrictId: json['member_address_subdistrict_id'],
        memberAddressSubdistrictName: json['member_address_subdistrict_name'],
        memberAddressVillageId: json['member_address_village_id'],
        memberAddressVillageName: json['member_address_village_name'],
        fishpondName: json['fishpond_name'],
        fishpondAreaLength: json['fishpond_area_length']?.toDouble(),
        fishpondAreaWidth: json['fishpond_area_width']?.toDouble(),
        fishpondAreaTotal: json['fishpond_area_total']?.toDouble(),
        fishpondAreaDepth: json['fishpond_area_depth']?.toDouble(),
        tebarFishTotal: json['tebar_fish_total'],
        densitas: json['densitas']?.toDouble(),
        fishseedId: json['fishseed_id'],
        fishseedName: json['fishseed_name'],
        fishseedVarietasId: json['fishseed_varietas_id'],
        fishseedVarietasName: json['fishseed_varietas_name'],
        fishseedHatcheryId: json['fishseed_hatchery_id'],
        fishseedHatcheryName: json['fishseed_hatchery_name'],
        totalBiomasa: json['total_biomasa'].toDouble(),
        targetPanenBobot: json['target_panen_bobot'].toDouble(),
        estimationPanenDate: json['estimation_panen_date'] == null
            ? null
            : DateTime.parse(json['estimation_panen_date']),
        actualPanenDate: json['actual_panen_date'] == null ||
                json['actual_panen_date'].isEmpty
            ? null
            : DateTime.parse(json['actual_panen_date']),
        estimationPanenTonase: json['estimation_panen_tonase'].toDouble(),
        totalTonasePanen: json['total_tonase_panen'],
        kriteriaHasilPanen: json['kriteria_hasil_panen'],
        nilaiSrKeseluruhan: json['nilai_sr_keseluruhan'],
        nilaiEppKeseluruhan: json['nilai_epp_keseluruhan'],
        nilaiFcrKeseluruhan: json['nilai_fcr_keseluruhan'],
        pertumbuhanIkanKeseluruhan: json['pertumbuhan_ikan_keseluruhan'],
        produktivitasKeseluruhan: json['produktivitas_keseluruhan'],
        pakan: json['pakan'] == null
            ? []
            : List<Pakan>.from(json['pakan']!.map((x) => Pakan.fromMap(x))),
        tanggalPanen:
            json['tanggal_panen'] == null || json['tanggal_panen'].isEmpty
                ? null
                : DateTime.parse(json['tanggal_panen']),
        totalPanen: json['total_panen'].toDouble(),
        doc: json['doc'],
        mbwAkhir: json['mbw_akhir']?.toDouble(),
        jumlahIkanAkhir: json['jumlah_ikan_akhir']?.toDouble(),
        sr: json['sr']?.toDouble(),
        totalPakan: json['total_pakan'].toDouble(),
        epp: json['epp'].toDouble(),
        fcr: json['fcr'].toDouble(),
        adg: json['adg']?.toDouble(),
        produktivitas: json['produktivitas']?.toDouble(),
        totalPendapatan: double.tryParse(
          json['total_pendapatan'].toString().isEmpty
              ? '0'
              : json['total_pendapatan'].toString(),
        ),
        totalBiayaProduksi: double.tryParse(
          json['total_biaya_produksi'].toString().isEmpty
              ? '0'
              : json['total_biaya_produksi'].toString(),
        ),
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'member_id': memberId,
        'fishpond_id': fishpondId,
        'fishpondcycle_id': fishpondcycleId,
        'status': status,
        'tebar_date':
            "${tebarDate!.year.toString().padLeft(4, '0')}-${tebarDate!.month.toString().padLeft(2, '0')}-${tebarDate!.day.toString().padLeft(2, '0')}",
        'tebar_bobot': tebarBobot,
        'periode_siklus_start':
            "${periodeSiklusStart!.year.toString().padLeft(4, '0')}-${periodeSiklusStart!.month.toString().padLeft(2, '0')}-${periodeSiklusStart!.day.toString().padLeft(2, '0')}",
        'periode_siklus_end':
            "${periodeSiklusEnd!.year.toString().padLeft(4, '0')}-${periodeSiklusEnd!.month.toString().padLeft(2, '0')}-${periodeSiklusEnd!.day.toString().padLeft(2, '0')}",
        'member_address': memberAddress,
        'member_address_latitude': memberAddressLatitude,
        'member_address_longitude': memberAddressLongitude,
        'member_address_province_id': memberAddressProvinceId,
        'member_address_province_name': memberAddressProvinceName,
        'member_address_city_id': memberAddressCityId,
        'member_address_city_name': memberAddressCityName,
        'member_address_subdistrict_id': memberAddressSubdistrictId,
        'member_address_subdistrict_name': memberAddressSubdistrictName,
        'member_address_village_id': memberAddressVillageId,
        'member_address_village_name': memberAddressVillageName,
        'fishpond_name': fishpondName,
        'fishpond_area_length': fishpondAreaLength?.toDouble(),
        'fishpond_area_width': fishpondAreaWidth,
        'fishpond_area_total': fishpondAreaTotal,
        'fishpond_area_depth': fishpondAreaDepth,
        'tebar_fish_total': tebarFishTotal,
        'densitas': densitas,
        'fishseed_id': fishseedId,
        'fishseed_name': fishseedName,
        'fishseed_varietas_id': fishseedVarietasId,
        'fishseed_varietas_name': fishseedVarietasName,
        'fishseed_hatchery_id': fishseedHatcheryId,
        'fishseed_hatchery_name': fishseedHatcheryName,
        'total_biomasa': totalBiomasa,
        'target_panen_bobot': targetPanenBobot,
        'estimation_panen_date':
            "${estimationPanenDate!.year.toString().padLeft(4, '0')}-${estimationPanenDate!.month.toString().padLeft(2, '0')}-${estimationPanenDate!.day.toString().padLeft(2, '0')}",
        'actual_panen_date':
            "${actualPanenDate!.year.toString().padLeft(4, '0')}-${actualPanenDate!.month.toString().padLeft(2, '0')}-${actualPanenDate!.day.toString().padLeft(2, '0')}",
        'estimation_panen_tonase': estimationPanenTonase,
        'total_tonase_panen': totalTonasePanen,
        'kriteria_hasil_panen': kriteriaHasilPanen,
        'nilai_sr_keseluruhan': nilaiSrKeseluruhan,
        'nilai_epp_keseluruhan': nilaiEppKeseluruhan,
        'nilai_fcr_keseluruhan': nilaiFcrKeseluruhan,
        'pertumbuhan_ikan_keseluruhan': pertumbuhanIkanKeseluruhan,
        'produktivitas_keseluruhan': produktivitasKeseluruhan,
        'pakan': pakan == null
            ? []
            : List<dynamic>.from(pakan!.map((x) => x.toMap())),
        'tanggal_panen':
            "${tanggalPanen!.year.toString().padLeft(4, '0')}-${tanggalPanen!.month.toString().padLeft(2, '0')}-${tanggalPanen!.day.toString().padLeft(2, '0')}",
        'total_panen': totalPanen,
        'doc': doc,
        'mbw_akhir': mbwAkhir,
        'jumlah_ikan_akhir': jumlahIkanAkhir,
        'sr': sr,
        'total_pakan': totalPakan,
        'epp': epp,
        'fcr': fcr,
        'adg': adg,
        'produktivitas': produktivitas,
      };
}

class Pakan {
  final String? fishfoodId;
  final String? fishfoodType;
  final String? fishfoodName;
  final double? sumFeedingActual;

  Pakan({
    this.fishfoodId,
    this.fishfoodType,
    this.fishfoodName,
    this.sumFeedingActual,
  });

  factory Pakan.fromJson(String str) => Pakan.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Pakan.fromMap(Map<String, dynamic> json) => Pakan(
        fishfoodId: json['fishfood_id'],
        fishfoodType: json['fishfood_type'],
        fishfoodName: json['fishfood_name'],
        sumFeedingActual: json['sum_feeding_actual'].toDouble(),
      );

  Map<String, dynamic> toMap() => {
        'fishfood_id': fishfoodId,
        'fishfood_type': fishfoodType,
        'fishfood_name': fishfoodName,
        'sum_feeding_actual': sumFeedingActual,
      };
}

class Pagination {
  final int? totalData;
  final int? totalPage;
  final int? totalDisplay;
  final bool? firstPage;
  final bool? lastPage;
  final int? prev;
  final int? current;
  final int? next;
  final List<dynamic>? detail;
  final int? start;
  final int? end;

  Pagination({
    this.totalData,
    this.totalPage,
    this.totalDisplay,
    this.firstPage,
    this.lastPage,
    this.prev,
    this.current,
    this.next,
    this.detail,
    this.start,
    this.end,
  });

  factory Pagination.fromJson(String str) =>
      Pagination.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Pagination.fromMap(Map<String, dynamic> json) => Pagination(
        totalData: json['total_data'],
        totalPage: json['total_page'],
        totalDisplay: json['total_display'],
        firstPage: json['first_page'],
        lastPage: json['last_page'],
        prev: json['prev'],
        current: json['current'],
        next: json['next'],
        detail: json['detail'] == null
            ? []
            : List<dynamic>.from(json['detail']!.map((x) => x)),
        start: json['start'],
        end: json['end'],
      );

  Map<String, dynamic> toMap() => {
        'total_data': totalData,
        'total_page': totalPage,
        'total_display': totalDisplay,
        'first_page': firstPage,
        'last_page': lastPage,
        'prev': prev,
        'current': current,
        'next': next,
        'detail':
            detail == null ? [] : List<dynamic>.from(detail!.map((x) => x)),
        'start': start,
        'end': end,
      };
}
