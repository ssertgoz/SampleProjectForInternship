import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
part 'bluetooth_event.dart';
part 'bluetooth_state.dart';

class BluetoothBloc extends Bloc<BluetoothEvent, BluetoothState> {
  BluetoothBloc() : super(BluetoothState.initial()) {
    on<Connect>(_onConnect);
    on<Disconnect>(_onDisconnect);
    on<RetrieveData>(_onRetrieveData);
  }

  _onConnect(
    Connect event,
    Emitter<BluetoothState> emit,
  ) {
    emit(BluetoothState.initial());
  }

  _onDisconnect(
    Disconnect event,
    Emitter<BluetoothState> emit,
  ) {
    emit(BluetoothState.initial());
  }

  _onRetrieveData(
    RetrieveData event,
    Emitter<BluetoothState> emit,
  ) {
    emit(BluetoothState.initial());
  }
}
