import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:movie_app/src/configs/configs.dart';
import 'package:movie_app/src/configs/strings.dart';
import 'package:movie_app/src/controllers/deatils_controller.dart';
import 'package:movie_app/src/controllers/people_controller.dart';
import 'package:movie_app/src/controllers/results_controller.dart';
import 'package:movie_app/src/models/peoples/people_movie_credits.dart';
import 'package:movie_app/src/models/results/movie_result_model.dart';
import 'package:movie_app/src/views/deatils/movie_deatils/movie_deatils.dart';

Widget movieCreditsThumbnailCard({
  required MovieCast movie,
  required String imageUrl,
  EdgeInsetsGeometry? padding,
}) {
  final _resultController = Get.find<ResultsController>();
  final _detailsController = Get.find<DetailsController>();
  final _peopleController = Get.find<PeopleController>();

  return GestureDetector(
    onTap: () {
      // _peopleController.setMovie(movie);
      _resultController.setMovieId(movie.id!);

      // ignore: avoid_print
      // print('${movie.title}, ${movie.id}');

      // ignore: avoid_print
      // print('${_peopleController.movie.title}, ${_resultController.movie.id}');

      Get.offAllNamed('/movie_details', arguments: _resultController.movieId);
    },
    child: SizedBox(
      width: 100,
      height: 186,
      child: Column(
        children: [
          Container(
            padding: padding ?? const EdgeInsets.fromLTRB(0, 0, 8, 0),
            child: Stack(
              alignment: AlignmentDirectional.topEnd,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: movie.posterPath == null
                      ? Container(
                          alignment: Alignment.center,
                          width: 94,
                          height: 140,
                          color: Colors.black12,
                          child: const Icon(
                            Icons.error_outline,
                            color: primaryWhite,
                            size: 34,
                          ),
                        )
                      : CachedNetworkImage(
                          width: 94,
                          height: 140,
                          fit: BoxFit.fill,
                          imageUrl: imageUrl,
                          placeholder: (context, url) => Container(
                            color: Colors.black12,
                          ),
                        ),
                ),
                Positioned(
                  right: 4,
                  top: 4,
                  child: Container(
                    padding: padding ?? const EdgeInsets.fromLTRB(6, 0, 6, 0),
                    decoration: BoxDecoration(
                      color: primaryDark.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      '${movie.voteAverage}',
                      style: const TextStyle(
                        fontSize: n - 5,
                        color: primaryWhite,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // movie title and option
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    movie.title ?? "Title",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: n - 5,
                      fontWeight: FontWeight.w600,
                      // letterSpacing: 0.2,
                      color: primaryDark,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // ignore: avoid_print
                    print('options bottom sheet ...');
                  },
                  child: const Icon(
                    Icons.more_vert,
                    color: primaryDarkBlue,
                    size: 18,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
