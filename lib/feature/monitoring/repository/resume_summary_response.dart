import 'dart:convert';

class ResumeSummaryResponse {
  final ResumeSummaryResponseData? data;

  ResumeSummaryResponse({this.data});

  factory ResumeSummaryResponse.fromJson(String str) =>
      ResumeSummaryResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ResumeSummaryResponse.fromMap(Map<String, dynamic> json) =>
      ResumeSummaryResponse(
        data: json['data'] == null
            ? null
            : ResumeSummaryResponseData.fromMap(json['data']),
      );

  Map<String, dynamic> toMap() => {
        'data': data?.toMap(),
      };
}

class ResumeSummaryResponseData {
  final String? kriteriaHasilPanen;
  final String? nilaiSrKeseluruhan;
  final String? nilaiEppKeseluruhan;
  final String? nilaiFcrKeseluruhan;
  final String? pertumbuhanIkanKeseluruhan;
  final String? produktivitasKeseluruhan;

  ResumeSummaryResponseData({
    this.kriteriaHasilPanen,
    this.nilaiSrKeseluruhan,
    this.nilaiEppKeseluruhan,
    this.nilaiFcrKeseluruhan,
    this.pertumbuhanIkanKeseluruhan,
    this.produktivitasKeseluruhan,
  });

  factory ResumeSummaryResponseData.fromJson(String str) =>
      ResumeSummaryResponseData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ResumeSummaryResponseData.fromMap(Map<String, dynamic> json) =>
      ResumeSummaryResponseData(
        kriteriaHasilPanen: json['kriteria_hasil_panen'],
        nilaiSrKeseluruhan: json['nilai_sr_keseluruhan'],
        nilaiEppKeseluruhan: json['nilai_epp_keseluruhan'],
        nilaiFcrKeseluruhan: json['nilai_fcr_keseluruhan'],
        pertumbuhanIkanKeseluruhan: json['pertumbuhan_ikan_keseluruhan'],
        produktivitasKeseluruhan: json['produktivitas_keseluruhan'],
      );

  Map<String, dynamic> toMap() => {
        'kriteria_hasil_panen': kriteriaHasilPanen,
        'nilai_sr_keseluruhan': nilaiSrKeseluruhan,
        'nilai_epp_keseluruhan': nilaiEppKeseluruhan,
        'nilai_fcr_keseluruhan': nilaiFcrKeseluruhan,
        'pertumbuhan_ikan_keseluruhan': pertumbuhanIkanKeseluruhan,
        'produktivitas_keseluruhan': produktivitasKeseluruhan,
      };
}
