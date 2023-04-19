// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_data_state.dart';

// **************************************************************************
// MatchExtensionGenerator
// **************************************************************************

extension ProductDataStatusMatch on ProductDataStatus {
  T match<T>(
      {required T Function() initial,
      required T Function() loading,
      required T Function() loaded,
      required T Function() updating,
      required T Function() updated,
      required T Function() error}) {
    final v = this;
    if (v == ProductDataStatus.initial) {
      return initial();
    }

    if (v == ProductDataStatus.loading) {
      return loading();
    }

    if (v == ProductDataStatus.loaded) {
      return loaded();
    }

    if (v == ProductDataStatus.updating) {
      return updating();
    }

    if (v == ProductDataStatus.updated) {
      return updated();
    }

    if (v == ProductDataStatus.error) {
      return error();
    }

    throw Exception(
        'ProductDataStatus.match failed, found no match for: $this');
  }

  T matchAny<T>(
      {required T Function() any,
      T Function()? initial,
      T Function()? loading,
      T Function()? loaded,
      T Function()? updating,
      T Function()? updated,
      T Function()? error}) {
    final v = this;
    if (v == ProductDataStatus.initial && initial != null) {
      return initial();
    }

    if (v == ProductDataStatus.loading && loading != null) {
      return loading();
    }

    if (v == ProductDataStatus.loaded && loaded != null) {
      return loaded();
    }

    if (v == ProductDataStatus.updating && updating != null) {
      return updating();
    }

    if (v == ProductDataStatus.updated && updated != null) {
      return updated();
    }

    if (v == ProductDataStatus.error && error != null) {
      return error();
    }

    return any();
  }
}
