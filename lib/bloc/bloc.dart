import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sample_app/models/Plan.model.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:sample_app/models/Stage.model.dart';
import 'package:uuid/uuid.dart';

class TestBloc extends Bloc<CounterEvent, CounterState> {
  void addPlanToStage(List<Plan> plans) {
    dispatch(AddPlanToStage(plans));
  }

  void deletePlan(int index) {
    dispatch(RemovePlan(index));
  }

  @override
  CounterState get initialState {
    return CounterState.initial();
  }

  @override
  Stream<CounterState> mapEventToState(CounterEvent event) async* {
    if (event is AddPlanToStage) {
      try {
        yield currentState.copyWith(isFetching: true);
        Directory tempDir = await getTemporaryDirectory();
        String tempPath = tempDir.path;
        Stage stage = currentState.stage;
        event.plans.forEach((Plan plan) async {
          ByteData data = await rootBundle.load('lib/assets/hey.txt');
          String otherId = new Uuid().v4();
          File file = await File("$tempPath/$otherId").writeAsBytes(
              data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));

          File newFile = await file.copy("$tempPath/${plan.id}");
          String id = new Uuid().v4();
          stage.plans.add(Plan(id, plan.name, newFile.path, checked: false));
        });

        yield currentState.copyWith(stage: stage, isFetching: false);
      } catch (e) {
        print(e);
      }
    }
    if (event is RemovePlan) {
      Stage stage = currentState.stage;
      stage.plans.removeAt(event.index);
      yield currentState.copyWith(stage: stage);
    }
  }
}

abstract class CounterEvent {}

class AddPlanToStage extends CounterEvent {
  List<Plan> plans;
  AddPlanToStage(this.plans);
}

class RemovePlan extends CounterEvent {
  final int index;
  RemovePlan(this.index);
}

class CounterState {
  bool isFetching;
  Stage stage;
  List<Plan> plans;
  CounterState({this.stage, this.isFetching, this.plans});

  factory CounterState.initial() => CounterState(
        stage: Stage("Test", List<Plan>(), ""),
        isFetching: false,
      );

  CounterState copyWith({
    Stage stage,
    bool isFetching,
  }) {
    return CounterState(
      stage: stage ?? this.stage,
      isFetching: isFetching ?? this.isFetching,
    );
  }
}
