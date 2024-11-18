class StepperModel {
  final String title;
  final String subTitle;
  final bool isCompleted;
  final bool isFirst;
  final bool isLast;

  StepperModel({
    required this.title,
    required this.subTitle,
    required this.isCompleted,
    this.isFirst = false,
    this.isLast = false,
  });
}
