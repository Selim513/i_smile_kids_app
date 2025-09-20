import 'package:equatable/equatable.dart';
import 'package:i_smile_kids_app/features/reward_points/data/model/redeemed_prize_model.dart';

abstract class MyPrizesState extends Equatable {
  const MyPrizesState();
  @override
  List<Object> get props => [];
}

class MyPrizesInitial extends MyPrizesState {}
class MyPrizesLoading extends MyPrizesState {}
class MyPrizesLoaded extends MyPrizesState {
  final List<RedeemedPrizeModel> prizes;
  const MyPrizesLoaded(this.prizes);
  @override
  List<Object> get props => [prizes];
}
class MyPrizesError extends MyPrizesState {
  final String message;
  const MyPrizesError(this.message);
  @override
  List<Object> get props => [message];
}