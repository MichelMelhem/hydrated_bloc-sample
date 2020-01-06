import 'dart:async';

import 'package:hydrated_bloc/hydrated_bloc.dart';

class UserBloc extends HydratedBloc<UserEvent, UserState> {
  StreamSubscription userBlocSubscription;

  void getUser() {
    add(GetUser());
  }

  @override
  UserState get initialState {
    return super.initialState ?? UserState.initial();
  }

  @override
  Stream<UserState> mapEventToState(UserEvent event) async* {
    if (event is GetUser) {
      try {
        yield UserState().copyWith(isFetching: true);

        yield state.copyWith(
            email: "email",
            isFetching: false,
            displayName: "displayName",
            isEmailVerified: true,
            profilePictureUrl: "an url",
            uuid: "uuid",
            token: "fqfqfqfw");
      } catch (error) {
        yield UserState().copyWith(
          error: "An error occured",
          isFetching: false,
        );
      }
    }
  }

  @override
  UserState fromJson(Map<String, dynamic> source) {
    try {
      return UserState(
        email: source['email'],
        isEmailVerified: source['isEmailVerified'],
        displayName: source['displayName'],
        uuid: source['uuid'],
        profilePictureUrl: source['profilePictureUrl'],
        token: source['token'],
      );
    } catch (_) {
      return null;
    }
  }

  @override
  Map<String, dynamic> toJson(UserState state) {
    try {
      return {
        'email': state.email,
        'isEmailVerified': state.isEmailVerified,
        'displayName': state.displayName,
        'uuid': state.uuid,
        'profilePictureUrl': state.profilePictureUrl,
        'token': state.token
      };
    } catch (_) {
      return null;
    }
  }

  @override
  Future<void> close() {
    userBlocSubscription.cancel();
    return super.close();
  }
}

class UserState {
  final bool isFetching;
  final String error;
  final String displayName;
  final String uuid;
  final String email;
  final String profilePictureUrl;
  final bool isEmailVerified;
  final String token;

  const UserState(
      {this.isFetching,
      this.error,
      this.displayName,
      this.email,
      this.uuid,
      this.profilePictureUrl,
      this.isEmailVerified,
      this.token});

  factory UserState.initial() => UserState(
      isFetching: false,
      displayName: "",
      email: "",
      uuid: "",
      profilePictureUrl: "",
      token: "",
      isEmailVerified: false);

  UserState copyWith({
    String token,
    bool isFetching,
    String error,
    String profilePictureUrl,
    bool isEmailVerified,
    String displayName,
    String email,
    String uuid,
  }) {
    return UserState(
        isFetching: isFetching ?? this.isFetching,
        error: error ?? this.error,
        profilePictureUrl: profilePictureUrl ?? this.profilePictureUrl,
        isEmailVerified: isEmailVerified ?? this.isEmailVerified,
        displayName: displayName ?? this.displayName,
        uuid: uuid ?? this.uuid,
        email: email ?? this.email,
        token: token ?? this.token);
  }
}

abstract class UserEvent {}

class GetUser extends UserEvent {}

class UpdateUser extends UserEvent {
  String email;
  String displayName;

  UpdateUser(this.displayName, this.email);
}
