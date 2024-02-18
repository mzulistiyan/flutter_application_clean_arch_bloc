import 'package:equatable/equatable.dart';
import '../../core.dart';

class AssessmentDetail extends Equatable {
  final String? id;
  final String? name;
  final List<Question>? question;

  const AssessmentDetail({
    this.id,
    this.name,
    this.question,
  });

  @override
  List<Object?> get props => [id, name, question];
}
