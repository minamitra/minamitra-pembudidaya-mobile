import 'package:flutter/material.dart';
import 'package:minamitra_pembudidaya_mobile/core/themes/app_color.dart';

class NotificationDetailView extends StatefulWidget {
  const NotificationDetailView(
    this.title,
    this.time,
    this.description, {
    this.image,
    super.key,
  });

  final String title;
  final String time;
  final String description;
  final String? image;

  @override
  State<NotificationDetailView> createState() => _NotificationDetailViewState();
}

class _NotificationDetailViewState extends State<NotificationDetailView> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        if (widget.image != null) ...[
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.asset(
              widget.image!,
              width: double.infinity,
              height: 135.0,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 16.0),
        ],
        Text(
          widget.title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4.0),
        Text(
          widget.time,
          style: Theme.of(context)
              .textTheme
              .labelLarge
              ?.copyWith(color: AppColor.neutral[400]),
        ),
        const SizedBox(height: 16.0),
        Text(
          widget.description,
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }
}
