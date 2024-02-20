import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../core/core.dart';

part 'insert_detail_assessment_local_event.dart';
part 'insert_detail_assessment_local_state.dart';

class InsertDetailAssessmentLocalBloc extends Bloc<InsertDetailAssessmentLocalEvent, InsertDetailAssessmentLocalState> {
  final SaveAssessmentDetail saveAssessmentDetail;
  InsertDetailAssessmentLocalBloc(this.saveAssessmentDetail) : super(InsertDetailAssessmentLocalInitial()) {
    on<InsertDetailAssessmentLocal>((event, emit) async {
      final result = await saveAssessmentDetail.execute(event.assessment);
      result.fold(
        (failure) => emit(InsertDetailAssessmentLocalFailure(failure.message)),
        (id) => emit(InsertDetailAssessmentLocalSuccess(id)),
      );
    });
  }
}
