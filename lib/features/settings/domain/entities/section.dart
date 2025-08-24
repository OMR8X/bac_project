import 'package:equatable/equatable.dart';

class Section extends Equatable {
  final String id;
  final String name;

  const Section({required this.id, required this.name});

  Section copyWith({String? id, String? name}) {
    return Section(id: id ?? this.id, name: name ?? this.name);
  }

  @override
  List<Object?> get props => [id, name];
}
