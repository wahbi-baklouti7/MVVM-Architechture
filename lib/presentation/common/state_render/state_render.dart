import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mvvm_architechture/presentation/resources/assets_manager.dart';
import 'package:mvvm_architechture/presentation/resources/color_manager.dart';
import 'package:mvvm_architechture/presentation/resources/font_manager.dart';
import 'package:mvvm_architechture/presentation/resources/string_manager.dart';
import 'package:mvvm_architechture/presentation/resources/style_manager.dart';
import 'package:mvvm_architechture/presentation/resources/values_manager.dart';

enum StateRenderType {
  // popup states

  popupLoadingState,
  popupErrorState,

  // full screen state
  fullScreenLoadingState,
  fullScreenErrorState,
  fullScreenEmptyState,

  // general
  contentState
}

class StateRender extends StatelessWidget {
  StateRenderType stateRenderType;
  String message;
  String title;
  Function retryActionFunction;
  StateRender(
      {Key? key,
      required this.stateRenderType,
      this.message = AppString.loading,
      this.title = "",
      required this.retryActionFunction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (stateRenderType) {
      case StateRenderType.popupLoadingState:
        return PopUpDialogWidget(children:  [const AnimatedImageWidget(animationName: JsonAsset.loading)]);

      case StateRenderType.popupErrorState:
        return PopUpDialogWidget(children: [
           const AnimatedImageWidget(animationName: JsonAsset.error),
          MessageWidget(
            message: message,
          ),
          ErrorStateButton(
              retryActionFunction: retryActionFunction,
              stateRenderType: stateRenderType,
              textButton: AppString.ok)
        ]);
      case StateRenderType.fullScreenLoadingState:
        return StateRenderContent(
          children: [
             const AnimatedImageWidget(animationName: JsonAsset.loading),
            MessageWidget(message: message),
          ],
        );

      case StateRenderType.fullScreenErrorState:
        return StateRenderContent(children: [
           const AnimatedImageWidget(animationName: JsonAsset.error),
          // message
          MessageWidget(message: message),
          ErrorStateButton(
            textButton: AppString.retryAgain,
            retryActionFunction: retryActionFunction,
            stateRenderType: stateRenderType,
          )
        ]);
      case StateRenderType.fullScreenEmptyState:
        return StateRenderContent(children: [
           const AnimatedImageWidget(animationName: JsonAsset.empty),
          MessageWidget(message: message),
        ]);
      case StateRenderType.contentState:
        return Container();
      default:
        return Container();
    }
  }
}

class MessageWidget extends StatelessWidget {
  String message;
  MessageWidget({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p8),
        child: Text(message,
            style: getRegularStyle(
                color: ColorManager.black, fontSize: FontSize.s18)),
      ),
    );
  }
}

class PopUpDialogWidget extends StatelessWidget {
  List<Widget> children;
  PopUpDialogWidget({Key? key, required this.children}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSize.s12)),
        elevation: AppSize.s1_5,
        backgroundColor: ColorManager.transparent,
        child: Container(
          decoration: BoxDecoration(
              color: ColorManager.white,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(AppSize.s12),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                )
              ]),
          child: DialogContent(children: children),
        ));
  }
}

class DialogContent extends StatelessWidget {
  List<Widget> children;
  DialogContent({Key? key, required this.children}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: children,
    );
  }
}

class ErrorStateButton extends StatelessWidget {
  final String textButton;
  final StateRenderType stateRenderType;

  final Function retryActionFunction;
  const ErrorStateButton({
    Key? key,
    required this.retryActionFunction,
    required this.stateRenderType,
    required this.textButton,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppPadding.p16),
      child: ElevatedButton(
          onPressed: () {
            if (stateRenderType == StateRenderType.fullScreenErrorState) {
              return retryActionFunction.call();
            } else {
              Navigator.of(context).pop();
            }
          },
          child: Text(textButton)),
    );
  }
}

class StateRenderContent extends StatelessWidget {
  final List<Widget> children;
  const StateRenderContent({Key? key, required this.children})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: children,
    );
  }
}

class AnimatedImageWidget extends StatelessWidget {
  final  String animationName;
  const   AnimatedImageWidget({Key? key,required this.animationName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      height: AppSize.s100,
      width: AppSize.s100,
      child: Lottie.asset(animationName),
    );
  }
}
