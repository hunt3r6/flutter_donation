import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_donation/resource/remote/donation_remote_resource.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'donate_state.dart';
part 'donate_cubit.freezed.dart';

class DonateCubit extends Cubit<DonateState> {
  final DonationRemoteResource donationRemoteResource;
  DonateCubit(this.donationRemoteResource) : super(DonateState.initial());

  donate(String amount, String message, String slugCampaign) async {
    emit(DonateState.loading());
    final result = await donationRemoteResource.donate(
      message,
      amount: amount,
      slug: slugCampaign,
    );
    result.fold(
      (error) => emit(DonateState.error(error)),
      (snapToken) => emit(DonateState.success(snapToken)),
    );
  }
}
