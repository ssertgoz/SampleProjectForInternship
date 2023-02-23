part of 'bluetooth_bloc.dart';

abstract class BluetoothEvent {}

class Scan extends BluetoothEvent {}

class Connect extends BluetoothEvent {
  // BluetoothDevice device;
  // Connect({required this.device});
}

class Disconnect extends BluetoothEvent {
  // BluetoothDevice device;
  // Disconnect({required this.device});
}

class RetrieveData extends BluetoothEvent {}
