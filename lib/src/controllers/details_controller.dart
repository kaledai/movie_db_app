import 'package:get/get.dart';
import 'package:movie_app/service_locator.dart';
import 'package:movie_app/src/configs/strings.dart';
import 'package:movie_app/src/controllers/base_controller.dart';
import 'package:movie_app/src/models/details/common_details_models.dart';
import 'package:movie_app/src/models/details/movie_details_model.dart';
import 'package:movie_app/src/models/details/tv_details_model.dart';
import 'package:movie_app/src/services/details_service.dart';

class DetailsController extends BaseController {
  final _service = sl<DetailsService>();

  var movieDetailState = ViewState.idle.obs;
  var tvDetailState = ViewState.idle.obs;

  var creditsState = ViewState.idle.obs;
  var imagesState = ViewState.idle.obs;
  var videosState = ViewState.idle.obs;
  var similarState = ViewState.idle.obs;
  var recommendedState = ViewState.idle.obs;
  var accountstateState = ViewState.idle.obs;
  var reviewsState = ViewState.idle.obs;
  var externalIdsState = ViewState.idle.obs;

  var rateState = ViewState.idle.obs;

  var movieDetail = MovieDetailsModel().obs;
  var tvDetail = TvDetailsModel().obs;

  var credits = Credits().obs;
  var reviews = Reviews().obs;
  var images = Images().obs;
  var videos = Videos().obs;

  var similarMovie = SimilarMovie().obs;
  var similarTv = SimilarTv().obs;
  var recommendedMovie = MovieRecommendations().obs;
  var recommendedTv = TvRecommendations().obs;
  var movieExternalIds = MovieExternalIds().obs;
  var tvExternalIds = TvExternalIds().obs;
  var accountState = AccountStates().obs;

  var isRated = false.obs;
  var rateValue = 0.0.obs;
  var rateQuote = ''.obs;

  // set / reset rate value
  void setRateValue(double value) =>
      rateValue.value = value < 0.5 ? 0.5 : value;
  void resetRateValue() => rateValue.value = 0.0;

