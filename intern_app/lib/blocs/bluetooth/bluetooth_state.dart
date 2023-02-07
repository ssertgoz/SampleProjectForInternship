// ignore_for_file: must_be_immutable
part of 'bluetooth_bloc.dart';

enum BluetoothStatus {
  searching,
  connected,
  disconnected,
  retrievingData,
  dataRetrieved
}

class BluetoothState {
  BluetoothState({
    required this.status,
  });

  BluetoothStatus status;

  factory BluetoothState.initial(
      {questions, currentQuestionIndex, solvedOptionIDs, questionsStates}) {
    return BluetoothState(
      status: BluetoothStatus.disconnected,
    );
  }

  BluetoothState copyWith({
    BluetoothStatus? status,
  }) {
    return BluetoothState(
      status: status ?? this.status,
    );
  }
}
