part of 'insert_assessment_local_bloc.dart';

abstract class InsertAssessmentLocalEvent extends Equatable {
  const InsertAssessmentLocalEvent();

  @override
  List<Object> get props => [];
}

class InsertAssessmentLocal extends InsertAssessmentLocalEvent {
  final AssessmentHiveModel assessment;

  InsertAssessmentLocal(this.assessment);

  @override
  List<Object> get props => [assessment];
}
