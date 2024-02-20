part of 'assessment_detail_hive_bloc_bloc.dart';

abstract class AssessmentDetailHiveBlocEvent extends Equatable {
  const AssessmentDetailHiveBlocEvent();

  @override
  List<Object> get props => [];
}

class GetAssessmentDetailHive extends AssessmentDetailHiveBlocEvent {
  final String id;

  const GetAssessmentDetailHive(
    this.id,
  );

  @override
  List<Object> get props => [id];
}
