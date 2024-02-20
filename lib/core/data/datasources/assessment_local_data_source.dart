import 'package:hive/hive.dart';

import '../../core.dart';

abstract class AssessmentLocalDataSource {
  Future<String> insertAssessment(AssessmentHiveModel movie);
  //get data return list of AssessmentHiveModel
  Future<List<AssessmentHiveModel>> getAssessmentCached();
  Future<AssessmentDetailResponseHive> getAssessmentDetailCached(String id);
  Future<String> insertAssessmentDail(AssessmentDetailResponseHive assessmentDetail);
}

class AssessmentLocalDataSourceImpl implements AssessmentLocalDataSource {
  AssessmentLocalDataSourceImpl();

  @override
  Future<String> insertAssessment(AssessmentHiveModel assessment) async {
    //open box
    Box<AssessmentHiveModel> assessmentBox = Hive.box<AssessmentHiveModel>('assessments');
    //check if box is already exist
    if (assessmentBox.containsKey(assessment.id)) {
      //remove data from box
      assessmentBox.delete(assessment.id);
      //put New data to box
      await assessmentBox.put(assessment.id, assessment);
      return 'Success';
    } else {
      //put New data to box
      await assessmentBox.put(assessment.id, assessment);
      return 'Success';
    }
  }

  @override
  Future<List<AssessmentHiveModel>> getAssessmentCached() async {
    //open box
    Box<AssessmentHiveModel> assessmentBox = Hive.box<AssessmentHiveModel>('assessments');
    //check if box is empty
    if (assessmentBox.isEmpty) {
      return [];
    } else {
      //get all data from box as list
      return assessmentBox.values.toList();
    }
  }

  @override
  Future<AssessmentDetailResponseHive> getAssessmentDetailCached(String id) async {
    //open box
    Box<AssessmentDetailResponseHive> assessmentBox = Hive.box<AssessmentDetailResponseHive>('assessmentDetail');
    //get data
    return assessmentBox.get(id) ?? const AssessmentDetailResponseHive();
  }

  @override
  Future<String> insertAssessmentDail(AssessmentDetailResponseHive assessmentDetail) async {
    //open box
    Box<AssessmentDetailResponseHive> assessmentBox = Hive.box<AssessmentDetailResponseHive>('assessmentDetail');
    //check if box is already exist
    if (assessmentBox.containsKey(assessmentDetail.id)) {
      //remove data from box
      assessmentBox.delete(assessmentDetail.id);
      //put New data to box
      await assessmentBox.put(assessmentDetail.id, assessmentDetail);
      return 'Success';
    } else {
      //put New data to box
      await assessmentBox.put(assessmentDetail.id, assessmentDetail);
      return 'Success';
    }
  }
}
