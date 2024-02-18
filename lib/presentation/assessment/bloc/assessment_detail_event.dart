part of 'assessment_detail_bloc.dart';

abstract class AssessmentDetailEvent extends Equatable {
  const AssessmentDetailEvent();

  @override
  List<Object> get props => [];
}

class FecthAssessmentDetail extends AssessmentDetailEvent {
  final String id;

  const FecthAssessmentDetail({required this.id});

  @override
  List<Object> get props => [id];
}
