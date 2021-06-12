import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/src/configs/color_config.dart';
import 'package:movie_app/src/configs/strings.dart';
import 'package:movie_app/src/controllers/deatils_controller.dart';
import 'package:movie_app/src/controllers/results_controller.dart';
import 'package:movie_app/src/views/dashboard/dashboard.dart';
import 'package:movie_app/src/views/home/home_page.dart';

// title widget
class SABTN extends StatefulWidget {
  // final Widget child;

  const SABTN({Key? key}) : super(key: key);

  @override
  _SABTNState createState() => _SABTNState();
}

class _SABTNState extends State<SABTN> {
  ScrollPosition? _position;
  bool? _visible;

  @override
  void dispose() {
    _removeListener();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _removeListener();
    _addListener();
  }

  void _addListener() {
    _position = Scrollable.of(context)?.position;
    _position?.addListener(_positionListener);
    _positionListener();
  }

  void _removeListener() {
    _position?.removeListener(_positionListener);
  }

  void _positionListener() {
    final FlexibleSpaceBarSettings? settings =
        context.dependOnInheritedWidgetOfExactType<FlexibleSpaceBarSettings>();
    bool visible =
        settings == null || settings.currentExtent <= settings.minExtent;
    if (_visible != visible) {
      setState(() {
        _visible = visible;
      });
    }
  }

  final _detailsController = Get.find<DetailsController>();
  final _resultsController = Get.find<ResultsController>();

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 300),
      opacity: 1,
      curve: Curves.easeIn,
      child: IconButton(
        onPressed: () {
          Get.offAllNamed('/');
        },
        icon: Icon(
          Icons.arrow_back,
          color: _visible == false ? primaryWhite : primaryDarkBlue,
        ),
      ),
    );
  }
}
