import 'package:equatable/equatable.dart';
import '../../core.dart';

class Question extends Equatable {
  final String? questionid;
  final String? section;
  final String? number;
  final String? type;
  final String? questionName;
  final bool? scoring;
  final List<Option>? options;

  const Question({
    this.questionid,
    this.section,
    this.number,
    this.type,
    this.questionName,
    this.scoring,
    this.options,
  });

  @override
  List<Object?> get props => [questionid, section, number, type, questionName, scoring, options];
}
