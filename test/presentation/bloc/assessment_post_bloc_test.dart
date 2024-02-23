import 'package:dartz/dartz.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_application_clean_arch/core/domain/usecase/post_assessment.dart';
import 'package:flutter_application_clean_arch/presentation/presentation.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:mocktail/mocktail.dart';

import '../../data_dummy/object_dummy.dart';

class MockPostAssesment extends Mock implements PostAssessment {}

void main() {
  late PostAssessment usecase;
  late AssessmentPostBloc bloc;

  setUp(() {
    usecase = MockPostAssesment();
    bloc = AssessmentPostBloc(usecase);
  });

  group('ListAssessmentBloc', () {
    test('initial state should be loading.', () {
      expect(bloc.state, AssessmentPostInitial());
    });

    blocTest<AssessmentPostBloc, AssessmentPostState>(
      'emits [Loading, HasData] when ListAssessmentBloc is added.',
      build: () {
        when(() => usecase.execute(bodyReqAssesment: bodyReqAssessment)).thenAnswer((invocation) async => const Right('Berhasil, Tapi Status Code: BadState'));
        return bloc;
      },
      act: (bloc) => bloc.add(PostAssessmentAnswer(bodyReqAssesment: bodyReqAssessment)),
      expect: () => <AssessmentPostState>[
        AssessmentPostLoading(),
        const AssessmentPostSuccess(message: 'Berhasil, Tapi Status Code: BadState'),
      ],
      verify: (bloc) => verify(() => usecase.execute(bodyReqAssesment: bodyReqAssessment)),
    );
  });
}
