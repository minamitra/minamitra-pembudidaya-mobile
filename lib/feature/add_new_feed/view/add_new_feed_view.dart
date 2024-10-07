import 'package:flutter/material.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_bottom_sheet.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_button.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_text_field.dart';
import 'package:minamitra_pembudidaya_mobile/core/themes/app_color.dart';
import 'package:minamitra_pembudidaya_mobile/main.dart';

class AddNewFeedView extends StatefulWidget {
  const AddNewFeedView({super.key});

  @override
  State<AddNewFeedView> createState() => _AddNewFeedViewState();
}

class _AddNewFeedViewState extends State<AddNewFeedView> {
  final TextEditingController newFeedTypeController = TextEditingController();
  final TextEditingController newFeedNameController = TextEditingController();
  final TextEditingController newFeedSizeController = TextEditingController();
  final TextEditingController newFeedProteinController =
      TextEditingController();
  final TextEditingController newFeedEPPController = TextEditingController();
  final TextEditingController newFeedPriceController = TextEditingController();
  final TextEditingController newFeedUnitController = TextEditingController();
  final TextEditingController newFeedSupplierController =
      TextEditingController();
  final TextEditingController newFeedNoteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Widget newFeedType(BuildContext context) {
      return AppValidatorTextField(
        controller: newFeedTypeController,
        isMandatory: true,
        withUpperLabel: true,
        readOnly: true,
        labelText: "Jenis Pakan Baru",
        hintText: "Pilih Jenis Pakan",
        suffixWidget: const Padding(
          padding: EdgeInsets.only(right: 18.0),
          child: Icon(Icons.arrow_drop_down_rounded),
        ),
        suffixConstraints: const BoxConstraints(),
        validator: (value) {
          if (value?.isEmpty ?? true) {
            return "Jenis Pakan tidak boleh kosong";
          }
          return null;
        },
        onTap: appBottomSheetShowModal(
          context,
          "Pilih Jenis Pakan",
          ["Starter", "Grower", "Finisher"],
          (value) {},
        ),
      );
    }

    Widget newFeedName() {
      return AppValidatorTextField(
        controller: newFeedNameController,
        hintText: "Masukkan Nama Pakan Baru",
        labelText: "Nama Pakan Baru",
        isMandatory: true,
        validator: (String? value) {
          if (value!.isEmpty) {
            return "Nama Pakan tidak boleh kosong";
          }
          return null;
        },
        // suffixConstraints: const BoxConstraints(),
        // suffixWidget: Padding(
        //   padding: const EdgeInsets.only(right: 18.0),
        //   child: Text(
        //     "hari",
        //     style: appTextTheme(context).bodySmall?.copyWith(
        //           color: AppColor.neutral[500],
        //           fontWeight: FontWeight.w500,
        //         ),
        //   ),
        // ),
      );
    }

    Widget newFeedSize() {
      return AppValidatorTextField(
        controller: newFeedSizeController,
        hintText: "Masukkan Ukuran Pakan Baru",
        labelText: "Ukuran Pakan Baru",
        isMandatory: true,
        validator: (String? value) {
          if (value!.isEmpty) {
            return "Ukuran Pakan tidak boleh kosong";
          }
          return null;
        },
        suffixConstraints: const BoxConstraints(),
        suffixWidget: Padding(
          padding: const EdgeInsets.only(right: 18.0),
          child: Text(
            "Kg",
            style: appTextTheme(context).bodySmall?.copyWith(
                  color: AppColor.neutral[500],
                  fontWeight: FontWeight.w500,
                ),
          ),
        ),
      );
    }

    Widget newFeedProtein() {
      return AppValidatorTextField(
        controller: newFeedProteinController,
        hintText: "Masukkan Protein Pakan Baru",
        labelText: "Protein Pakan Baru",
        isMandatory: true,
        validator: (String? value) {
          if (value!.isEmpty) {
            return "Protein Pakan tidak boleh kosong";
          }
          return null;
        },
        suffixConstraints: const BoxConstraints(),
        suffixWidget: Padding(
          padding: const EdgeInsets.only(right: 18.0),
          child: Text(
            "%",
            style: appTextTheme(context).bodySmall?.copyWith(
                  color: AppColor.neutral[500],
                  fontWeight: FontWeight.w500,
                ),
          ),
        ),
      );
    }

