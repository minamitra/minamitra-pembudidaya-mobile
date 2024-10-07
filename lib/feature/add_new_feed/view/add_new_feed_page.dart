import 'package:flutter/material.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_bar.dart';
import 'package:minamitra_pembudidaya_mobile/feature/add_new_feed/view/add_new_feed_view.dart';

class AddNewFeedPage extends StatelessWidget {
  const AddNewFeedPage({super.key});

  static const RouteSettings routeSettings =
      RouteSettings(name: '/add-new-feed-page');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appDefaultAppBar(
        context,
        "Tambah Pakan Baru",
      ),
      body: AddNewFeedView(),
    );
  }
}
