part of 'assessment_post_bloc.dart';

abstract class AssessmentPostEvent extends Equatable {
  const AssessmentPostEvent();

  @override
  List<Object> get props => [];
}

class PostAssessmentAnswer extends AssessmentPostEvent {
  final BodyReqAssesment bodyReqAssesment;

  const PostAssessmentAnswer({required this.bodyReqAssesment});

  @override
  List<Object> get props => [bodyReqAssesment];
}
