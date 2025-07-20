import 'package:matrices/matrices.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_double.dart';
import 'package:minamitra_pembudidaya_mobile/feature/ahp/repositories/mat_alternatives.dart';
import 'package:minamitra_pembudidaya_mobile/feature/ahp/repositories/mat_criteria.dart';
import 'package:minamitra_pembudidaya_mobile/feature/ahp/repositories/result_alternative.dart';

void main() {
  ahp();
}

List<String> ahp() {
  // Perhitungan metode AHP
  print(matCriteria);

  // normalisasi kriteria
  Matrix resultNormalizationCriteria = calculateNormalization(matCriteria);
  print('Normalisasi Kriteria: $resultNormalizationCriteria');

  // Bobot Prioritas Criteria
  List<double> resultCriteriaWeightPriority =
      calculateWeightPriority(matCriteria, resultNormalizationCriteria);
  print('Bobot Prioritas Kriteria: $resultCriteriaWeightPriority\n');

  // Konsistensi Matriks Criteria
  List<double> resultConsistencyCriteria = calculateConsistencyCriteria(
      matCriteria, resultNormalizationCriteria, resultCriteriaWeightPriority);
  print('Konsistensi Kriteria: $resultConsistencyCriteria\n');

  // Rata rata konsistensi matriks
  double resultAverageConsistencyCriteria =
      calculateAverageConsistency(resultConsistencyCriteria);
  print('Rata-rata Konsistensi Kriteria: $resultAverageConsistencyCriteria\n');

  // Perhitungan Index Konsistensi
  double resultIndexConsistencyCriteria = appDoubleConvert(
    (resultAverageConsistencyCriteria - matCriteria.rowCount) /
        (matCriteria.rowCount - 1),
    fix: 4,
  );

  print('Index Konsistensi Kriteria: $resultIndexConsistencyCriteria\n');

  // Perhitungan Rasio Konsistensi
  double resultRatioConsistencyCriteria = resultIndexConsistencyCriteria / 1.24;

  print('Rasio Konsistensi Kriteria: $resultRatioConsistencyCriteria\n');

  if (resultRatioConsistencyCriteria < 0.1) {
    print('Kriteria Konsistensi\n');
  } else {
    print('Kriteria Tidak Konsistensi\n');
  }

  // ALTERNATIF
  String resultStarter1 = calculateResutlAlternative(
    'Starter 1',
    listAlternativeStarter1,
    resultCriteriaWeightPriority,
    alternativeNameStarter1,
  );
  String resultStarter2 = calculateResutlAlternative(
    'Starter 2',
    listAlternativeStarter2,
    resultCriteriaWeightPriority,
    alternativeNameStarter2,
  );
  String resultStarter3 = calculateResutlAlternative(
    'Starter 3',
    listAlternativeStarter3,
    resultCriteriaWeightPriority,
    alternativeNameStarter3,
  );
  String resultGrower = calculateResutlAlternative(
    'Grower',
    listAlternativeGrower,
    resultCriteriaWeightPriority,
    alternativeNameGrower,
  );
  String resultFinisher = calculateResutlAlternative(
    'Finisher',
    listAlternativeFinisher,
    resultCriteriaWeightPriority,
    alternativeNameFinisher,
  );

  List<String> resultAhp = [
    resultStarter1,
    resultStarter2,
    resultStarter3,
    resultGrower,
    resultFinisher,
  ];

  return resultAhp;
}

Matrix calculateCountColumn(Matrix matrix) {
  // Penjumlahan Bobot Prioritas Kriteria
  List<double> resultCountColumn = [];

  for (int i = 0; i < matrix.columnCount; i++) {
    double sum = 0;
    for (int j = 0; j < matrix.rowCount; j++) {
      sum += matrix[i][j];
    }
    resultCountColumn.add(appDoubleConvert(sum));
  }
  print('Penjumlahan Bobot Prioritas Kriteria: $resultCountColumn\n');

  return Matrix.fromList([resultCountColumn]);
}

