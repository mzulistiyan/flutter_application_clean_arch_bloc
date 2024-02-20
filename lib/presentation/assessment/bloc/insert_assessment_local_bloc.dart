import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../core/core.dart';
part 'insert_assessment_local_event.dart';
part 'insert_assessment_local_state.dart';

class InsertAssessmentLocalBloc extends Bloc<InsertAssessmentLocalEvent, InsertAssessmentLocalState> {
  final SaveAssessment insertListAssessment;
  InsertAssessmentLocalBloc(
    this.insertListAssessment,
  ) : super(InsertAssessmentLocalInitial()) {
    on<InsertAssessmentLocal>((event, emit) async {
      emit(InsertAssessmentLocalLoading());
      final result = await insertListAssessment.execute(event.assessment);
      result.fold(
        (failure) => emit(InsertAssessmentLocalFailure(failure.message)),
        (message) => emit(InsertAssessmentLocalSuccess(message)),
      );
    });
  }
}
