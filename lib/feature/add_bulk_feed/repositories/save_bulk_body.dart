import 'package:minamitra_pembudidaya_mobile/feature/add_bulk_feed/repositories/recommendation_feed_bulk_response.dart';

class SaveBulkBody {
  final DateTime date;
  final String timeSheet;
  final List<String>? timeSheetJsonArray;
  final List<RecommendationFeedBulkData>? data;

  SaveBulkBody({
    required this.date,
    required this.timeSheet,
    this.timeSheetJsonArray,
    required this.data,
  });

  Map<String, dynamic> toMap() => {
        'datetime': date.toString(),
        'time_sheet': timeSheet,
        'time_sheet_json_array': timeSheetJsonArray == null
            ? null
            : List<dynamic>.from(timeSheetJsonArray!.map((x) => x)),
        'bulk_data': data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.submitBulkMap())),
      };
}
