import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample_app/bloc/bloc.dart';

class UserPage extends StatefulWidget {
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  UserBloc bloc = new UserBloc();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: BlocBuilder(
          bloc: bloc,
          builder: (BuildContext context, UserState state) {
            return Center(
              child: Column(
                children: <Widget>[
                  Text("${state.email}"),
                  Text("${state.uuid}"),
                  Text("${state.profilePictureUrl}"),
                  Text("${state.displayName}"),
                  MaterialButton(
                    child: Text("GetUser"),
                    onPressed: () {
                      bloc.getUser();
                    },
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
