import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_animated_size.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_bottom_sheet.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_button.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_image_picker.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_text_field.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_top_snackbar.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/pick_image_services/pick_image_service.dart';
import 'package:minamitra_pembudidaya_mobile/core/themes/app_color.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_assets.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_convert_string.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_transition.dart';
import 'package:minamitra_pembudidaya_mobile/feature/bill_payment/view/bill_payment_page.dart';
import 'package:minamitra_pembudidaya_mobile/feature/checkout/repositories/selected_payment.dart';
import 'package:minamitra_pembudidaya_mobile/main.dart';
import 'package:minamitra_pembudidaya_mobile/widget/view/waiting_payment_page.dart';

class BillPaymentConfirmationPayedView extends StatefulWidget {
  const BillPaymentConfirmationPayedView(this.selectedPayment, {super.key});

  final SelectedPayment selectedPayment;

  @override
  State<BillPaymentConfirmationPayedView> createState() =>
      _BillPaymentConfirmationPayedViewState();
}

class _BillPaymentConfirmationPayedViewState
    extends State<BillPaymentConfirmationPayedView> {
  @override
  Widget build(BuildContext context) {
    Widget notification() {
      return Container(
        padding: const EdgeInsets.symmetric(
          vertical: 10.0,
          horizontal: 12.0,
        ),
        decoration: BoxDecoration(
          color: AppColor.accent[50],
          borderRadius: BorderRadius.circular(16.0),
          border: Border.all(color: AppColor.accent[500]!),
        ),
        child: Row(
          children: [
            const Icon(
              Icons.info_outline,
              color: AppColor.accent,
            ),
            const SizedBox(width: 12.0),
            Expanded(
              child: Text(
                'Apabila telah menyelesaikan pembayaran, klik tombol “Saya Sudah Bayar” untuk unggah bukti',
                textAlign: TextAlign.start,
                style: appTextTheme(context).labelLarge?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: AppColor.neutral[600],
                    ),
              ),
            ),
          ],
        ),
      );
    }

    Widget transferBankItem({
      required String title,
      required String value,
    }) {
      return Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: appTextTheme(context).bodySmall?.copyWith(
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF9CA3AF),
                      ),
                ),
                const SizedBox(height: 4.0),
                Text(
                  value,
                  style: appTextTheme(context).titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppColor.black,
                      ),
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () {
              Clipboard.setData(ClipboardData(text: value)).then((_) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('$title Berhasil disalin'),
                  ),
                );
              });
            },
            child: Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: AppColor.primary[600]!),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.copy,
                    size: 20.0,
                    color: AppColor.primary[600],
                  ),
                  const SizedBox(width: 4.0),
                  Text(
                    'Salin',
                    style: appTextTheme(context).titleSmall?.copyWith(
                          color: AppColor.primary[600],
                        ),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    }

    Widget paymentMethod() {
      return Container(
        color: AppColor.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: widget.selectedPayment.paymentMethod?.toLowerCase() ==
                          'transfer'
                      ? Image.network(
                          widget.selectedPayment.imageUrl ?? '',
                          width: 40,
                          height: 40,
                          fit: BoxFit.cover,
                        )
                      : Image.asset(
                          widget.selectedPayment.imageAsset ??
                              AppAssets.walletSquareIcon,
                          width: 40,
                          height: 40,
                          fit: BoxFit.cover,
                        ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.selectedPayment.paymentMethod?.toLowerCase() ==
                                'transfer'
                            ? widget.selectedPayment.paymentMethod
                                    ?.handlingEmptyString() ??
                                ''
                            : 'Cash',
                        textAlign: TextAlign.start,
                        style: appTextTheme(context).bodySmall?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: AppColor.black,
                            ),
                      ),
                      Text(
                        widget.selectedPayment.paymentMethod?.toLowerCase() ==
                                'transfer'
                            ? widget.selectedPayment.accountName
                                .handlingEmptyString()
                            : 'Bayar tunai di tempat',
                        textAlign: TextAlign.start,
                        style: appTextTheme(context).bodySmall?.copyWith(
                              fontWeight: FontWeight.w400,
                              color: AppColor.black[400],
                            ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18.0),
            if (widget.selectedPayment.paymentMethod?.toLowerCase() ==
                'transfer') ...[
              const SizedBox(height: 18.0),
              transferBankItem(
                title: 'Rekening tujuan',
                value:
                    widget.selectedPayment.accountNumber.handlingEmptyString(),
              ),
              const SizedBox(height: 18.0),
            ],
            transferBankItem(
              title: 'Total Bayar',
              value: 'Rp 100.000',
            ),
          ],
        ),
      );
    }

    List<Widget> bottomButton() {
      return [
        const SizedBox(height: 18.0),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: AppPrimaryFullButton(
            'Saya Sudah Bayar',
            uploadPaymentProof(
              context,
              (image, notes) {
                Navigator.of(context).pushAndRemoveUntil(
                  AppTransition.pushAndRemoveUntilTransition(
                    const WaitingPaymentPage(),
                    WaitingPaymentPage.routeSettings(),
                  ),
                  ModalRoute.withName(BillPaymentPage.routeSettings.name!),
                );
              },
            ),
          ),
        ),
        const SizedBox(height: 18.0),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: AppPrimaryOutlineFullButton(
            'Batalkan',
            () {
              Navigator.of(context).pop();
            },
          ),
        ),
        const SizedBox(height: 18.0),
      ];
    }

    return Column(
      children: [
        Expanded(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            shrinkWrap: true,
            physics: const AlwaysScrollableScrollPhysics(),
            children: [
              const SizedBox(height: 18.0),
              notification(),
              const SizedBox(height: 36.0),
              paymentMethod(),
            ],
          ),
        ),
        ...bottomButton(),
      ],
    );
  }
}

