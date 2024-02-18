part of 'list_assessment_bloc.dart';

abstract class ListAssessmentEvent extends Equatable {
  const ListAssessmentEvent();

  @override
  List<Object> get props => [];
}

class ListAssessmentLoad extends ListAssessmentEvent {}
