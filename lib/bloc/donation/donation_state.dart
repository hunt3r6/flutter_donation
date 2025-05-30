part of 'donation_cubit.dart';

@freezed
class DonationState with _$DonationState {
  const factory DonationState.initial() = DonationInitial;
  const factory DonationState.loading() = DonationLoading;
  const factory DonationState.loaded(
    List<DonationModel> donations, {
    required bool hasMore,
  }) = DonationLoaded;
  const factory DonationState.error(String message) = DonationError;
}