Matrix calculateNormalization(Matrix matrix) {
  // Penjumlahan Bobot Prioritas Kriteria
  List<double> resultCountPriority = [];

  for (int i = 0; i < matrix.rowCount; i++) {
    double sum = 0;
    for (int j = 0; j < matrix.columnCount; j++) {
      sum += matrix[j][i];
    }
    resultCountPriority.add(appDoubleConvert(sum));
  }
  print('Penjumlahan Bobot Prioritas Kriteria: $resultCountPriority\n');

  // Normalisasi Kriteria
  List<List<double>> listNormalization = [];
  Matrix resultNormalization;

  for (int i = 0; i < matrix.columnCount; i++) {
    List<double> temp = [];
    for (int j = 0; j < matrix.rowCount; j++) {
      temp.add(appDoubleConvert(matrix[i][j] / resultCountPriority[j]));
    }
    listNormalization.add((temp));
  }
  resultNormalization = Matrix.fromList(listNormalization);

  return resultNormalization;
}

List<double> calculateWeightPriority(Matrix matrix, Matrix matNormalization) {
  List<double> resultWeightPriority = [];
  List<double> resultAddRow = [];

  for (int i = 0; i < matrix.columnCount; i++) {
    double sum = 0;
    for (int j = 0; j < matrix.rowCount; j++) {
      sum = sum + matNormalization[i][j];
    }
    resultAddRow.add(appDoubleConvert(sum));
    resultWeightPriority.add(appDoubleConvert(sum / matrix.rowCount));
  }

  return resultWeightPriority;
}

List<double> calculateConsistencyCriteria(
  Matrix matrix,
  Matrix matNormalization,
  List<double> resultCriteriaPriority,
) {
  List<double> resultConsistencyCriteria = [];

  for (int i = 0; i < matrix.rowCount; i++) {
    double sum = 0;
    for (int j = 0; j < matrix.columnCount; j++) {
      sum += matNormalization[i][j];
    }
    resultConsistencyCriteria
        .add(appDoubleConvert(sum / resultCriteriaPriority[i]));
  }

  return resultConsistencyCriteria;
}

double calculateAverageConsistency(List<double> resultConsistency) {
  double resultAverageConsistency = 0;
  for (int i = 0; i < resultConsistency.length; i++) {
    resultAverageConsistency += resultConsistency[i];
  }
  resultAverageConsistency = appDoubleConvert(
    resultAverageConsistency / resultConsistency.length,
    fix: 4,
  );

  return resultAverageConsistency;
}

String calculateResutlAlternative(
  String name,
  List<Matrix> listAlternative,
  List<double> resultCriteriaWeightPriority,
  List<String> alternativeName,
) {
  print('------------ ALTERNATIF $name ------------\n');
  List<List<double>> listWeightPriorityAlternative = [];

  for (int i = 0; i < listAlternative.length; i++) {
    print('----- C0${i + 1} -----\n');
    Matrix resultNormalizationAlternative =
        calculateNormalization(listAlternative[i]);
    print(
        'Normalisasi Alternatif $name C0${i + 1}: $resultNormalizationAlternative');

    List<double> resultWeightPriorityAlternative = calculateWeightPriority(
      listAlternative[i],
      resultNormalizationAlternative,
    );
    print(
        'Bobot Prioritas Alternatif $name C0${i + 1}: $resultWeightPriorityAlternative\n');

    listWeightPriorityAlternative.add(resultWeightPriorityAlternative);
  }

  print('------------ PERANGKINGAN $name ------------\n');
  Matrix matAlternatives =
      Matrix.fromList(listWeightPriorityAlternative).transpose;
  print('Matriks Perangkingan Transpose: $matAlternatives');

  List<double> resultScoreRanking = [];

  for (int i = 0; i < matAlternatives.rowCount; i++) {
    double sum = 0;
    for (int j = 0; j < matAlternatives.columnCount; j++) {
      sum += appDoubleConvert(
        matAlternatives[i][j] * resultCriteriaWeightPriority[j],
      );
    }
    resultScoreRanking.add((appDoubleConvert(sum)));
  }
  print('Skor Perangkingan: $resultScoreRanking\n');

  List<ResultAlternative> resultRankingAlternatives = [];

  List.generate(resultScoreRanking.length, (index) {
    resultRankingAlternatives.add(
      ResultAlternative(
        name: alternativeName[index],
        value: resultScoreRanking[index],
      ),
    );
  });

  for (int i = 0; i < resultRankingAlternatives.length; i++) {
    print(
      'Alternatif ${resultRankingAlternatives[i].name} Skor: ${resultRankingAlternatives[i].value}',
    );
  }

  resultRankingAlternatives.sort((a, b) => b.value.compareTo(a.value));

  print(
      'Perangkingan Alternatif Terbaik: ${resultRankingAlternatives.first.name}\n');

  return resultRankingAlternatives.first.name;
}
