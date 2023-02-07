part of 'bluetooth_bloc.dart';

@immutable
abstract class BluetoothEvent {}

class Connect extends BluetoothEvent {}

class Disconnect extends BluetoothEvent {}

class RetrieveData extends BluetoothEvent {}
