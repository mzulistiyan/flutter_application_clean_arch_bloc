import 'package:dartz/dartz.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_application_clean_arch/core/domain/usecase/get_assessment_detail.dart';
import 'package:flutter_application_clean_arch/presentation/presentation.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:mocktail/mocktail.dart';

import '../../data_dummy/object_dummy.dart';

class MockGeDetailAssesment extends Mock implements GetAssessmentDetail {}

void main() {
  late GetAssessmentDetail usecase;
  late AssessmentDetailBloc bloc;

  setUp(() {
    usecase = MockGeDetailAssesment();
    bloc = AssessmentDetailBloc(usecase);
  });

  group('ListAssessmentBloc', () {
    test('initial state should be loading.', () {
      expect(bloc.state, AssessmentDetailInitial());
    });

    blocTest<AssessmentDetailBloc, AssessmentDetailState>(
      'emits [Loading, HasData] when ListAssessmentBloc is added.',
      build: () {
        when(() => usecase.execute('4l3bjupuwj')).thenAnswer((invocation) async => const Right(assessmentDetail));
        return bloc;
      },
      act: (bloc) => bloc.add(const FecthAssessmentDetail(id: '4l3bjupuwj')),
      expect: () => <AssessmentDetailState>[
        AssessmentDetailLoading(),
        const AssessmentDetailHasData(assessmentDetail),
      ],
      verify: (bloc) => verify(() => usecase.execute('4l3bjupuwj')),
    );
  });
}
