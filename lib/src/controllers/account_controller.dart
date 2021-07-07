import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/service_locator.dart';
import 'package:movie_app/src/configs/configs.dart';
import 'package:movie_app/src/configs/strings.dart';
import 'package:movie_app/src/controllers/base_controller.dart';
import 'package:movie_app/src/controllers/details_controller.dart';
import 'package:movie_app/src/models/results/movie_result_model.dart';
import 'package:movie_app/src/models/results/tv_result_model.dart';
import 'package:movie_app/src/services/account_service.dart';

class AccountController extends BaseController {
  final _service = sl<AccountService>();
  final _detailsController = Get.find<DetailsController>();

  var watchlistState = ViewState.idle.obs;
  var favoriteState = ViewState.idle.obs;

  var isAddToWatchlist = false.obs;
  var isAddToFavorite = false.obs;

  var movieWatchlist = <MovieResultModel>[].obs;
  var tvWatchlist = <TvResultsModel>[].obs;

  var movieFavorites = <MovieResultModel>[].obs;
  var tvFavorites = <TvResultsModel>[].obs;

// get account details
  void getAccountDetails() async {
    await _service.getAccountDetails();
  }

  // add / remove watchlist
  void postToWatchlist({
    required String mediaType,
    required int? mediaId,
    required bool watchlist,
  }) async {
    watchlistState.value = ViewState.busy;
    await _service
        .postToWatchlist(
            mediaType: mediaType, mediaId: mediaId, watchlist: watchlist)
        .then((value) {
      if (value['success'] == true) {
        if (watchlist == true) {
          isAddToWatchlist.value = true;
          _detailsController.accountState.value.watchlist = true;
          Get.showSnackbar(
            GetBar(
              message: 'Added to watchlist.',
              isDismissible: true,
              duration: const Duration(milliseconds: 1600),
              dismissDirection: SnackDismissDirection.HORIZONTAL,
              snackStyle: SnackStyle.GROUNDED,
              backgroundColor: primaryDarkBlue,
              mainButton: TextButton(
                onPressed: () {
                  // watchlist route
                },
                child: const Text('Go to list'),
              ),
            ),
          );
        } else {
          isAddToWatchlist.value = false;
          _detailsController.accountState.value.watchlist = false;
          Get.showSnackbar(
            GetBar(
              message: 'Removed from watchlist.',
              isDismissible: true,
              duration: const Duration(milliseconds: 1600),
              dismissDirection: SnackDismissDirection.HORIZONTAL,
              snackStyle: SnackStyle.GROUNDED,
              backgroundColor: primaryDarkBlue,
            ),
          );
        }
      }
    });
    watchlistState.value = ViewState.retrived;
  }

  // get movie/tv watchlist
  void getWatchlist({required String mediaType}) async {
    watchlistState.value = ViewState.busy;

    await _service.getWatchList(mediaType: mediaType).then((value) {
      switch (mediaType) {
        case moviesString:
          movieWatchlist = RxList.from(
              (value as List).map((e) => MovieResultModel.fromJson(e)));
          break;
        case tvString:
          tvWatchlist = RxList.from(
              (value as List).map((e) => TvResultsModel.fromJson(e)));
          break;
        default:
          break;
      }
    });
    watchlistState.value = ViewState.busy;
  }

  // add / remove favorites
  void postToFavorites({
    required String mediaType,
    required int? mediaId,
    required bool favorite,
  }) async {
    favoriteState.value = ViewState.busy;
    await _service
        .postToFavorite(
            mediaType: mediaType, mediaId: mediaId, favorite: favorite)
        .then((value) {
      if (value['success'] == true) {
        if (favorite == true) {
          isAddToFavorite.value = true;
          _detailsController.accountState.value.favorite = true;
          Get.showSnackbar(
            GetBar(
              message: 'Added to favorites.',
              isDismissible: true,
              duration: const Duration(milliseconds: 1600),
              dismissDirection: SnackDismissDirection.HORIZONTAL,
              snackStyle: SnackStyle.GROUNDED,
              backgroundColor: primaryDarkBlue,
              mainButton: TextButton(
                onPressed: () {
                  // watchlist route
                },
                child: const Text('Go to list'),
              ),
            ),
          );
        } else {
          isAddToFavorite.value = false;
          _detailsController.accountState.value.favorite = false;
          Get.showSnackbar(
            GetBar(
              message: 'Removed from favorites.',
              isDismissible: true,
              duration: const Duration(milliseconds: 1600),
              dismissDirection: SnackDismissDirection.HORIZONTAL,
              snackStyle: SnackStyle.GROUNDED,
              backgroundColor: primaryDarkBlue,
            ),
          );
        }
      }
    });
    favoriteState.value = ViewState.retrived;
  }

  // get movie/tv favorites
  void getFavorites({required String mediaType}) async {
    favoriteState.value = ViewState.busy;

    await _service.getFavortes(mediaType: mediaType).then((value) {
      switch (mediaType) {
        case moviesString:
          movieFavorites = RxList.from(
              (value as List).map((e) => MovieResultModel.fromJson(e)));
          break;
        case tvString:
          tvFavorites = RxList.from(
              (value as List).map((e) => TvResultsModel.fromJson(e)));
          break;
        default:
          break;
      }
    });
    favoriteState.value = ViewState.busy;
  }
}
