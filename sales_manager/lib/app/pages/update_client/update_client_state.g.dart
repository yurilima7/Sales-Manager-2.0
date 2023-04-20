// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_client_state.dart';

// **************************************************************************
// MatchExtensionGenerator
// **************************************************************************

extension UpdateClientStatusMatch on UpdateClientStatus {
  T match<T>(
      {required T Function() initial,
      required T Function() updating,
      required T Function() updated,
      required T Function() error}) {
    final v = this;
    if (v == UpdateClientStatus.initial) {
      return initial();
    }

    if (v == UpdateClientStatus.updating) {
      return updating();
    }

    if (v == UpdateClientStatus.updated) {
      return updated();
    }

    if (v == UpdateClientStatus.error) {
      return error();
    }

    throw Exception(
        'UpdateClientStatus.match failed, found no match for: $this');
  }

  T matchAny<T>(
      {required T Function() any,
      T Function()? initial,
      T Function()? updating,
      T Function()? updated,
      T Function()? error}) {
    final v = this;
    if (v == UpdateClientStatus.initial && initial != null) {
      return initial();
    }

    if (v == UpdateClientStatus.updating && updating != null) {
      return updating();
    }

    if (v == UpdateClientStatus.updated && updated != null) {
      return updated();
    }

    if (v == UpdateClientStatus.error && error != null) {
      return error();
    }

    return any();
  }
}
