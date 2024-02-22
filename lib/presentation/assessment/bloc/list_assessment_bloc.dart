import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../core/core.dart';

part 'list_assessment_event.dart';
part 'list_assessment_state.dart';

class ListAssessmentBloc extends Bloc<ListAssessmentEvent, ListAssessmentState> {
  final GetListAssessment getListAssessment;
  List<Assessment> assessments = [];
  bool isLastPage = false;
  int pageNumber = 1;
  final int numberOfPostsPerRequest = 10;
  final int nextPageTrigger = 3;
  ListAssessmentBloc(this.getListAssessment) : super(ListAssessmentInitial()) {
    on<ListAssessmentLoad>(
      (event, emit) async {
        emit(ListAssessmentLoading());
        try {
          final result = await getListAssessment.execute(pageNumber);
          result.fold(
            (l) {
              emit(const ListAssessmentError('Error'));
            },
            (postList) {
              isLastPage = postList.length < numberOfPostsPerRequest;
              pageNumber = pageNumber + 1;
              assessments.addAll(postList);
              emit(ListAssessmentHasData());
            },
          );
        } catch (e) {
          emit(const ListAssessmentError('Error'));
        }
      },
    );
    on<CheckIfNeedMoreDataEvent>((event, emit) async {
      if (event.index == assessments.length - nextPageTrigger && !isLastPage) {
        add(const ListAssessmentLoad());
      }
    });
    on<ListAssessmentRefresh>((event, emit) async {
      pageNumber = 1;
      assessments = [];
      add(const ListAssessmentLoad());
    });
  }
}
