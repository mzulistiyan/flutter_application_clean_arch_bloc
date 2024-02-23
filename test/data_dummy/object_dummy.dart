import 'package:flutter_application_clean_arch/core/core.dart';

final listAssessmentModel = Assessment(
  id: '4l3bjupuwj',
  name: 'Challenge SYN',
  assessmentDate: DateTime.now(),
  description: 'testDesc',
  type: 'Type Test',
  createdAt: DateTime.now(),
  downloadedAt: DateTime.now(),
);

const assessmentDetail = AssessmentDetail(
  id: '4l3bjupuwj',
  name: 'Challenge SYN',
  question: [
    Question(
      questionid: "njqzanoypy",
      section: "Section 1 contoh",
      number: "1",
      type: "multiple_choice",
      questionName: "question_name",
      scoring: false,
      options: [
        Option(
          optionid: "2birnjmixc",
          optionName: "Opsi 1",
          points: 1,
          flag: 0,
        ),
      ],
    )
  ],
);

final bodyReqAssessment = BodyReqAssesment(
  assessmentId: '4l3bjupuwj',
  answers: [
    Answer(
      questionId: 'voiev0wjsn',
      answer: 'txjjoi4rf5',
    ),
  ],
);
