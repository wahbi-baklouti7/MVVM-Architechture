import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mvvm_architechture/domain/models/on_boarding_model.dart';
import 'package:mvvm_architechture/presentation/onboarding/view_model/onboarding_view_model.dart';
import 'package:mvvm_architechture/presentation/resources/assets_manager.dart';
import 'package:mvvm_architechture/presentation/resources/color_manager.dart';
import 'package:mvvm_architechture/presentation/resources/constants_manager.dart';
import 'package:mvvm_architechture/presentation/resources/values_manager.dart';

class BottomSheetWidget extends StatelessWidget {
  OnBoardingViewModel onBoardingViewModel;
  int listLength;
  int currentIndex;
  PageController pageController;
  BottomSheetWidget(
      { required this.onBoardingViewModel,
        required this.listLength,
      required this.currentIndex,
      required this.pageController,
      Key? key})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorManager.primary,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // left arrow
          Padding(
            padding: const EdgeInsets.all(AppPadding.p8),
            child: GestureDetector(
              onTap: () {
                pageController.animateToPage(onBoardingViewModel.goToPrevious(),
                    duration:
                        const Duration(microseconds: AppConstants.sliderTimer),
                    curve: Curves.bounceInOut);
              },
              child: SizedBox(
                  height: AppSize.s20,
                  width: AppSize.s20,
                  child: SvgPicture.asset(ImagesAsset.leftArrowIc)),
            ),
          ),

          // circle indicator
          Row(
            children: [
              for (int i = 0; i < listLength; i++)
                Padding(
                  padding: const EdgeInsets.all(
                    AppPadding.p8,
                  ),
                  child: getProperCircle(i),
                )
            ],
          ),

          // right arrow
          Padding(
            padding: const EdgeInsets.all(AppPadding.p8),
            child: GestureDetector(
              onTap: () {
                pageController.animateToPage(onBoardingViewModel.goToNext(),
                    duration:
                        const Duration(microseconds: AppConstants.sliderTimer),
                    curve: Curves.bounceInOut);
              },
              child: SizedBox(
                  height: AppSize.s20,
                  width: AppSize.s20,
                  child: SvgPicture.asset(ImagesAsset.rightArrowIc)),
            ),
          ),
        ],
      ),
    );
  }

  Widget getProperCircle(int index) {
    if (index == currentIndex) {
      return SvgPicture.asset(ImagesAsset.solidCircleIc);
    } else {
      return SvgPicture.asset(ImagesAsset.hollowCircleIc);
    }
  }
}

















class OnBoardingSlider extends StatelessWidget {
  SliderObject sliderObject;
  OnBoardingSlider({required this.sliderObject, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(
          height: AppSize.s60,
        ),
        Padding(
          padding: const EdgeInsets.all(AppPadding.p8),
          child: Text(
            sliderObject.title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineLarge,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(AppPadding.p8),
          child: Text(
            sliderObject.subTitle,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
        const SizedBox(
          height: AppSize.s40,
        ),
        SvgPicture.asset(sliderObject.image)
      ],
    );
  }
}