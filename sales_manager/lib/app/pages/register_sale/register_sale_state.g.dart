// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_sale_state.dart';

// **************************************************************************
// MatchExtensionGenerator
// **************************************************************************

extension RegisterSaleStatusMatch on RegisterSaleStatus {
  T match<T>(
      {required T Function() initial,
      required T Function() registering,
      required T Function() registered,
      required T Function() loading,
      required T Function() loaded,
      required T Function() error}) {
    final v = this;
    if (v == RegisterSaleStatus.initial) {
      return initial();
    }

    if (v == RegisterSaleStatus.registering) {
      return registering();
    }

    if (v == RegisterSaleStatus.registered) {
      return registered();
    }

    if (v == RegisterSaleStatus.loading) {
      return loading();
    }

    if (v == RegisterSaleStatus.loaded) {
      return loaded();
    }

    if (v == RegisterSaleStatus.error) {
      return error();
    }

    throw Exception(
        'RegisterSaleStatus.match failed, found no match for: $this');
  }

  T matchAny<T>(
      {required T Function() any,
      T Function()? initial,
      T Function()? registering,
      T Function()? registered,
      T Function()? loading,
      T Function()? loaded,
      T Function()? error}) {
    final v = this;
    if (v == RegisterSaleStatus.initial && initial != null) {
      return initial();
    }

    if (v == RegisterSaleStatus.registering && registering != null) {
      return registering();
    }

    if (v == RegisterSaleStatus.registered && registered != null) {
      return registered();
    }

    if (v == RegisterSaleStatus.loading && loading != null) {
      return loading();
    }

    if (v == RegisterSaleStatus.loaded && loaded != null) {
      return loaded();
    }

    if (v == RegisterSaleStatus.error && error != null) {
      return error();
    }

    return any();
  }
}
