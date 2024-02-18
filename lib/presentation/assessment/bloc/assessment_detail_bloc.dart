import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../core/core.dart';

part 'assessment_detail_event.dart';
part 'assessment_detail_state.dart';

class AssessmentDetailBloc extends Bloc<AssessmentDetailEvent, AssessmentDetailState> {
  final GetAssessmentDetail getAssessmentDetail;
  AssessmentDetailBloc(this.getAssessmentDetail) : super(AssessmentDetailInitial()) {
    on<FecthAssessmentDetail>(
      (event, emit) async {
        emit(AssessmentDetailLoading());

        final result = await getAssessmentDetail.execute(event.id);
        result.fold(
          (failure) {
            emit(AssessmentDetailError(failure.message));
          },
          (data) {
            emit(AssessmentDetailHasData(data));
          },
        );
      },
    );
  }
}
