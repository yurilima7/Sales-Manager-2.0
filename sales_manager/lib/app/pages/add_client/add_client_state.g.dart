// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_client_state.dart';

// **************************************************************************
// MatchExtensionGenerator
// **************************************************************************

extension AddClientStatusMatch on AddClientStatus {
  T match<T>(
      {required T Function() initial,
      required T Function() registering,
      required T Function() registered,
      required T Function() error}) {
    final v = this;
    if (v == AddClientStatus.initial) {
      return initial();
    }

    if (v == AddClientStatus.registering) {
      return registering();
    }

    if (v == AddClientStatus.registered) {
      return registered();
    }

    if (v == AddClientStatus.error) {
      return error();
    }

    throw Exception('AddClientStatus.match failed, found no match for: $this');
  }

  T matchAny<T>(
      {required T Function() any,
      T Function()? initial,
      T Function()? registering,
      T Function()? registered,
      T Function()? error}) {
    final v = this;
    if (v == AddClientStatus.initial && initial != null) {
      return initial();
    }

    if (v == AddClientStatus.registering && registering != null) {
      return registering();
    }

    if (v == AddClientStatus.registered && registered != null) {
      return registered();
    }

    if (v == AddClientStatus.error && error != null) {
      return error();
    }

    return any();
  }
}
