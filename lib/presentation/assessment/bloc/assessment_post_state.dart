part of 'assessment_post_bloc.dart';

abstract class AssessmentPostState extends Equatable {
  const AssessmentPostState();

  @override
  List<Object> get props => [];
}

class AssessmentPostInitial extends AssessmentPostState {}

class AssessmentPostLoading extends AssessmentPostState {}

class AssessmentPostSuccess extends AssessmentPostState {
  final String message;

  const AssessmentPostSuccess({required this.message});

  @override
  List<Object> get props => [message];
}

class AssessmentPostFailure extends AssessmentPostState {
  final String message;

  const AssessmentPostFailure({required this.message});

  @override
  List<Object> get props => [message];
}
