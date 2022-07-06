import 'dart:async';

import 'package:mvvm_architechture/presentation/common/state_render/state.render.impl.dart';

abstract class BaseViewModel extends BaseViewModelInputs
    with BaseViewModelOutputs {

      // shared attributes and methods will be used of any view model
  final StreamController _stateStreamController =
      StreamController<FlowState>.broadcast();
  @override
  void dispose() {
    _stateStreamController.close();
  }

  @override
  Sink get inputState => _stateStreamController.sink;

  @override
  Stream<FlowState> get outputState => _stateStreamController.stream.map((flowState) => flowState);
}

abstract class BaseViewModelInputs {
  void start();
  void dispose();
  Sink get inputState;
}

abstract class BaseViewModelOutputs {
  Stream<FlowState> get outputState;
}
