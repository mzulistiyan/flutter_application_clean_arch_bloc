import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../core/core.dart';

part 'list_assessment_event.dart';
part 'list_assessment_state.dart';

class ListAssessmentBloc extends Bloc<ListAssessmentEvent, ListAssessmentState> {
  final GetListAssessment getListAssessment;
  ListAssessmentBloc(this.getListAssessment) : super(ListAssessmentInitial()) {
    on<ListAssessmentLoad>(
      (event, emit) async {
        emit(ListAssessmentLoading());
        final result = await getListAssessment.execute();
        result.fold(
          (failure) => emit(ListAssessmentError(failure.message)),
          (data) {
            if (data.isEmpty) {
              emit(ListAssessmentEmpty());
            } else {
              emit(ListAssessmentHasData(data));
            }
          },
        );
      },
    );
  }
}
