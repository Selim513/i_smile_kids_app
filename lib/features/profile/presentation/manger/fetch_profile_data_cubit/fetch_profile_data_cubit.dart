import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_smile_kids_app/core/models/user_models.dart';
import 'package:i_smile_kids_app/features/profile/data/repo/profile_repo_impl.dart';
import 'package:i_smile_kids_app/features/profile/presentation/manger/fetch_profile_data_cubit/fetch_profile_data_state.dart';

class FetchProfileDataCubit extends Cubit<FetchProfileDataCubitState> {
  final ProfileRepoImpl repo;
  FetchProfileDataCubit(this.repo) : super(FetchProfileDataInitial()) {
    // optional: initialize controllers here if you want
  }

  // controllers inside the cubit
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  // final TextEditingController nationalityController = TextEditingController();
  // final TextEditingController emirateController = TextEditingController();

  UserModel? currentUser;

  Future<void> fetchProfileData({required String userId}) async {
    emit(FetchProfileDataLoading());
    try {
      currentUser = null;
      _clearControllers();

      final UserModel? user = await repo.fetchUserData(userId: userId);
      if (user != null) {
        currentUser = user;
        // Populate controllers with new data
        nameController.text = user.name;
        ageController.text = user.age;

        emit(FetchProfileDataSuccess(userData: user));
      } else {
        emit(FetchProfileDataFailure(errMessage: "User not found"));
      }
    } catch (e) {
      emit(
        FetchProfileDataFailure(
          errMessage: "Failed to load profile: ${e.toString()}",
        ),
      );
    }
  }

  // ====== UPDATE PROFILE ======
  Future<void> updateProfileData() async {
    emit(UpdateProfileLoading());
    try {
      final updatedUser = UserModel(
        uid: currentUser!.uid,
        name: nameController.text.isNotEmpty
            ? nameController.text
            : currentUser!.name,
        email: currentUser!.email,
        totalBrushing: currentUser!.totalBrushing,
        // nationality: nationalityController.text.isNotEmpty
        //     ? nationalityController.text
        //     : currentUser!.nationality,
        // emirateOfResidency: emirateController.text.isNotEmpty
        //     ? emirateController.text
        //     : currentUser!.emirateOfResidency,
        age: ageController.text.isNotEmpty
            ? ageController.text
            : currentUser!.age,
        createdAt: currentUser!.createdAt,
        updatedAt: currentUser!.updatedAt,
      );

      await repo.profileSaveChanges(user: updatedUser);
      await fetchProfileData(userId:currentUser!.uid );
      emit(UpdateProfileSuccess(userData: updatedUser));
    } catch (e) {
      emit(UpdateProfileFailure(errMessage: e.toString()));
    }
  }

  void _clearControllers() {
    nameController.clear();
    ageController.clear();
  }

  // Add method to reset cubit state
  void resetState() {
    currentUser = null;
    _clearControllers();
    emit(FetchProfileDataInitial());
  }

  @override
  Future<void> close() {
    nameController.dispose();
    ageController.dispose();
    return super.close();
  }
}