Function() onImageTap(
  BuildContext context,
  Function(File image) imageChanged,
) {
  return () {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      builder: (bottomSheetContext) {
        return AppImagePickerMenu(
          'Upload Gambar',
          (type) async {
            switch (type) {
              case PhotoSource.camera:
                final document = await pickDocumentImage(
                  bottomSheetContext,
                  ImageSource.camera,
                  maxSize: 2000000,
                  typeValidations: ['jpg', 'jpeg', 'png', 'img'],
                );
                if (document != null) {
                  if (context.mounted) {
                    imageChanged(File(document.path));
                    await Future.delayed(const Duration(milliseconds: 500));
                    if (bottomSheetContext.mounted) {
                      Navigator.of(bottomSheetContext).pop();
                    }
                  }
                }
                break;
              case PhotoSource.gallery:
                final document = await pickDocumentImage(
                  bottomSheetContext,
                  ImageSource.gallery,
                  maxSize: 2000000,
                  typeValidations: ['jpg', 'jpeg', 'png', 'img'],
                );
                if (document != null) {
                  if (context.mounted) {
                    imageChanged(File(document.path));
                    await Future.delayed(const Duration(milliseconds: 500));
                    if (bottomSheetContext.mounted) {
                      Navigator.of(bottomSheetContext).pop();
                    }
                  }
                }
                break;
            }
          },
        );
      },
    );
  };
}

Function() uploadPaymentProof(
  BuildContext context,
  Function(File image, String notes) onSubmit,
) {
  return () {
    File? proofImage;
    final TextEditingController noteController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (modalContext) {
        Widget noteTextField() {
          return AppValidatorTextField(
            controller: noteController,
            hintText: 'Masukan catatan',
            labelText: 'Catatan',
            maxLines: 3,
          );
        }

        return StatefulBuilder(
          builder: (stateContext, setModalState) {
            return AppBottomSheet(
              'Bukti Pembayaran',
              height: MediaQuery.of(context).size.height * 0.7,
              ListView(
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 16.0,
                ),
                physics: const AlwaysScrollableScrollPhysics(),
                children: [
                  Wrap(
                    children: [
                      Text(
                        'Unggah Bukti',
                        style: appTextTheme(context).bodyMedium,
                      ),
                      Text(
                        ' *',
                        style: appTextTheme(context)
                            .bodyMedium
                            ?.copyWith(color: Colors.red),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8.0),
                  AppAnimatedSize(
                    isShow: true,
                    child: SizedBox(
                      height: 170,
                      width: double.infinity,
                      child: InkWell(
                        onTap: onImageTap(
                          context,
                          (file) {
                            setModalState(() {
                              proofImage = file;
                            });
                          },
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            border: Border.all(color: AppColor.neutral[200]!),
                          ),
                          child: proofImage == null
                              ? Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      AppAssets.galleryIcon,
                                      height: 32,
                                    ),
                                    const SizedBox(height: 18.0),
                                    Text(
                                      'Tambah Gambar',
                                      style: appTextTheme(context)
                                          .bodySmall
                                          ?.copyWith(
                                            color: AppColor.neutral[500],
                                          ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                )
                              : Image.file(
                                  proofImage!,
                                  fit: BoxFit.cover,
                                ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    'Unggah file .jpg, .jpeg, .png, .img ukuran maks 2MB',
                    style: appTextTheme(context).labelLarge?.copyWith(
                          color: AppColor.neutral[500],
                        ),
                  ),
                  const SizedBox(height: 16),
                  noteTextField(),
                  const SizedBox(height: 36),
                  AppPrimaryFullButton(
                    'Konfirmasi',
                    () {
                      if (proofImage == null) {
                        AppTopSnackBar(context)
                            .showDanger('Upload bukti terlebih dahulu');
                        return;
                      }
                      Navigator.of(context).pop();
                      onSubmit(proofImage!, noteController.text);
                    },
                    height: 56,
                  ),
                  SizedBox(height: MediaQuery.sizeOf(context).height * 0.25),
                ],
              ),
            );
          },
        );
      },
    );
  };
}
