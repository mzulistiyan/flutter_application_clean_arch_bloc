part of 'insert_detail_assessment_local_bloc.dart';

abstract class InsertDetailAssessmentLocalState extends Equatable {
  const InsertDetailAssessmentLocalState();

  @override
  List<Object> get props => [];
}

class InsertDetailAssessmentLocalInitial extends InsertDetailAssessmentLocalState {}

class InsertDetailAssessmentLocalLoading extends InsertDetailAssessmentLocalState {}

class InsertDetailAssessmentLocalSuccess extends InsertDetailAssessmentLocalState {
  final String message;

  const InsertDetailAssessmentLocalSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class InsertDetailAssessmentLocalFailure extends InsertDetailAssessmentLocalState {
  final String error;

  const InsertDetailAssessmentLocalFailure(this.error);

  @override
  List<Object> get props => [error];
}
