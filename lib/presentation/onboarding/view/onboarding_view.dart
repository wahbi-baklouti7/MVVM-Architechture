import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mvvm_architechture/domain/models/on_boarding/on_boarding_model.dart';
import 'package:mvvm_architechture/presentation/onboarding/view_model/onboarding_view_model.dart';
import 'package:mvvm_architechture/presentation/onboarding/widgets/on_boarding_widgets.dart';
import 'package:mvvm_architechture/presentation/resources/color_manager.dart';
import 'package:mvvm_architechture/presentation/resources/routes_manager.dart';
import 'package:mvvm_architechture/presentation/resources/string_manager.dart';
import 'package:mvvm_architechture/presentation/resources/values_manager.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({Key? key}) : super(key: key);

  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
  final OnBoardingViewModel _onBoardingVM = OnBoardingViewModel();

  void _bind() {
    _onBoardingVM.start();
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  void dispose() {
    _onBoardingVM.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<SliderViewObject>(
      stream: _onBoardingVM.outputSliderViewObject,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.data == null) {
          return Container();
        } else {
          return OnBoardingContent(
            sliderViewObject: snapshot.data,
            onBoardingViewModel: _onBoardingVM,
          );
        }
      },
    );
  }
}

class OnBoardingContent extends StatelessWidget {
  OnBoardingViewModel onBoardingViewModel;
  SliderViewObject sliderViewObject;
  final PageController _pageController = PageController();

  OnBoardingContent(
      {required this.sliderViewObject,
      required this.onBoardingViewModel,
      Key? key})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      appBar: AppBar(
          backgroundColor: ColorManager.white,
          elevation: AppSize.s0,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: ColorManager.white,
            statusBarIconBrightness: Brightness.dark,
          )),
      body: PageView.builder(
          itemCount: sliderViewObject.numberOfPage,
          onPageChanged: (index) {
            onBoardingViewModel.onPageChanged(index);
          },
          controller: _pageController,
          itemBuilder: (context, index) {
            return OnBoardingSlider(
                sliderObject: sliderViewObject.sliderObject);
          }),
      bottomSheet: Container(
        color: ColorManager.white,
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () =>
                  Navigator.pushReplacementNamed(context, Routes.loginRoute),
              child: Text(
                AppString.skip,
                textAlign: TextAlign.end,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
          ),
          BottomSheetWidget(
            onBoardingViewModel: onBoardingViewModel,
            listLength: sliderViewObject.numberOfPage,
            currentIndex: sliderViewObject.currentIndex,
            pageController: _pageController,
          ),
        ]),
      ),
    );
  }
}

