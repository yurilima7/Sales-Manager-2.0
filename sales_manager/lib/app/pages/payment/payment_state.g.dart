// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_state.dart';

// **************************************************************************
// MatchExtensionGenerator
// **************************************************************************

extension PaymentStatusMatch on PaymentStatus {
  T match<T>(
      {required T Function() initial,
      required T Function() loading,
      required T Function() loaded,
      required T Function() error}) {
    final v = this;
    if (v == PaymentStatus.initial) {
      return initial();
    }

    if (v == PaymentStatus.loading) {
      return loading();
    }

    if (v == PaymentStatus.loaded) {
      return loaded();
    }

    if (v == PaymentStatus.error) {
      return error();
    }

    throw Exception('PaymentStatus.match failed, found no match for: $this');
  }

  T matchAny<T>(
      {required T Function() any,
      T Function()? initial,
      T Function()? loading,
      T Function()? loaded,
      T Function()? error}) {
    final v = this;
    if (v == PaymentStatus.initial && initial != null) {
      return initial();
    }

    if (v == PaymentStatus.loading && loading != null) {
      return loading();
    }

    if (v == PaymentStatus.loaded && loaded != null) {
      return loaded();
    }

    if (v == PaymentStatus.error && error != null) {
      return error();
    }

    return any();
  }
}
