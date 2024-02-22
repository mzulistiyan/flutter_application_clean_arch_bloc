part of 'list_assessment_bloc.dart';

abstract class ListAssessmentState extends Equatable {
  const ListAssessmentState();

  @override
  List<Object> get props => [];
}

class ListAssessmentInitial extends ListAssessmentState {}

class ListAssessmentEmpty extends ListAssessmentState {}

class ListAssessmentLoading extends ListAssessmentState {}

class ListAssessmentError extends ListAssessmentState {
  final String message;
  const ListAssessmentError(this.message);

  @override
  List<Object> get props => [message];
}

class ListAssessmentHasData extends ListAssessmentState {}
