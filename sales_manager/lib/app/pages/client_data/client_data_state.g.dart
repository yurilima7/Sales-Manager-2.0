// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'client_data_state.dart';

// **************************************************************************
// MatchExtensionGenerator
// **************************************************************************

extension ClientDataStatusMatch on ClientDataStatus {
  T match<T>(
      {required T Function() initial,
      required T Function() loading,
      required T Function() loaded,
      required T Function() error,
      required T Function() deleting,
      required T Function() deleted}) {
    final v = this;
    if (v == ClientDataStatus.initial) {
      return initial();
    }

    if (v == ClientDataStatus.loading) {
      return loading();
    }

    if (v == ClientDataStatus.loaded) {
      return loaded();
    }

    if (v == ClientDataStatus.error) {
      return error();
    }

    if (v == ClientDataStatus.deleting) {
      return deleting();
    }

    if (v == ClientDataStatus.deleted) {
      return deleted();
    }

    throw Exception('ClientDataStatus.match failed, found no match for: $this');
  }

  T matchAny<T>(
      {required T Function() any,
      T Function()? initial,
      T Function()? loading,
      T Function()? loaded,
      T Function()? error,
      T Function()? deleting,
      T Function()? deleted}) {
    final v = this;
    if (v == ClientDataStatus.initial && initial != null) {
      return initial();
    }

    if (v == ClientDataStatus.loading && loading != null) {
      return loading();
    }

    if (v == ClientDataStatus.loaded && loaded != null) {
      return loaded();
    }

    if (v == ClientDataStatus.error && error != null) {
      return error();
    }

    if (v == ClientDataStatus.deleting && deleting != null) {
      return deleting();
    }

    if (v == ClientDataStatus.deleted && deleted != null) {
      return deleted();
    }

    return any();
  }
}
