import 'package:equatable/equatable.dart';

class Section extends Equatable {
  final int id;
  final String title;

  const Section({required this.id, required this.title});

  Section copyWith({int? id, String? title}) {
    return Section(id: id ?? this.id, title: title ?? this.title);
  }

  @override
  List<Object?> get props => [id, title];
}
