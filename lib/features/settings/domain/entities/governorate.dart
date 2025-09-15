import 'package:equatable/equatable.dart';

class Governorate extends Equatable {
  final int id;
  final String title;

  const Governorate({required this.id, required this.title});

  Governorate copyWith({int? id, String? title}) {
    return Governorate(id: id ?? this.id, title: title ?? this.title);
  }

  factory Governorate.initial() {
    return const Governorate(id: 0, title: '');
  }

  @override
  List<Object?> get props => [id, title];
}
