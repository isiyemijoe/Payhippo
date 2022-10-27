import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:payhippo/_core_/network/resource.dart';

class NetworkBoundResource {
  Stream<Resource<T?>> networkBoundResource<T>({
    bool shouldLoadFromLocal = false,
    bool Function(T?)? shouldLoadFromRemote,
    Stream<T?> Function()? fromLocal,
    required Future<T?> Function() fromRemote,
    Future<T?> Function(T? response)? onRemoteDataFetched,
  }) async* {
    if (false == shouldLoadFromLocal) {
      yield Resource.loading(null);
    }

    T? localData;
    var doRemoteFetch = true;

    if (shouldLoadFromLocal) {
      final localStream = _fetchFromLocalOnce(fromLocal, shouldLoadFromRemote);
      await for (final event in localStream) {
        localData = event.data;
        yield event;
      }

      doRemoteFetch = shouldLoadFromRemote?.call(localData) ?? doRemoteFetch;
    }

    if (false == shouldLoadFromLocal) {
      doRemoteFetch = shouldLoadFromRemote?.call(localData) ?? doRemoteFetch;
    }
    if (!doRemoteFetch) return;

    try {
      final response = await fromRemote();

      if (null == response) {
        yield Resource.success(null);
        return;
      }

      final result = await onRemoteDataFetched?.call(response) ?? response;
      print(response);
      if (shouldLoadFromLocal && fromLocal != null) {
        await for (final event in fromLocal()) {
          yield Resource.success(event);
          break;
        }
      } else {
        yield Resource.success(result);
      }
    } on DioError catch (e, _) {
      final error = Error(e, 'error occured', '');
      yield Resource.error(err: error);
    }
  }

  Stream<Resource<R?>> _fetchFromLocalOnce<R>(
    Stream<R?> Function()? fromLocal,
    bool Function(R?)? shouldFetchFromRemote,
  ) async* {
    yield Resource.loading(null);

    if (fromLocal != null) {
      await for (final data in fromLocal()) {
        final doRemoteFetch = shouldFetchFromRemote?.call(data) ?? true;

        final isAList = data is List;

        if (doRemoteFetch && isAList && data.isNotEmpty) {
          yield Resource.loading(data);
        } else if (doRemoteFetch && !isAList && null != data) {
          yield Resource.loading(data);
        } else if (false == doRemoteFetch) {
          yield Resource.success(data);
        }
        break;
      }
    } else {
      yield Resource.success(null);
    }

    return;
  }
}
