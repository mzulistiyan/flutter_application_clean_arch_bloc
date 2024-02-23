part of 'list_assessment_bloc.dart';

abstract class ListAssessmentEvent extends Equatable {
  const ListAssessmentEvent();

  @override
  List<Object> get props => [];
}

class ListAssessmentLoad extends ListAssessmentEvent {}

class CheckIfNeedMoreDataEvent extends ListAssessmentEvent {
  final int index;
  const CheckIfNeedMoreDataEvent({required this.index});

  @override
  List<Object> get props => [index];
}

class ListAssessmentRefresh extends ListAssessmentEvent {}