  // set rate quotes
  void setRateQuote(value) => rateQuote.value = value;

// movie/tv basic details
  void getDetails({required String resultType, required String id}) async {
    switch (resultType) {
      case movieString:
        movieDetailState.value = ViewState.busy;
        await _service.getDetails(resultType: resultType, id: id).then((value) {
          // if (value != null) {
          movieDetail.value = MovieDetailsModel.fromJson(value);
          // ignore: avoid_print
          // print('${movieDetail.value.title} MOVIE DETAILS');
          movieDetailState.value = ViewState.retrived;
          update(['movie_about', 'movie_details']);
          // }
        });
        break;

      case tvString:
        tvDetailState.value = ViewState.busy;
        await _service.getDetails(resultType: resultType, id: id).then((value) {
          // if (value != null) {
          tvDetail.value = TvDetailsModel.fromJson(value);
          // ignore: avoid_print
          // print('${tvDetail.value.name} TV DETAILS');
          tvDetailState.value = ViewState.retrived;
          update(['tv_about', 'tv_details']);
          // }
        });
        break;
      default:
        break;
    }
  }

// rate movie/tv
  void rate({
    required double rateValue,
    required int? mediaId,
    required String mediaType,
    required String appendTo,
  }) async {
    rateState.value = ViewState.busy;
    print(rateValue);
    await _service
        .rate(
      value: rateValue,
      mediaId: mediaId,
      mediaType: mediaType,
    )
        .then((value) {
      print(value);
      if (value['success'] == true) {
        accountState.value.rated = {"value": rateValue};
        isRated.value = true;
        accountState.refresh();
      }
    });
    rateState.value = ViewState.retrived;
  }

// rate movie/tv
  void deleteRating({
    required int? mediaId,
    required String mediaType,
  }) async {
    rateState.value = ViewState.busy;
    await _service
        .deleteRating(mediaId: mediaId, mediaType: mediaType)
        .then((value) {
      print(value);
      if (value['success'] == true) {
        accountState.value.rated = false;
        isRated.value = false;
        accountState.refresh();
      }
    });
    rateState.value = ViewState.retrived;
  }

// other movies details like (images,videos,credits,account_states,similar,recommendations,reviews,external_ids)
  void getOtherDetails({
    required String resultType,
    required String id,
    required String appendTo,
  }) async {
    switch (resultType) {
      case movieString:
        switch (appendTo) {
          case imagesString:
            imagesState.value = ViewState.busy;
            await _service
                .getOtherDetails(
                    resultType: resultType, id: id, appendTo: appendTo)
                .then((value) {
              // if (value != null) {
              images.value = Images.fromJson(value);
              imagesState.value = ViewState.retrived;
              update(['imageSlider']);
              // }
            });
            break;
          case videosString:
            videosState.value = ViewState.busy;
            await _service
                .getOtherDetails(
                    resultType: resultType, id: id, appendTo: appendTo)
                .then((value) {
              // if (value != null) {
              videos.value = Videos.fromJson(value);
              videosState.value = ViewState.retrived;
              update();
              // }
            });
            break;
          case similarString:
            similarState.value = ViewState.busy;
            await _service
                .getOtherDetails(
                    resultType: resultType, id: id, appendTo: appendTo)
                .then((value) {
              // if (value != null) {
              similarMovie.value = SimilarMovie.fromJson(value);
              similarState.value = ViewState.retrived;
              update(['movie_similar']);
              // }
            });
            break;
          case recommendedSTring:
            recommendedState.value = ViewState.busy;
            await _service
                .getOtherDetails(
                    resultType: resultType, id: id, appendTo: appendTo)
                .then((value) {
              // if (value != null) {
              recommendedMovie.value = MovieRecommendations.fromJson(value);
              recommendedState.value = ViewState.retrived;
              update(['movie_recommended']);
              // }
            });
            break;
          case accountStateString:
            accountstateState.value = ViewState.busy;
            await _service
                .getOtherDetails(
                    resultType: resultType, id: id, appendTo: appendTo)
                .then((value) {
              accountState.value = AccountStates.fromJson(value);
              if (accountState.value.rated != false) {
                isRated.value = true;
              } else {
                isRated.value = false;
              }
              accountstateState.value = ViewState.retrived;
              update(['account_state']);
              // }
            });
            break;
          case creditsString:
            creditsState.value = ViewState.busy;
            await _service
                .getOtherDetails(
                    resultType: resultType, id: id, appendTo: appendTo)
                .then((value) {
              // if (value != null) {
              credits.value = Credits.fromJson(value);
              creditsState.value = ViewState.retrived;
              update(['movie_cast', 'movie_crews']);
              // }
            });
            break;
          case reviewsString:
            reviewsState.value = ViewState.busy;
            await _service
                .getOtherDetails(
                    resultType: resultType, id: id, appendTo: appendTo)
                .then((value) {
              // if (value != null) {
              reviews.value = Reviews.fromJson(value);
              reviewsState.value = ViewState.retrived;
              update(['movie_reviews']);
              // }
            });
            break;
          case externalIdsString:
            externalIdsState.value = ViewState.busy;
            await _service
                .getOtherDetails(
                    resultType: resultType, id: id, appendTo: appendTo)
                .then((value) {
              // if (value != null) {
              movieExternalIds.value = MovieExternalIds.fromJson(value);
              externalIdsState.value = ViewState.retrived;
              update();
              // }
            });
            break;
          default:
            break;
        }
        break;

      case tvString:
        switch (appendTo) {
          case imagesString:
            imagesState.value = ViewState.busy;
            await _service
                .getOtherDetails(
                    resultType: resultType, id: id, appendTo: appendTo)
                .then((value) {
              // if (value != null) {
              images.value = Images.fromJson(value);
              imagesState.value = ViewState.retrived;
              update(['imageSlider']);
              // }
            });
            break;
          case videosString:
            videosState.value = ViewState.busy;
            await _service
                .getOtherDetails(
                    resultType: resultType, id: id, appendTo: appendTo)
                .then((value) {
              // if (value != null) {
              videos.value = Videos.fromJson(value);
              videosState.value = ViewState.retrived;
              update();
              // }
            });
            break;
          case similarString:
            similarState.value = ViewState.busy;
            await _service
                .getOtherDetails(
                    resultType: resultType, id: id, appendTo: appendTo)
                .then((value) {
              // if (value != null) {
              similarTv.value = SimilarTv.fromJson(value);
              similarState.value = ViewState.retrived;
              update(['tv_similar']);
              // }
            });
            break;
          case recommendedSTring:
            recommendedState.value = ViewState.busy;
            await _service
                .getOtherDetails(
                    resultType: resultType, id: id, appendTo: appendTo)
                .then((value) {
              // if (value != null) {
              recommendedTv.value = TvRecommendations.fromJson(value);
              recommendedState.value = ViewState.retrived;
              update(['tv_recommended']);
              // }
            });
            break;
          case accountStateString:
            accountstateState.value = ViewState.busy;
            await _service
                .getOtherDetails(
                    resultType: resultType, id: id, appendTo: appendTo)
                .then((value) {
              // if (value != null) {
              accountState.value = AccountStates.fromJson(value);
              accountstateState.value = ViewState.retrived;

              // }
            });
            break;
          case creditsString:
            creditsState.value = ViewState.busy;
            await _service
                .getOtherDetails(
                    resultType: resultType, id: id, appendTo: appendTo)
                .then((value) {
              // if (value != null) {
              credits.value = Credits.fromJson(value);
              creditsState.value = ViewState.retrived;
              update(['tv_cast', 'tv_crews']);
              // }
            });
            break;
          case reviewsString:
            reviewsState.value = ViewState.busy;
            await _service
                .getOtherDetails(
                    resultType: resultType, id: id, appendTo: appendTo)
                .then((value) {
              // if (value != null) {
              reviews.value = Reviews.fromJson(value);
              reviewsState.value = ViewState.retrived;
              update(['tv_reviews']);
              // }
            });
            break;
          case externalIdsString:
            externalIdsState.value = ViewState.busy;
            await _service
                .getOtherDetails(
                    resultType: resultType, id: id, appendTo: appendTo)
                .then((value) {
              // if (value != null) {
              tvExternalIds.value = TvExternalIds.fromJson(value);
              externalIdsState.value = ViewState.retrived;
              update();
              // }
            });
            break;
          default:
            break;
        }
        break;
      default:
        break;
    }
  }
}
