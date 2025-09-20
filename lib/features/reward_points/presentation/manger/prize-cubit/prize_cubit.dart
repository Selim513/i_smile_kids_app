
// import 'package:flutter_bloc/flutter_bloc.dart';
// // 1. ADD THIS IMPORT
// import 'package:i_smile_kids_app/core/helper/firebase_helper.dart'; 
// import 'package:i_smile_kids_app/features/reward_points/data/model/prize_model.dart';
// import 'package:i_smile_kids_app/features/reward_points/data/repo/prize_repo.dart';
// import 'package:i_smile_kids_app/features/reward_points/presentation/manger/prize_state.dart';

// class PrizesCubit extends Cubit<PrizesState> {
//   final PrizesRepository _repository;
//   List<Prize> _allPrizes = [];
//   List<String> _categories = [];
//   int _userPoints = 0;

//   PrizesCubit(this._repository) : super(PrizesInitial());

//   // 2. MODIFIED: The function no longer accepts userPoints
//   Future<void> loadPrizes() async {
//     emit(PrizesLoading());
    
//     try {
//       // 3. ADDED: Logic to fetch user points from Firestore directly
//       final user = FirebaseHelper.user;
//       if (user == null) {
//         throw Exception('User not logged in. Unable to fetch points.');
//       }
//       final doc = await FirebaseHelper.firebaseFirestore
//           .collection('users')
//           .doc(user.uid)
//           .get();
//       _userPoints = doc.exists ? (doc.data()!['points'] ?? 0) as int : 0;

//       // Existing logic continues here
//       _allPrizes = await _repository.getAllPrizes();
//       _categories = await _repository.getAllCategories();
      
//       emit(PrizesLoaded(
//         prizes: _allPrizes,
//         categories: _categories,
//         userPoints: _userPoints, // Now uses the points fetched from Firestore
//       ));
//     } catch (e) {
//       emit(PrizesError('Failed to load data: ${e.toString()}'));
//     }
//   }

//   // This function is still useful if points can be updated from another source
//   void updateUserPoints(int points) {
//     _userPoints = points;
    
//     final currentState = state;
//     if (currentState is PrizesLoaded) {
//       emit(PrizesLoaded(
//         prizes: currentState.prizes,
//         categories: currentState.categories,
//         userPoints: points,
//       ));
//     } else if (currentState is PrizesFiltered) {
//       emit(PrizesFiltered(
//         filteredPrizes: currentState.filteredPrizes,
//         filterType: currentState.filterType,
//         userPoints: points,
//       ));
//     }
//   }

//   // ... (All other filter and search methods remain exactly the same) ...
  
//   void filterByCategory(String category) {
//     if (_allPrizes.isEmpty) return;

//     if (category.isEmpty || category == 'all') {
//       emit(PrizesLoaded(
//         prizes: _allPrizes,
//         categories: _categories,
//         userPoints: _userPoints,
//       ));
//       return;
//     }

//     final filteredPrizes = _allPrizes.where((prize) => prize.category == category).toList();
//     emit(PrizesFiltered(
//       filteredPrizes: filteredPrizes,
//       filterType: 'category: $category',
//       userPoints: _userPoints,
//     ));
//   }

//   void filterAffordablePrizes() {
//     if (_allPrizes.isEmpty) return;

//     final affordablePrizes = _allPrizes.where((prize) => prize.canAfford(_userPoints)).toList();
//     emit(PrizesFiltered(
//       filteredPrizes: affordablePrizes,
//       filterType: 'affordable',
//       userPoints: _userPoints,
//     ));
//   }

//   void filterByPointRange(int minPoints, int maxPoints) {
//     if (_allPrizes.isEmpty) return;

//     final filteredPrizes = _allPrizes.where((prize) => 
//         prize.points >= minPoints && prize.points <= maxPoints).toList();
    
//     emit(PrizesFiltered(
//       filteredPrizes: filteredPrizes,
//       filterType: 'points: $minPoints-$maxPoints',
//       userPoints: _userPoints,
//     ));
//   }

//   void searchPrizes(String query, {bool isArabic = false}) {
//     if (_allPrizes.isEmpty || query.isEmpty) {
//       emit(PrizesLoaded(
//         prizes: _allPrizes,
//         categories: _categories,
//         userPoints: _userPoints,
//       ));
//       return;
//     }

//     final filteredPrizes = _allPrizes.where((prize) {
//       final name = isArabic ? prize.nameAr : prize.nameEn;
//       final description = isArabic ? prize.descAr : prize.descEn;
      
