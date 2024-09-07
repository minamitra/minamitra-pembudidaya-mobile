import 'package:flutter/material.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_bar.dart';
import 'package:minamitra_pembudidaya_mobile/feature/add_bulk_feed/view/add_bulk_feed_view.dart';

class AddBulkFeedPage extends StatelessWidget {
  const AddBulkFeedPage({super.key});

  static RouteSettings routeSettings() =>
      const RouteSettings(name: "/add-bulk-feed-page");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appDefaultAppBar(
        context,
        "Tambah Pakan",
      ),
      body: AddBulkFeedView(),
    );
  }
}
