import 'dart:async';

import 'package:mvvm_architechture/domain/models/on_boarding_model.dart';
import 'package:mvvm_architechture/presentation/base/base_view_model.dart';
import 'package:mvvm_architechture/presentation/resources/assets_manager.dart';
import 'package:mvvm_architechture/presentation/resources/string_manager.dart';

class OnBoardingViewModel extends BaseViewModel
    with OnBoardingViewModelInputs, OnBoardingViewModelOutputs {
  final StreamController _streamController =
      StreamController<SliderViewObject>();
  late final List<SliderObject> _sliderList;
  int _currentIndex = 0;

  @override
  void dispose() {
    _streamController.close();
  }

  @override
  void start() {
    _sliderList = _getSliderList();
    _sendDataToView();
  }

  @override
  int goToNext() {
    int nextIndex = _currentIndex+1;
    if (nextIndex == _sliderList.length) { 
      nextIndex = 0;
    }
    return nextIndex;
  }

  @override
  int goToPrevious() {
    int previousIndex = _currentIndex-1;
    if (previousIndex == -1) {
      previousIndex = _sliderList.length;
    }
    return previousIndex;
  }

  @override
  void onPageChanged(int index) {
    _currentIndex = index;
    _sendDataToView();
  }

  @override
  Sink get inputSliderViewObject => _streamController.sink;

  @override
  Stream<SliderViewObject> get outputSliderViewObject =>
      _streamController.stream.map((sliderViewObject) => sliderViewObject);

  void _sendDataToView() {
    inputSliderViewObject.add(
      SliderViewObject(
        sliderObject: _sliderList[_currentIndex],
        numberOfPage: _sliderList.length,
        currentIndex: _currentIndex)
        );
  }

  // get a list of slider object
  List<SliderObject> _getSliderList() {
    return [
      SliderObject(
          title: AppString.onboardingTitle1,
          image: ImagesAsset.onboardingLogo1,
          subTitle: AppString.onboardingSubTitle1),
      SliderObject(
          title: AppString.onboardingTitle2,
          image: ImagesAsset.onboardingLogo2,
          subTitle: AppString.onboardingSubTitle2),
      SliderObject(
          title: AppString.onboardingTitle3,
          image: ImagesAsset.onboardingLogo3,
          subTitle: AppString.onboardingSubTitle3),
      SliderObject(
          title: AppString.onboardingTitle4,
          image: ImagesAsset.onboardingLogo4,
          subTitle: AppString.onboardingSubTitle4),
    ];

  }
}

abstract class OnBoardingViewModelInputs {
  int goToNext(); // When user click on right arrow or swipe left
  int goToPrevious(); // When user click on left arrow or swipe right
  void onPageChanged(int index); // track the index of page

  Sink get inputSliderViewObject;
}

abstract class OnBoardingViewModelOutputs {
  Stream<SliderViewObject> get outputSliderViewObject;
}
