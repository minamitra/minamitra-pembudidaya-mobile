import 'dart:ui';
import 'package:minamitra_pembudidaya_mobile/core/themes/app_color.dart';

enum IncidentType { process, waiting, done, rejected }

String incidentTypeToString(IncidentType type) {
  switch (type) {
    case IncidentType.process:
      return 'Proses';
    case IncidentType.waiting:
      return 'Menunggu';
    case IncidentType.done:
      return 'Selesai';
    case IncidentType.rejected:
      return 'Ditolak';
  }
}

Color incidentTypeColor(IncidentType type) {
  switch (type) {
    case IncidentType.process:
      return AppColor.secondary[900]!;
    case IncidentType.waiting:
      return AppColor.accent[900]!;
    case IncidentType.done:
      return AppColor.green[500]!;
    case IncidentType.rejected:
      return AppColor.red;
  }
}

class Incident {
  final String title;
  final String date;
  final IncidentType type;
  final String description;

  Incident({
    required this.title,
    required this.date,
    required this.type,
    required this.description,
  });
}

final List<Incident> listIncidentAll = [
  Incident(
    title: 'Kejadian 1',
    date: '05-08-2024 17:00 WIB',
    type: IncidentType.process,
    description:
        'Figma ipsum component variant main layer. Device scale scale hand duplicate main union content arrow. Device scale scale hand duplicate main union content arrow.Device scale scale hand duplicate main union content arrow.',
  ),
  Incident(
    title: 'Kejadian 2',
    date: '05-08-2024 17:00 WIB',
    type: IncidentType.done,
    description:
        'Figma ipsum component variant main layer. Device scale scale hand duplicate main union content arrow. Device scale scale hand duplicate main union content arrow.Device scale scale hand duplicate main union content arrow.',
  ),
  Incident(
    title: 'Kejadian 3',
    date: '05-08-2024 17:00 WIB',
    type: IncidentType.waiting,
    description:
        'Figma ipsum component variant main layer. Device scale scale hand duplicate main union content arrow. Device scale scale hand duplicate main union content arrow.Device scale scale hand duplicate main union content arrow.',
  ),
  Incident(
    title: 'Kejadian 4',
    date: '05-08-2024 17:00 WIB',
    type: IncidentType.rejected,
    description:
        'Figma ipsum component variant main layer. Device scale scale hand duplicate main union content arrow. Device scale scale hand duplicate main union content arrow.Device scale scale hand duplicate main union content arrow.',
  ),
];

final List<Incident> listIncidentProcess = [
  Incident(
    title: 'Kejadian 1',
    date: '05-08-2024 17:00 WIB',
    type: IncidentType.process,
    description:
        'Figma ipsum component variant main layer. Device scale scale hand duplicate main union content arrow. Device scale scale hand duplicate main union content arrow.Device scale scale hand duplicate main union content arrow.',
  ),
];

final List<Incident> listIncidentWaiting = [
  Incident(
    title: 'Kejadian 3',
    date: '05-08-2024 17:00 WIB',
    type: IncidentType.waiting,
    description:
        'Figma ipsum component variant main layer. Device scale scale hand duplicate main union content arrow. Device scale scale hand duplicate main union content arrow.Device scale scale hand duplicate main union content arrow.',
  ),
];

final List<Incident> listIncidentDone = [
  Incident(
    title: 'Kejadian 2',
    date: '05-08-2024 17:00 WIB',
    type: IncidentType.done,
    description:
        'Figma ipsum component variant main layer. Device scale scale hand duplicate main union content arrow. Device scale scale hand duplicate main union content arrow.Device scale scale hand duplicate main union content arrow.',
  ),
];

final List<Incident> listIncidentRejected = [
  Incident(
    title: 'Kejadian 4',
    date: '05-08-2024 17:00 WIB',
    type: IncidentType.rejected,
    description:
        'Figma ipsum component variant main layer. Device scale scale hand duplicate main union content arrow. Device scale scale hand duplicate main union content arrow.Device scale scale hand duplicate main union content arrow.',
  ),
];
