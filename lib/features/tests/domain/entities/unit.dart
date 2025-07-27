class Unit {
  final String id;
  final String title;
  final String subtitle;

  const Unit({required this.id, required this.title, required this.subtitle});

  Unit copyWith({String? id, String? title, String? subtitle}) {
    return Unit(
      id: id ?? this.id,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Unit &&
        other.id == id &&
        other.title == title &&
        other.subtitle == subtitle;
  }

  @override
  int get hashCode => id.hashCode ^ title.hashCode ^ subtitle.hashCode;

  @override
  String toString() => 'Unit(id: $id, title: $title, subtitle: $subtitle)';
}