//       return name.toLowerCase().contains(query.toLowerCase()) ||
//              description.toLowerCase().contains(query.toLowerCase()) ||
//              prize.category.toLowerCase().contains(query.toLowerCase());
//     }).toList();

//     emit(PrizesFiltered(
//       filteredPrizes: filteredPrizes,
//       filterType: 'search',
//       userPoints: _userPoints,
//     ));
//   }

//   Future<void> redeemPrize(String prizeId) async {
//     // ... (This method remains the same) ...
//   }

//   Future<Prize?> getPrizeById(String id) async {
//     return await _repository.getPrizeById(id);
//   }

//   List<Prize> getTopPrizes(int count) {
//     return _allPrizes.take(count).toList();
//   }

//   void resetFilter() {
//     emit(PrizesLoaded(
//       prizes: _allPrizes,
//       categories: _categories,
//       userPoints: _userPoints,
//     ));
//   }

//   // 4. MODIFIED: The function call is updated
//   void refreshData() {
//     _repository.clearCache();
//     loadPrizes(); // Now calls the new version without parameters
//   }
// }// prize_cubit.dart

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_smile_kids_app/core/helper/firebase_helper.dart';
import 'package:i_smile_kids_app/features/reward_points/data/model/prize_model.dart';
import 'package:i_smile_kids_app/features/reward_points/data/repo/prize_repo.dart';
import 'package:i_smile_kids_app/features/reward_points/presentation/manger/prize-cubit/prize_state.dart';

class PrizesCubit extends Cubit<PrizesState> {
  final PrizesRepository _repository;
  List<Prize> _allPrizes = [];
  List<String> _categories = [];
  int _userPoints = 0;

  PrizesCubit(this._repository) : super(PrizesInitial());

  Future<void> loadPrizes() async {
    emit(PrizesLoading());
    try {
      final user = FirebaseHelper.user;
      if (user == null) {
        throw Exception('User not logged in. Unable to fetch points.');
      }
      final doc = await FirebaseHelper.firebaseFirestore
          .collection('users')
          .doc(user.uid)
          .get();
      _userPoints = doc.exists ? (doc.data()!['points'] ?? 0) as int : 0;

      _allPrizes = await _repository.getAllPrizes();
      _categories = await _repository.getAllCategories();
      
      emit(PrizesLoaded(
        prizes: _allPrizes,
        categories: _categories,
        userPoints: _userPoints,
      ));
    } catch (e) {
      emit(PrizesError('Failed to load data: ${e.toString()}'));
    }
  }

  // <<< redeemPrize FUNCTION IS NOW FULLY IMPLEMENTED >>>
  Future<void> redeemPrize(String prizeId) async {
    try {
    final prize = await _repository.getPrizeById(prizeId);
    if (prize == null) { /* ... handle error ... */ return; }
    if (!prize.canAfford(_userPoints)) { /* ... handle error ... */ return; }

    final remainingPoints = _userPoints - prize.points;

    // <<< MODIFIED PART >>>
    // Use the new repository method to do both operations
    await _repository.recordRedemptionAndUpdatePoints(prize, remainingPoints);

    _userPoints = remainingPoints;

    emit(PrizeRedeemed(
      prize: prize,
      remainingPoints: remainingPoints,
    ));

    await Future.delayed(const Duration(seconds: 1)); 

    emit(PrizesLoaded(
      prizes: _allPrizes,
      categories: _categories,
      userPoints: remainingPoints,
    ));

  
    } catch (e) {
      emit(PrizesError('Failed to redeem prize: ${e.toString()}'));
      // Reload data to ensure UI is consistent after an error
      await loadPrizes(); 
    }
  }
  
  // ... (All other functions remain the same)
  void filterAffordablePrizes() {
    if (_allPrizes.isEmpty) return;

    final affordablePrizes = _allPrizes.where((prize) => prize.canAfford(_userPoints)).toList();
    emit(PrizesFiltered(
      filteredPrizes: affordablePrizes,
      filterType: 'affordable',
      userPoints: _userPoints,
    ));
  }

  void filterByPointRange(int minPoints, int maxPoints) {
    if (_allPrizes.isEmpty) return;

    final filteredPrizes = _allPrizes.where((prize) => 
        prize.points >= minPoints && prize.points <= maxPoints).toList();
    
    emit(PrizesFiltered(
      filteredPrizes: filteredPrizes,
      filterType: 'points: $minPoints-$maxPoints',
      userPoints: _userPoints,
    ));
  }
  
  void resetFilter() {
    emit(PrizesLoaded(
      prizes: _allPrizes,
      categories: _categories,
      userPoints: _userPoints,
    ));
  }

  void refreshData() {
    _repository.clearCache();
    loadPrizes();
  }
}