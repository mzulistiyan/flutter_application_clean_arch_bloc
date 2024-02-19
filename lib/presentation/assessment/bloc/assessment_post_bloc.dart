import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '/core/core.dart';

part 'assessment_post_event.dart';
part 'assessment_post_state.dart';

class AssessmentPostBloc extends Bloc<AssessmentPostEvent, AssessmentPostState> {
  final PostAssessment postAssessment;
  AssessmentPostBloc(this.postAssessment) : super(AssessmentPostInitial()) {
    on<PostAssessmentAnswer>((event, emit) async {
      emit(AssessmentPostLoading());

      final result = await postAssessment.execute(bodyReqAssesment: event.bodyReqAssesment);
      result.fold(
        (failure) {
          emit(AssessmentPostFailure(message: failure.message));
        },
        (data) {
          emit(AssessmentPostSuccess(message: data));
        },
      );
    });
  }
}
