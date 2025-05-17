part of 'campaign_cubit.dart';

@freezed
class CampaignState with _$CampaignState {
  const factory CampaignState.initial() = CampaignInitial;
  const factory CampaignState.loading() = CampaignLoading;
  const factory CampaignState.loaded(List<CampaignModel> campaigns) =
      CampaignLoaded;
  const factory CampaignState.error(String message) = CampaignError;
}
