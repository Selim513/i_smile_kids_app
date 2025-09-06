import 'package:i_smile_kids_app/features/dental_care_tips/data/data_source/dental_care_tips_remote_data_source.dart';
import 'package:i_smile_kids_app/features/dental_care_tips/data/models/dental_care_tips_model/dental_care_tips_model.dart';
import 'package:i_smile_kids_app/features/dental_care_tips/data/repo/dental_care_tips_repo.dart';

class DentalCareTipsRepoImpl extends DentalCareTipsRepo {
  final DentalCareTipsRemoteDataSource repo;

  DentalCareTipsRepoImpl(this.repo);

  @override
  Future<List<DentalCareTipsModel>> fetchDentalCareTips() async {
    return repo.fetchDentalCareTips();
  }
}
