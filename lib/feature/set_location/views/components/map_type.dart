import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:minamitra_pembudidaya_mobile/core/themes/app_color.dart';
import 'package:minamitra_pembudidaya_mobile/core/themes/app_shadow.dart';
import 'package:minamitra_pembudidaya_mobile/feature/set_location/logics/set_location_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/main.dart';

class MapTypeSection extends StatefulWidget {
  const MapTypeSection({super.key});

  @override
  State<MapTypeSection> createState() => _MapTypeSectionState();
}

class _MapTypeSectionState extends State<MapTypeSection> {
  @override
  Widget build(BuildContext context) {
    Widget item(
      String text,
      MapType type,
      bool isSelected,
    ) {
      return InkWell(
        onTap: () {
          if (isSelected) return;
          context.read<SetLocationCubit>().updateMapType(type);
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
          decoration: BoxDecoration(
            color: isSelected
                ? AppColor.primary.withOpacity(0.8)
                : Colors.white.withOpacity(0.8),
            borderRadius: BorderRadius.circular(4.0),
            boxShadow: AppBoxShadow().medium,
          ),
          child: Text(
            text,
            style: appTextTheme(context).bodySmall?.copyWith(
                  color: isSelected ? Colors.white : AppColor.neutral[500],
                  fontWeight: isSelected ? FontWeight.bold : null,
                ),
          ),
        ),
      );
    }

    return BlocBuilder<SetLocationCubit, SetLocationState>(
      builder: (context, state) {
        if (state.status == SetLocationStateStatus.loading ||
            state.status == SetLocationStateStatus.initial ||
            state.status == SetLocationStateStatus.error) {
          return const SizedBox();
        }
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              item(
                'Normal',
                MapType.normal,
                state.mapType == MapType.normal,
              ),
              const SizedBox(width: 8.0),
              item(
                'Satellite',
                MapType.satellite,
                state.mapType == MapType.satellite,
              ),
              const SizedBox(width: 8.0),
              item(
                'Hybrid',
                MapType.hybrid,
                state.mapType == MapType.hybrid,
              ),
            ],
          ),
        );
      },
    );
  }
}
