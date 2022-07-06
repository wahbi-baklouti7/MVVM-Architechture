import 'package:flutter/material.dart';
import 'package:mvvm_architechture/presentation/common/state_render/state_render.dart';
import 'package:mvvm_architechture/presentation/resources/string_manager.dart';

abstract class FlowState {
  StateRenderType getStateRenderType();
  String getMessage();
}

// Loading state (Popup/Full screen)
class LoadingState extends FlowState {
  StateRenderType stateRenderType;
  String message ;
  LoadingState({required this.stateRenderType,  this.message= AppString.loading});
  @override
  String getMessage() => message;

  @override
  StateRenderType getStateRenderType() => stateRenderType;
}

// Error state (Popup/Full screen)
class ErrorState extends FlowState {
  StateRenderType stateRenderType;
  String message;
  Function? retryActionFunction;
  ErrorState(
      {required this.stateRenderType,
      required this.message,
       this.retryActionFunction});
  @override
  String getMessage() => message;

  @override
  StateRenderType getStateRenderType() => stateRenderType;
}

// Empty state
class EmptyState extends FlowState {
  String message;
  EmptyState({required this.message});
  @override
  String getMessage() => message;

  @override
  StateRenderType getStateRenderType() => StateRenderType.fullScreenEmptyState;
}

// Content state
class ContentState extends FlowState {
  @override
  String getMessage() => AppString.empty;

  @override
  StateRenderType getStateRenderType() => StateRenderType.contentState;
}

extension FlowStateExtension on FlowState {
  Widget getScreenWidget(BuildContext context,{ required Widget contentScreenWidget,
      required Function retryActionFunction}) {
    switch (runtimeType) {
      case LoadingState:
        if (getStateRenderType() == StateRenderType.popupLoadingState) {
          // show popup loading
          showPopupDialog(
              context, getStateRenderType(), getMessage());

          // show content ui of the screen
          return contentScreenWidget;
        } else {
          // show full screen loading state
          return StateRender(
            stateRenderType: getStateRenderType(),
            message: getMessage(),
            retryActionFunction: retryActionFunction,
          );
        }

      case ErrorState:
        _dismissDialog(context);
        if (getStateRenderType() == StateRenderType.popupErrorState) {
          // show popup error
          showPopupDialog(
              context, getStateRenderType(), getMessage());

          // show content ui of the screen
          return contentScreenWidget;
        } else {
          // show full screen error state
          return StateRender(
            stateRenderType: getStateRenderType(),
            message: getMessage(),
            retryActionFunction: retryActionFunction,
          );
        }

      case EmptyState:
        return StateRender(
          stateRenderType: getStateRenderType(),
          retryActionFunction: () {},
          message: getMessage(),
        );

      case ContentState:
        //  _dismissDialog(context);
        return contentScreenWidget;

      default:
        return contentScreenWidget;
    }
  }
}

showPopupDialog(BuildContext context, StateRenderType stateRenderType,
    String message) {
  WidgetsBinding.instance.addPostFrameCallback((_) => showDialog(
      context: context,
      builder: (BuildContext context) => StateRender(
            stateRenderType: stateRenderType,
            message: message,
            retryActionFunction: () {},
          )));
}

// returns true if the current route is a dialog, and false if it is not
bool _isCurrentDialogShowing(BuildContext context) {
  return ModalRoute.of(context)!.isCurrent!=true;
}

// will dismiss the current dialog if is showing
_dismissDialog(BuildContext context) {
  print("is current dialog: ${_isCurrentDialogShowing(context)}");
  if (_isCurrentDialogShowing(context)) {
    // Navigator.of(context, rootNavigator: true).pop(true);
    Navigator.of(context).pop();
  }
}
