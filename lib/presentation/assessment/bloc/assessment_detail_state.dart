part of 'assessment_detail_bloc.dart';

abstract class AssessmentDetailState extends Equatable {
  const AssessmentDetailState();

  @override
  List<Object> get props => [];
}

class AssessmentDetailInitial extends AssessmentDetailState {}

class AssessmentDetailEmpty extends AssessmentDetailState {}

class AssessmentDetailLoading extends AssessmentDetailState {}

class AssessmentDetailError extends AssessmentDetailState {
  final String message;
  const AssessmentDetailError(this.message);

  @override
  List<Object> get props => [message];
}

class AssessmentDetailHasData extends AssessmentDetailState {
  final AssessmentDetail result;
  const AssessmentDetailHasData(this.result);

  @override
  List<Object> get props => [result];
}
