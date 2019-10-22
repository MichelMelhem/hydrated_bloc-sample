import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample_app/AddPlanToStageForm.dart';
import 'package:sample_app/bloc/bloc.dart';
import 'package:sample_app/models/Plan.model.dart';

class StagePage extends StatefulWidget {
  StagePage({Key key}) : super(key: key);
  @override
  _StagePageState createState() => _StagePageState();
}

class _StagePageState extends State<StagePage> {
  TestBloc bloc = new TestBloc();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
        bloc: bloc,
        builder: (BuildContext context, CounterState state) {
          return Scaffold(
              appBar: AppBar(
                title: Text("${state.stage.name}"),
                actions: <Widget>[
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => AddPlanToStageForm(bloc)),
                      );
                    },
                    icon: Icon(Icons.add),
                  ),
                ],
                centerTitle: true,
              ),
              body: Builder(
                builder: (BuildContext context) {
                  if (state.stage.plans.isEmpty) {
                    return Container(
                      child: new Center(
                        child: Text(
                          '+ for adding plan(s)',
                          style: TextStyle(color: Colors.black54),
                        ),
                      ),
                    );
                  } else {
                    return ListView(
                      children: <Widget>[
                        Card(
                          child: ListView.separated(
                            physics: const NeverScrollableScrollPhysics(),
                            separatorBuilder: (BuildContext context, index) {
                              return Divider();
                            },
                            shrinkWrap: true,
                            itemCount: state.stage.plans.length,
                            itemBuilder: (BuildContext context, index) {
                              Plan plan = state.stage.plans[index];
                              return ListTile(
                                trailing: Icon(Icons.delete),
                                onTap: () {
                                  bloc.deletePlan(index);
                                },
                                title: Text("${state.stage.plans[index].name}"),
                              );
                            },
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Text(
                            "As you can see sometimes the page do not refresh automaticly, test multiples time for get the behaviour, sometimes it work just nice for no reasons",
                            style: TextStyle(color: Colors.blue),
                          ),
                        )
                      ],
                    );
                  }
                },
              ));
        });
  }
}
