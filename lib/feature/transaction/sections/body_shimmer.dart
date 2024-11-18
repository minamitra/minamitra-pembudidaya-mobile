import 'package:flutter/material.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_shimmer.dart';

Widget bodyShimmer() {
  return ListView.builder(
    shrinkWrap: true,
    physics: const AlwaysScrollableScrollPhysics(),
    itemCount: 10,
    itemBuilder: (context, index) {
      return const AppShimmer(
        120,
        double.infinity,
        8.0,
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      );
    },
  );
}
