import 'dart:typed_data';
import 'package:flutter_bloc/flutter_bloc.dart';

class MultipleImageCubit extends Cubit<List<Uint8List>?> {
  MultipleImageCubit() : super(null);

  void setImage(Uint8List image) {
    final List<Uint8List> listImage = [...state ?? []];
    if (listImage.length < 3) {
      listImage.add(image);
    } else {
      listImage.removeAt(0);
      listImage.add(image);
    }
    emit(listImage);
  }

  void removeImage(int index) {
    final List<Uint8List> listImage = state != null ? [...state!] : [];
    listImage.removeAt(index);
    emit(listImage);
  }
}
