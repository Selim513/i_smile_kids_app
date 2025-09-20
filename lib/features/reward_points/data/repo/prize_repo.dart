
// import 'dart:convert';

// import 'package:flutter/services.dart';
// import 'package:i_smile_kids_app/features/reward_points/data/model/prize_model.dart';

// class PrizesRepository {
//   static const String _jsonPath = 'assets/json/prizes.json'; // path للـ prizes
//   List<Prize>? _cachedPrizes;

//   Future<List<Prize>> getAllPrizes() async {
//     if (_cachedPrizes != null) {
//       return _cachedPrizes!;
//     }
 
//     try {
//       final String jsonString = await rootBundle.loadString(_jsonPath);
//       final List<dynamic> jsonList = json.decode(jsonString);
      
//       _cachedPrizes = jsonList.map((json) => Prize.fromJson(json)).toList();
      
//       // Sort by points (ascending)
//       _cachedPrizes!.sort((a, b) => a.points.compareTo(b.points));
      
//       return _cachedPrizes!;
//     } catch (e) {
//       throw Exception('Failed to load prizes: $e');
//     }
//   }

//   Future<Prize?> getPrizeById(String id) async {
//     final prizes = await getAllPrizes();
//     try {
//       return prizes.firstWhere((prize) => prize.id == id);
//     } catch (e) {
//       return null;
//     }
//   }

//   Future<List<Prize>> getPrizesByCategory(String category) async {
//     final prizes = await getAllPrizes();
//     return prizes.where((prize) => prize.category == category).toList();
//   }

//   Future<List<Prize>> getAffordablePrizes(int userPoints) async {
//     final prizes = await getAllPrizes();
//     return prizes.where((prize) => prize.canAfford(userPoints)).toList();
//   }

//   Future<List<Prize>> getPrizesByPointRange(int minPoints, int maxPoints) async {
//     final prizes = await getAllPrizes();
//     return prizes.where((prize) => 
//         prize.points >= minPoints && prize.points <= maxPoints).toList();
//   }

//   Future<List<String>> getAllCategories() async {
//     final prizes = await getAllPrizes();
//     final categories = prizes.map((prize) => prize.category).toSet().toList();
//     return categories;
//   }

//   // Clear cache if needed
//   void clearCache() {
//     _cachedPrizes = null;
//   }
// }
// prize_repo.dart

import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:i_smile_kids_app/core/helper/firebase_helper.dart'; // <<< ADDED
import 'package:i_smile_kids_app/features/reward_points/data/model/prize_model.dart';

class PrizesRepository {
  static const String _jsonPath = 'assets/json/prizes.json';
  List<Prize>? _cachedPrizes;

  // ... (All your existing functions like getAllPrizes, getPrizeById, etc. remain the same)
  Future<List<Prize>> getAllPrizes() async {
    if (_cachedPrizes != null) {
      return _cachedPrizes!;
    }

    try {
      final String jsonString = await rootBundle.loadString(_jsonPath);
      final List<dynamic> jsonList = json.decode(jsonString);
      
      _cachedPrizes = jsonList.map((json) => Prize.fromJson(json)).toList();
      _cachedPrizes!.sort((a, b) => a.points.compareTo(b.points));
      
      return _cachedPrizes!;
    } catch (e) {
      throw Exception('Failed to load prizes: $e');
    }
  }

  Future<Prize?> getPrizeById(String id) async {
    final prizes = await getAllPrizes();
    try {
      return prizes.firstWhere((prize) => prize.id == id);
    } catch (e) {
      return null;
    }
  }

  Future<List<String>> getAllCategories() async {
    final prizes = await getAllPrizes();
    final categories = prizes.map((prize) => prize.category).toSet().toList();
    return categories;
  }
  
  void clearCache() {
    _cachedPrizes = null;
  }

  // <<< FUNCTION ADDED TO UPDATE FIRESTORE >>>
  Future<void> updateUserPoints(int newPoints) async {
    final user = FirebaseHelper.user;
    if (user == null) {
      throw Exception('User not logged in, cannot update points.');
    }

    try {
      await FirebaseHelper.firebaseFirestore
          .collection('users')
          .doc(user.uid)
          .update({'points': newPoints});
    } catch (e) {
      // Re-throw the error to be caught by the Cubit
      throw Exception('Failed to update points in Firestore: ${e.toString()}');
    }
  }
}