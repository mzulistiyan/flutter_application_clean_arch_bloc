import 'package:dartz/dartz.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_application_clean_arch/core/domain/usecase/get_assessment.dart';
import 'package:flutter_application_clean_arch/presentation/assessment/bloc/list_assessment_bloc.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:mocktail/mocktail.dart';

import '../../data_dummy/object_dummy.dart';

class MockGetListAssesment extends Mock implements GetListAssessment {}

void main() {
  late GetListAssessment usecase;
  late ListAssessmentBloc bloc;

  setUp(() {
    usecase = MockGetListAssesment();
    bloc = ListAssessmentBloc(usecase);
  });

  group('ListAssessmentBloc', () {
    test('initial state should be loading.', () {
      expect(bloc.state, ListAssessmentInitial());
    });

    blocTest<ListAssessmentBloc, ListAssessmentState>(
      'emits [Loading, HasData] when ListAssessmentBloc is added.',
      build: () {
        when(() => usecase.execute(1)).thenAnswer((invocation) async => Right([listAssessmentModel]));
        return bloc;
      },
      act: (bloc) => bloc.add(ListAssessmentLoad()),
      expect: () => <ListAssessmentState>[
        ListAssessmentLoading(),
        ListAssessmentHasData(),
      ],
      verify: (bloc) => verify(() => usecase.execute(1)),
    );
  });
}
