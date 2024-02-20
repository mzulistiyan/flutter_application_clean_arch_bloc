part of 'insert_assessment_local_bloc.dart';

abstract class InsertAssessmentLocalState extends Equatable {
  const InsertAssessmentLocalState();

  @override
  List<Object> get props => [];
}

class InsertAssessmentLocalInitial extends InsertAssessmentLocalState {}

class InsertAssessmentLocalLoading extends InsertAssessmentLocalState {}

class InsertAssessmentLocalSuccess extends InsertAssessmentLocalState {
  final String message;

  InsertAssessmentLocalSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class InsertAssessmentLocalFailure extends InsertAssessmentLocalState {
  final String error;

  InsertAssessmentLocalFailure(this.error);

  @override
  List<Object> get props => [error];
}
