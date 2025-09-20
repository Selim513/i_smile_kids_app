import 'package:equatable/equatable.dart';
import 'package:i_smile_kids_app/features/reward_points/data/model/prize_model.dart';

abstract class PrizesState extends Equatable {
  const PrizesState();

  @override
  List<Object> get props => [];
}

class PrizesInitial extends PrizesState {}

class PrizesLoading extends PrizesState {}

class PrizesLoaded extends PrizesState {
  final List<Prize> prizes;
  final List<String> categories;
  final int userPoints;

  const PrizesLoaded({
    required this.prizes,
    required this.categories,
    this.userPoints = 0,
  });

  @override
  List<Object> get props => [prizes, categories, userPoints];
}

class PrizesFiltered extends PrizesState {
  final List<Prize> filteredPrizes;
  final String filterType;
  final int userPoints;

  const PrizesFiltered({
    required this.filteredPrizes,
    required this.filterType,
    this.userPoints = 0,
  });

  @override
  List<Object> get props => [filteredPrizes, filterType, userPoints];
}

class PrizesError extends PrizesState {
  final String message;

  const PrizesError(this.message);

  @override
  List<Object> get props => [message];
}

class PrizeRedeemed extends PrizesState {
  final Prize prize;
  final int remainingPoints;

  const PrizeRedeemed({
    required this.prize,
    required this.remainingPoints,
  });

  @override
  List<Object> get props => [prize, remainingPoints];
}
