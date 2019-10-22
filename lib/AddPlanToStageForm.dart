import 'package:flutter/material.dart';
import 'package:sample_app/bloc/bloc.dart';
import 'package:sample_app/models/Plan.model.dart';
import 'package:uuid/uuid.dart';

class AddPlanToStageForm extends StatefulWidget {
  final TestBloc bloc;
  AddPlanToStageForm(this.bloc);
  @override
  _AddPlanToStageFormState createState() => _AddPlanToStageFormState();
}

class _AddPlanToStageFormState extends State<AddPlanToStageForm> {
  List<Plan> plans;
  @override
  void initState() {
    plans = <Plan>[
      Plan(new Uuid().v4(), "item1", "", checked: false),
      Plan(new Uuid().v4(), "item2", "", checked: false),
      Plan(new Uuid().v4(), "item3", "", checked: false),
      Plan(new Uuid().v4(), "item4", "", checked: false),
      Plan(new Uuid().v4(), "item5", "", checked: false),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Add plan to ${widget.bloc.currentState.stage.name}"),
          centerTitle: true,
        ),
        body: Container(
          child: Builder(
            builder: (BuildContext context) {
              if (plans.length == 0) {
                return Center(
                  child: Column(
                    children: <Widget>[Text("There is no plan(s) here.")],
                  ),
                );
              } else {
                return Column(
                  children: <Widget>[
                    Card(
                      margin: EdgeInsets.all(8),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: plans.length,
                        itemBuilder: (BuildContext context, index) {
                          return Column(
                            children: <Widget>[
                              CheckboxListTile(
                                selected: plans[index].checked,
                                value: plans[index].checked,
                                onChanged: (bool newValue) {
                                  List<Plan> _plans = new List();
                                  _plans.addAll(plans);
                                  Plan plan = plans[index];
                                  _plans.removeAt(index);
                                  _plans.insert(
                                      index,
                                      Plan(plan.id, plan.name, plan.path,
                                          checked: newValue));
                                  setState(() {
                                    plans = _plans;
                                  });
                                },
                                title: Text("${plans[index].name}"),
                              ),
                              Divider(
                                height: 0,
                              )
                            ],
                          );
                        },
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: Builder(
                          builder: (BuildContext context) {
                            if (plans
                                    .where((plan) => plan.checked == true)
                                    .isEmpty ==
                                false) {
                              return FlatButton(
                                onPressed: () {
                                  try {
                                    widget.bloc.addPlanToStage(plans
                                        .where((plan) => plan.checked == true)
                                        .toList());
                                  } finally {
                                    Navigator.of(context).pop();
                                  }
                                },
                                child: Text(
                                  "Save",
                                  style: TextStyle(
                                      color: Colors.blue, fontSize: 18),
                                ),
                              );
                            } else {
                              return FlatButton(
                                onPressed: null,
                                child: Text(
                                  "Save",
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.black54),
                                ),
                              );
                            }
                          },
                        ))
                  ],
                );
              }
            },
          ),
        ));
  }
}
