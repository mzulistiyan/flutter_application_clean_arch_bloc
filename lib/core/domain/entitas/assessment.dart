import 'package:equatable/equatable.dart';

class Assessment extends Equatable {
  final String? id;
  final String? name;
  final DateTime? assessmentDate;
  final String? description;
  final String? type;
  final DateTime? createdAt;

  const Assessment({
    this.id,
    this.name,
    this.assessmentDate,
    this.description,
    this.type,
    this.createdAt,
  });

  @override
  List<Object?> get props => [id, name, assessmentDate, description, type, createdAt];
}
