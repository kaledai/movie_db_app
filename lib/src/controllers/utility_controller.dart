import 'package:flutter/material.dart';
import 'package:movie_app/src/controllers/base_controller.dart';
import 'package:get/get.dart';

enum SwitchBtnState { option1, option2 } //switch btn state

class UtilityController extends BaseController {
// bottom navigation state
  var _navCurrentIndex = 0.obs;

  int get navCurrentIndex => _navCurrentIndex.value;

  setBottomNavIndex(int newIndex) {
    _navCurrentIndex.value = newIndex;
  }

  // switch btn state
  var _switchBtnState = SwitchBtnState.option1.obs;

  SwitchBtnState get switchBtnState => _switchBtnState.value;

  toggleSwitchBtnState(SwitchBtnState newSatate) {
    _switchBtnState.value = newSatate;
  }

  /// [ img slider pageview state ]
  var _imgSliderIndex = 0.obs;
  final _controller = PageController(keepPage: true).obs;

  int get imgSliderIndex => _imgSliderIndex.value;
  PageController get controller => _controller.value;

  void setSliderIndex(int index) {
    _imgSliderIndex.value = index;
  }

  void forward(int currentIndex, int length) {
    if (currentIndex != (length - 1) && currentIndex < (length - 1)) {
      _imgSliderIndex.value += 1;
      // ignore: avoid_print
      // print(_imgSliderIndex.value);
    }
  }

  void backward(int currentIndex, int length) {
    if (currentIndex != (length + 1) && currentIndex > 0) {
      _imgSliderIndex.value -= 1;
      // ignore: avoid_print
      // print(_imgSliderIndex.value);
    }
  }

  void toggleImgSlider({
    required ImgSliderEvents toggleEvent,
    required int currentIndex,
    required int length,
  }) {
    switch (toggleEvent) {
      case ImgSliderEvents.forward:
        forward(currentIndex, length);
        break;
      case ImgSliderEvents.backward:
        backward(currentIndex, length);
        break;
      default:
        break;
    }

    _controller.value.animateToPage(
      _imgSliderIndex.value,
      duration: const Duration(milliseconds: 500),
      curve: Curves.ease,
    );
  }
}

enum ImgSliderEvents { forward, backward } // img slider btn events