    Widget newFeedEPP() {
      return AppValidatorTextField(
        controller: newFeedEPPController,
        hintText: "Masukkan estimasi EPP Baru",
        labelText: "Estimasi EPP Baru",
        isMandatory: true,
        validator: (String? value) {
          if (value!.isEmpty) {
            return "EPP Pakan tidak boleh kosong";
          }
          return null;
        },
        suffixConstraints: const BoxConstraints(),
        suffixWidget: Padding(
          padding: const EdgeInsets.only(right: 18.0),
          child: Text(
            "%",
            style: appTextTheme(context).bodySmall?.copyWith(
                  color: AppColor.neutral[500],
                  fontWeight: FontWeight.w500,
                ),
          ),
        ),
      );
    }

    Widget newFeedPrice() {
      return AppValidatorTextField(
        controller: newFeedPriceController,
        hintText: "   0",
        labelText: "Harga Pakan Baru",
        isMandatory: true,
        validator: (String? value) {
          if (value!.isEmpty) {
            return "Harga Pakan tidak boleh kosong";
          }
          return null;
        },
        suffixConstraints: const BoxConstraints(),
        prefixIcon: Padding(
          padding: const EdgeInsets.only(left: 18.0),
          child: Text(
            "Rp",
            style: appTextTheme(context).bodySmall?.copyWith(
                  color: AppColor.neutral[500],
                  fontWeight: FontWeight.w500,
                ),
          ),
        ),
      );
    }

    Widget newFeedUnit(BuildContext context) {
      return AppValidatorTextField(
        controller: newFeedUnitController,
        isMandatory: false,
        withUpperLabel: true,
        readOnly: true,
        labelText: "Satuan Pakan Baru",
        hintText: "Pilih Satuan Pakan",
        suffixWidget: const Padding(
          padding: EdgeInsets.only(right: 18.0),
          child: Icon(Icons.arrow_drop_down_rounded),
        ),
        suffixConstraints: const BoxConstraints(),
        validator: (value) {
          if (value?.isEmpty ?? true) {
            // return "Satuan Pakan tidak boleh kosong";
            return null;
          }
          return null;
        },
        onTap: appBottomSheetShowModal(
          context,
          "Pilih Satuan Pakan",
          ["gram", "Kilogram", "Ton"],
          (value) {},
        ),
      );
    }

    Widget newFeedSupplier(BuildContext context) {
      return AppValidatorTextField(
        controller: newFeedSupplierController,
        isMandatory: false,
        withUpperLabel: true,
        readOnly: true,
        labelText: "Supplier Pakan Baru",
        hintText: "Pilih Supplier Pakan",
        suffixWidget: const Padding(
          padding: EdgeInsets.only(right: 18.0),
          child: Icon(Icons.arrow_drop_down_rounded),
        ),
        suffixConstraints: const BoxConstraints(),
        validator: (value) {
          if (value?.isEmpty ?? true) {
            // return "Supplier Pakan tidak boleh kosong";
            return null;
          }
          return null;
        },
        onTap: appBottomSheetShowModal(
          context,
          "Pilih Supplier Pakan",
          ["Mina", "Mitra", "Mandiri", "lainnya"],
          (value) {},
        ),
      );
    }

    Widget newFeedNote() {
      return AppValidatorTextField(
        controller: newFeedNoteController,
        hintText: "Masukan keterangan pakan ...",
        labelText: "Keterangan Pakan Baru",
        maxLines: 3,
        isMandatory: false,
        validator: (String? value) {
          if (value!.isEmpty) {
            // return "Catatan tidak boleh kosong";
            return null;
          }
          return null;
        },
      );
    }

    Widget body() {
      return ListView(
        shrinkWrap: true,
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          const SizedBox(height: 16.0),
          newFeedType(context),
          const SizedBox(height: 16.0),
          newFeedName(),
          const SizedBox(height: 16.0),
          newFeedSize(),
          const SizedBox(height: 16.0),
          newFeedProtein(),
          const SizedBox(height: 16.0),
          newFeedEPP(),
          const SizedBox(height: 16.0),
          newFeedPrice(),
          const SizedBox(height: 16.0),
          newFeedUnit(context),
          const SizedBox(height: 16.0),
          newFeedSupplier(context),
          const SizedBox(height: 16.0),
          newFeedNote(),
          const SizedBox(height: 32.0),
        ],
      );
    }

    Widget button() {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        decoration: BoxDecoration(
          color: AppColor.white,
          border: Border(
            top: BorderSide(
              color: AppColor.neutral[200]!,
              width: 1.0,
            ),
          ),
        ),
        child: AppPrimaryFullButton(
          "Simpan",
          () {},
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: Column(
        children: [
          Expanded(child: body()),
          button(),
        ],
      ),
    );
  }
}
