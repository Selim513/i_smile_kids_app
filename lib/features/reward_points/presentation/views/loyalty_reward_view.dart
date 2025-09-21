
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:i_smile_kids_app/core/utils/color_manger.dart';
import 'package:i_smile_kids_app/core/utils/fonts_manger.dart';
import 'package:i_smile_kids_app/core/widgets/custom_primary_appbar.dart';
import 'package:i_smile_kids_app/core/widgets/custom_snack_bar.dart';
import 'package:i_smile_kids_app/features/reward_points/data/model/prize_model.dart';
import 'package:i_smile_kids_app/features/reward_points/data/repo/prize_repo.dart';
import 'package:i_smile_kids_app/features/reward_points/presentation/manger/prize-cubit/prize_cubit.dart';
import 'package:i_smile_kids_app/features/reward_points/presentation/manger/prize-cubit/prize_state.dart';
import 'package:i_smile_kids_app/features/reward_points/presentation/views/my_reward.dart';
import 'package:i_smile_kids_app/features/reward_points/presentation/views/widgets/custom_loyalty_Reward_filter_button.dart';

class PrizesScreen extends StatelessWidget {
  const PrizesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PrizesCubit(PrizesRepository())..loadPrizes(),
      child: Scaffold(
        appBar: CustomPrimaryAppbar(
          title: 'Loyalty Reward',
          action: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyPrizeView()),
              );
            },
            icon: Text(
              'My Reward 🎁',
              style: FontManger.regularFontBlack12.copyWith(
                color: ColorManager.warning,
              ),
            ),
          ),
        ),
        body: BlocConsumer<PrizesCubit, PrizesState>(
          buildWhen: (previous, current) => current is! PrizeRedeemed,

          listener: (context, state) {
            if (state is PrizeRedeemed) {
              CustomSnackBar.successSnackBar(
                'Replacement completed successfully: ${state.prize.getName(false)}',
                context,
              );
            } else if (state is PrizesError) {
              // Using error SnackBar might be better, but this works
              CustomSnackBar.errorSnackBar(state.message, context);
            }
          },
          builder: (context, state) {
            if (state is PrizesLoading || state is PrizesInitial) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is PrizesError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Error: ${state.message}'),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () => context.read<PrizesCubit>().loadPrizes(),
                      child: const Text('Try again'),
                    ),
                  ],
                ),
              );
            } else {
              // This handles both PrizesLoaded and PrizesFiltered
              final prizes = state is PrizesLoaded
                  ? state.prizes
                  : (state as PrizesFiltered).filteredPrizes;
              final userPoints = state is PrizesLoaded
                  ? state.userPoints
                  : (state as PrizesFiltered).userPoints;

              return Column(
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    color: Colors.blue.shade100,
                    child: Text(
                      'Points: $userPoints 🏅',
                      style: FontManger.blackBoldFont18.copyWith(
                        color: ColorManager.success,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    height: 50,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        CustomFilterLoyaltyRewardButton(
                          title: 'All',
                          onPressed: () =>
                              context.read<PrizesCubit>().resetFilter(),
                        ),
                        CustomFilterLoyaltyRewardButton(
                          title: 'I can redeem',
                          onPressed: () => context
                              .read<PrizesCubit>()
                              .filterAffordablePrizes(),
                        ),
                        CustomFilterLoyaltyRewardButton(
                          title: '0-100 Point',
                          onPressed: () => context
                              .read<PrizesCubit>()
                              .filterByPointRange(0, 100),
                        ),
                        CustomFilterLoyaltyRewardButton(
                          title: '101-500',
                          onPressed: () => context
                              .read<PrizesCubit>()
                              .filterByPointRange(101, 500),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: prizes.length,
                      itemBuilder: (context, index) {
                        final prize = prizes[index];
                        final canAfford = prize.canAfford(userPoints);

                        return Card(
                          margin: EdgeInsets.all(10.r),
                          color: canAfford
                              ? Colors.white
                              : Colors.grey.shade200,
                          child: ListTile(
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 5.h,
                              horizontal: 5.w,
                            ),
                            leading: Text(
                              prize.icon,
                              style: TextStyle(fontSize: 30.sp),
                            ),
                            title: Text(
                              prize.getName(false),
                              style: FontManger.blackBoldFont18.copyWith(
                                fontSize: 15.sp,
                                color: canAfford
                                    ? ColorManager.secondary
                                    : Colors.grey,
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  prize.getDescription(false),
                                  style: FontManger.meduimFontBlack14.copyWith(
                                    fontSize: 12.sp,
                                    color: canAfford
                                        ? ColorManager.lightGreyColor
                                        : Colors.grey,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '${prize.points} Point',
                                  style: FontManger.blackBoldFont18.copyWith(
                                    color: canAfford
                                        ? Colors.green
                                        : Colors.red,
                                  ),
                                ),
                              ],
                            ),
                            trailing: canAfford
                                ? ElevatedButton(
                                    onPressed: () => _showRedeemDialog(
                                      context,
                                      prize,
                                      context.read<PrizesCubit>(),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.green,
                                    ),
                                    child: Text(
                                      'Redeem',
                                      style: FontManger.whiteBoldFont20
                                          .copyWith(fontSize: 12.sp),
                                    ),
                                  )
                                : const Icon(Icons.lock, color: Colors.grey),
                            onTap: () => _showPrizeDetails(
                              context,
                              prize,
                              canAfford,
                              context.read<PrizesCubit>(),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }

  void _showRedeemDialog(BuildContext context, Prize prize, PrizesCubit cubit) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: ColorManager.background,
        title: Text(
          'Claim Your Prize',
          style: FontManger.blackBoldFont18.copyWith(
            color: ColorManager.success,
          ),
        ),
        content: Text(
          'Do you want to redeem "${prize.getName(false)}" for ${prize.points} points?',
          style: FontManger.meduimFontBlack14,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text(
              'Cancel',
              style: FontManger.blackBoldFont18.copyWith(fontSize: 14),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              cubit.redeemPrize(prize.id);
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            child: Text(
              'Redeem',
              style: FontManger.whiteBoldFont20.copyWith(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }

  void _showPrizeDetails(
    BuildContext context,
    Prize prize,
    bool canAfford,
    PrizesCubit cubit,
  ) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: ColorManager.background,
        title: Row(
          children: [
            Text(prize.icon, style: TextStyle(fontSize: 24)),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                prize.getName(false),
                style: FontManger.blackBoldFont18.copyWith(fontSize: 16.sp),
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              prize.getDescription(false),
              style: FontManger.subTitleTextBold14,
            ),
            SizedBox(height: 16.sp),
            Row(
              children: [
                const Text(
                  'Required Points: ',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  '${prize.points}',
                  style: FontManger.blackBoldFont18.copyWith(
                    fontSize: 15.sp,
                    color: canAfford ? Colors.green : Colors.red,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text(
              'Close',
              style: FontManger.blackBoldFont18.copyWith(fontSize: 14.sp),
            ),
          ),
          if (canAfford)
            ElevatedButton(
              onPressed: () {
                Navigator.pop(dialogContext);
                _showRedeemDialog(context, prize, cubit);
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              child: Text(
                'Redeem',
                style: FontManger.whiteBoldFont20.copyWith(fontSize: 14.sp),
              ),
            ),
        ],
      ),
    );
  }
}
