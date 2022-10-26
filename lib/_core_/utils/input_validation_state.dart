import 'package:flutter/material.dart' hide Colors;
import 'package:payhippo/_core_/network/resource.dart';
import 'package:payhippo/_core_/views/styles/app_colors.dart';
import 'package:rxdart/rxdart.dart';

///@author Paul Okeke

abstract class InputValidationState {
  InputValidationState({required this.data, this.errorMessage});

  final String data;
  final String? errorMessage;

  Widget render() => const SizedBox.shrink();

  ///For general use cases
  static Stream<Resource<T>> validate<T>(
    Stream<Resource<T>> stream,
    BehaviorSubject<InputValidationState> subject,
    String originValue,
  ) async* {
    await for (final event in stream) {
      if (event is Loading) {
        subject.add(InputValidationLoadingState(data: originValue));
      } else if (event is Success) {
        subject.add(InputValidationSuccessState(data: originValue));
      } else if (event is Error<T>) {
        subject.add(InputValidationErrorState(
            data: originValue, errorMessage: event.message));
      }
      yield event;
    }
  }
}

///-----------------------------------------------------------------------------
///-----------------------------------------------------------------------------
class InputValidationDefaultState extends InputValidationState {
  InputValidationDefaultState({required String data, String? errorMessage})
      : super(data: data, errorMessage: errorMessage);
}

///-----------------------------------------------------------------------------
///-----------------------------------------------------------------------------
class InputValidationLoadingState extends InputValidationState {
  InputValidationLoadingState({required String data, String? errorMessage})
      : super(data: data, errorMessage: errorMessage);

  @override
  Widget render() {
    return const SizedBox(
      width: 40,
      height: 40,
      child: CircularProgressIndicator(
        color: AppColors.blue0,
      ),
    );
  }
}

///-----------------------------------------------------------------------------
///-----------------------------------------------------------------------------
class InputValidationSuccessState extends InputValidationState {
  InputValidationSuccessState({required String data, String? errorMessage})
      : super(data: data, errorMessage: errorMessage);
}

///-----------------------------------------------------------------------------
///-----------------------------------------------------------------------------
class InputValidationErrorState extends InputValidationState {
  InputValidationErrorState({required String data, String? errorMessage})
      : super(data: data, errorMessage: errorMessage);
}
