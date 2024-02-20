import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../.../../../../core/core.dart';
part 'assessment_detail_hive_bloc_event.dart';
part 'assessment_detail_hive_bloc_state.dart';

class AssessmentDetailHiveBlocBloc extends Bloc<AssessmentDetailHiveBlocEvent, AssessmentDetailHiveBlocState> {
  final GetAssessmentDetailCached getAssessmentDetailCached;
  AssessmentDetailHiveBlocBloc(this.getAssessmentDetailCached) : super(AssessmentDetailHiveBlocInitial()) {
    on<GetAssessmentDetailHive>((event, emit) async {
      emit(AssessmentDetailHiveBlocLoading());
      final result = await getAssessmentDetailCached.execute(event.id);
      result.fold(
        (failure) => emit(AssessmentDetailHiveBlocError(failure.message)),
        (assessment) => emit(AssessmentDetailHiveBlocLoaded(assessment)),
      );
    });
  }
}
