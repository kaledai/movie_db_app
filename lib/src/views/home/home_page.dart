import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/src/configs/strings.dart';
import 'package:movie_app/src/controllers/configuration_controller.dart';
import 'package:movie_app/src/controllers/results_controller.dart';
import 'package:movie_app/src/controllers/utility_controller.dart';
import 'package:movie_app/src/helpers/widget_builder_helper.dart';
import 'package:movie_app/src/models/api_configuration_model.dart';
import 'package:movie_app/src/views/home/components/movies_block_builder.dart';
import 'components/app_bar.dart';

class HomePage extends StatelessWidget {
  final _utilityController = Get.find<UtilityController>();
  final _resultsController = Get.find<ResultsController>();
  final _configurationController = Get.find<ConfigurationController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        appBarBuilder(),
        Padding(
          padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
          child: Column(
            children: [
              moviesBlockBuilder(
                onMoreTap: () {},
                movies: _resultsController.movies,
                posterUrl: _configurationController.posterUrl,
                title: 'Movies',
              ),

              const SizedBox(height: 22),

              //
              TextButton(
                onPressed: () {
                  _resultsController.getMovieResults(
                      page: "5", resultType: NOW_PLAYING_STRING);
                  _resultsController.getTvResults(
                      page: "5", resultType: ON_THE_AIR_STRING);
                  _configurationController.getConfigurations();
                },
                child: const Text('get service results'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
