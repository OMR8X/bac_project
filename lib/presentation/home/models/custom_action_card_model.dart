class CustomCardData {
  final String title;
  final String subtitle;
  final String firstButtonText;
  final String secondButtonText;

  CustomCardData({
    required this.title,
    required this.subtitle,
    required this.firstButtonText,
    required this.secondButtonText,
  });

  factory CustomCardData.fromJson(Map<String, dynamic> json) {
    return CustomCardData(
      title: json['title'],
      subtitle: json['subtitle'],
      firstButtonText: json['firstButtonText'],
      secondButtonText: json['secondButtonText'],
    );
  }

  static CustomCardData mock() {
    return CustomCardData(
      title: 'Title',
      subtitle: 'Subtitle',
      firstButtonText: 'First Button Text',
      secondButtonText: 'Second Button Text',
    );
  }
}
