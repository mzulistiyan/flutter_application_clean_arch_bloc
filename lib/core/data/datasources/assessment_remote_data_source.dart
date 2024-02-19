import '../../../common/common.dart';
import '../../core.dart';

abstract class AssessmentRemoteDataSource {
  Future<List<AssessmentModel>> getAssessment();
  Future<AssessmentDetailResponse> getAssessmentDetail(String id);
  Future<String> postAssessment({required BodyReqAssesment bodyReqAssesment});
}

class AssessmentRemoteDataSourceImpl implements AssessmentRemoteDataSource {
  final DioClient dioClient;
  final SecureStorageClient secureStorageClient;

  AssessmentRemoteDataSourceImpl({required this.dioClient, required this.secureStorageClient});

  @override
  Future<List<AssessmentModel>> getAssessment() async {
    final response = await dioClient.get(
      url: UrlConstant.assessment,
      queryParams: {
        'page': 1,
        'limit': 10,
      },
    );

    if (response.statusCode == 200) {
      return AssessmentResponse.fromJson(response.data).data ?? [];
    } else {
      throw ServerException();
    }
  }

  @override
  Future<AssessmentDetailResponse> getAssessmentDetail(String id) async {
    final response = await dioClient.get(
      url: '${UrlConstant.assessmentDetail}/$id',
    );

    if (response.statusCode == 200) {
      return AssessmentDetailResponse.fromJson(response.data['data']);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<String> postAssessment({required BodyReqAssesment bodyReqAssesment}) async {
    final response = await dioClient.post(
      url: UrlConstant.assessmentPost,
      data: bodyReqAssesment.toJson(),
    );

    if (response.statusCode == 400) {
      return response.statusMessage ?? '';
    } else {
      throw ServerException();
    }
  }
}
