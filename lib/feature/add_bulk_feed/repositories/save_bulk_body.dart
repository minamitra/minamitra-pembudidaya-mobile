import 'package:minamitra_pembudidaya_mobile/feature/add_bulk_feed/repositories/recommendation_feed_bulk_response.dart';

class SaveBulkBody {
  final DateTime date;
  final List<RecommendationFeedBulkData>? data;

  SaveBulkBody({
    required this.date,
    required this.data,
  });

  Map<String, dynamic> toMap() => {
        "datetime": date.toString(),
        "bulk_data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.submitBulkMap())),
      };
}
