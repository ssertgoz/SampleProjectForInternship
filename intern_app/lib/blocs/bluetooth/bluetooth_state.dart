// ignore_for_file: must_be_immutable
part of 'bluetooth_bloc.dart';

enum BluetoothStatus {
  scanning,
  connected,
  disconnected,
  retrievingData,
  dataRetrieved
}

class BluetoothState {
  BluetoothState({
    required this.status,
    //required this.devices,
  });
  BluetoothStatus status;
  //List<BluetoothDevice> devices;

  factory BluetoothState.initial() {
    return BluetoothState(
      status: BluetoothStatus.disconnected, //devices: <BluetoothDevice>[]
    );
  }

  BluetoothState copyWith(
      {BluetoothStatus? status, //List<BluetoothDevice>?
      devices}) {
    return BluetoothState(
      status: status ?? this.status,
      //devices: devices ?? this.devices,
    );
  }
}
