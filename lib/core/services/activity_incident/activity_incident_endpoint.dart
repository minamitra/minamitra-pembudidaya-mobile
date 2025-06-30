import 'package:minamitra_pembudidaya_mobile/core/network/url_builder.dart';

class ActivityIncidentEndpoint {
  ActivityIncidentEndpoint();

  Uri dataIncident(
    String status,
    String fishpondCycleID,
  ) {
    return createUrl(
      path: 'mitra/incident-report/data',
      queryParameters: {
        'status[in]': status,
        'fishpondcycle_id': fishpondCycleID,
      },
    );
  }

  Uri detailIncident(String id) {
    return createUrl(
      path: 'mitra/incident-report/detail',
      queryParameters: {
        'id': id,
      },
    );
  }

  Uri addIncident() {
    return createUrl(path: 'mitra/incident-report/add');
  }

  Uri deleteIncident() {
    return createUrl(path: 'mitra/incident-report/delete');
  }

  Uri updateIncident() {
    return createUrl(path: 'mitra/incident-report/update');
  }

  Uri dataIncidentDetail(String incidentID) {
    return createUrl(
      path: 'mitra/incident-report/detail',
      queryParameters: {'id': incidentID},
    );
  }
}
