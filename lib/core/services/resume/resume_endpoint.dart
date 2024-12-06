import 'package:minamitra_pembudidaya_mobile/core/network/url_builder.dart';

class ResumeEndpoint {
  ResumeEndpoint();

  Uri getSummary(String fishPondID) {
    return createUrl(
      path: 'mitra/resume-budidaya/summary',
      queryParameters: {
        'fishpond_id': fishPondID,
      },
    );
  }

  Uri getResumePerCycle(String fishPondID) {
    return createUrl(
      path: 'mitra/resume-budidaya/data-per-cycle',
      queryParameters: {
        'fishpond_id': fishPondID,
      },
    );
  }
}
