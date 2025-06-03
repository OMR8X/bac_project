class CustomNavigationCardData {
  final String title;
  final String subtitle;

  CustomNavigationCardData({required this.title, required this.subtitle});

  factory CustomNavigationCardData.fromJson(Map<String, dynamic> json) {
    return CustomNavigationCardData(
      title: json['title'],
      subtitle: json['subtitle'],
    );
  }
}
