part of 'assessment_detail_hive_bloc_bloc.dart';

abstract class AssessmentDetailHiveBlocState extends Equatable {
  const AssessmentDetailHiveBlocState();

  @override
  List<Object> get props => [];
}

class AssessmentDetailHiveBlocInitial extends AssessmentDetailHiveBlocState {}

class AssessmentDetailHiveBlocLoading extends AssessmentDetailHiveBlocState {}

class AssessmentDetailHiveBlocLoaded extends AssessmentDetailHiveBlocState {
  final AssessmentDetailResponseHive assessmentDetail;

  const AssessmentDetailHiveBlocLoaded(
    this.assessmentDetail,
  );

  @override
  List<Object> get props => [assessmentDetail];
}

class AssessmentDetailHiveBlocError extends AssessmentDetailHiveBlocState {
  final String message;

  const AssessmentDetailHiveBlocError(
    this.message,
  );

  @override
  List<Object> get props => [message];
}
