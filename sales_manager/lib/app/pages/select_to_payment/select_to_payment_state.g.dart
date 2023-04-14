// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'select_to_payment_state.dart';

// **************************************************************************
// MatchExtensionGenerator
// **************************************************************************

extension SelectToPaymentStatusMatch on SelectToPaymentStatus {
  T match<T>(
      {required T Function() initial,
      required T Function() loading,
      required T Function() loaded,
      required T Function() error}) {
    final v = this;
    if (v == SelectToPaymentStatus.initial) {
      return initial();
    }

    if (v == SelectToPaymentStatus.loading) {
      return loading();
    }

    if (v == SelectToPaymentStatus.loaded) {
      return loaded();
    }

    if (v == SelectToPaymentStatus.error) {
      return error();
    }

    throw Exception(
        'SelectToPaymentStatus.match failed, found no match for: $this');
  }

  T matchAny<T>(
      {required T Function() any,
      T Function()? initial,
      T Function()? loading,
      T Function()? loaded,
      T Function()? error}) {
    final v = this;
    if (v == SelectToPaymentStatus.initial && initial != null) {
      return initial();
    }

    if (v == SelectToPaymentStatus.loading && loading != null) {
      return loading();
    }

    if (v == SelectToPaymentStatus.loaded && loaded != null) {
      return loaded();
    }

    if (v == SelectToPaymentStatus.error && error != null) {
      return error();
    }

    return any();
  }
}
