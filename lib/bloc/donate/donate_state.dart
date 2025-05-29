part of 'donate_cubit.dart';

@freezed
class DonateState with _$DonateState {
  const factory DonateState.initial() = DonateInitial;
  const factory DonateState.loading() = DonateLoading;
  const factory DonateState.success(String snapToken) = DonateSuccess;
  const factory DonateState.error(String message) = DonateError;
}
