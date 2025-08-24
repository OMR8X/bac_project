import 'package:equatable/equatable.dart';

class Governorate extends Equatable {
  final String id;
  final String name;

  const Governorate({required this.id, required this.name});

  Governorate copyWith({String? id, String? name}) {
    return Governorate(id: id ?? this.id, name: name ?? this.name);
  }

  Governorate empty() {
    return Governorate(id: '', name: '');
  }

  @override
  List<Object?> get props => [id, name];
}
