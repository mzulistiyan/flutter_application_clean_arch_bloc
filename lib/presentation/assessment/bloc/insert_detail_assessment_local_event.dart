part of 'insert_detail_assessment_local_bloc.dart';

abstract class InsertDetailAssessmentLocalEvent extends Equatable {
  const InsertDetailAssessmentLocalEvent();

  @override
  List<Object> get props => [];
}

class InsertDetailAssessmentLocal extends InsertDetailAssessmentLocalEvent {
  final AssessmentDetailResponseHive assessment;

  const InsertDetailAssessmentLocal(
    this.assessment,
  );

  @override
  List<Object> get props => [assessment];
}
