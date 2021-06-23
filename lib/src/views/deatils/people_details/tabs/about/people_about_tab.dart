import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/src/configs/configs.dart';
import 'package:movie_app/src/configs/strings.dart';
import 'package:movie_app/src/controllers/deatils_controller.dart';
import 'package:movie_app/src/controllers/people_controller.dart';
import 'package:movie_app/src/controllers/results_controller.dart';
import 'package:movie_app/src/controllers/utility_controller.dart';
import 'package:movie_app/src/global/loading_spinner.dart';
import 'package:movie_app/src/helpers/widget_builder_helper.dart';
import 'package:movie_app/src/views/deatils/components/header_text.dart';
import 'package:movie_app/src/views/deatils/components/hide_show_btn.dart';
import 'package:movie_app/src/views/deatils/components/poster_card.dart';
import 'package:movie_app/src/views/deatils/components/storyline_text.dart';

import 'components/about_info.dart';
import 'components/chips_builder.dart';

class PeopleAboutTab extends StatelessWidget {
  final _detailsController = Get.find<DetailsController>();
  final _resultsController = Get.find<ResultsController>();
  final _utilityController = Get.find<UtilityController>();
  final _peopleController = Get.find<PeopleController>();

  PeopleAboutTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 18),
          aboutInfo(people: _peopleController.people.value),
          const SizedBox(height: 12),
          storylineTextBuilder(
              headerText: 'Biography',
              text: _peopleController.people.value.biography == "" ||
                      _peopleController.people.value.biography == null
                  ? 'No Biography at the moment'
                  : _peopleController.people.value.biography ?? "biography"),
          toggleHideShowBtn(),
          const SizedBox(height: 12),
          chipsBuilder(chips: _peopleController.people.value.alsoKnownAs ?? []),
          const SizedBox(height: 18),
          GetBuilder(
            id: 'people_images',
            init: _peopleController,
            initState: (_) {
              _peopleController.getCreditsDetails(
                  personId: _peopleController.personId,
                  resultType: imagesString);
            },
            builder: (controller) => WidgetBuilderHelper(
              state: _peopleController.imagesState.value,
              onLoadingBuilder: LoadingSpinner.horizontalLoading,
              onSuccessBuilder: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  headerBuilder(headerText: 'Images'),
                  const SizedBox(height: 12),
                  _peopleController.images.isEmpty
                      ? Text(
                          'No images to show at the moment',
                          style: TextStyle(
                            color: primaryDarkBlue.withOpacity(0.6),
                            fontSize: n - 2,
                          ),
                        )
                      : SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: List.from(
                              _peopleController.images.map(
                                (e) => posterCard(imageUrl: e.filePath ?? "#"),
                              ),
                            ),
                          ),
                        ),
                ],
              ),
              onErrorBuilder: const Center(
                child: Text('error while loading data ...'),
              ),
              // )
            ),
          ),
          const SizedBox(height: 18),
        ],
      ),
    );
  }
}
