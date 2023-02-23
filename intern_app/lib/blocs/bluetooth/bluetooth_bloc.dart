// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:intern_app/common/constants.dart';
part 'bluetooth_event.dart';
part 'bluetooth_state.dart';

class BluetoothBloc extends Bloc<BluetoothEvent, BluetoothState> {
  //FlutterBluePlus flutterBlue = FlutterBluePlus.instance;

  BluetoothBloc() : super(BluetoothState.initial()) {
    on<Scan>(_onScan);
    on<Connect>(_onConnect);
    on<Disconnect>(_onDisconnect);
    on<RetrieveData>(_onRetrieveData);
  }

  _onScan(
    Scan event,
    Emitter<BluetoothState> emit,
  ) {
    // emit(state.copyWith(status: BluetoothStatus.scanning));
    // List<BluetoothDevice> devices = [];
    // flutterBlue.startScan(timeout: const Duration(seconds: scanTimeOut));

    // flutterBlue.scanResults.listen((results) {
    //   for (ScanResult r in results) {
    //     devices.add(r.device);
    //     //print('${r.device.name} found! rssi: ${r.rssi}');
    //   }
    // });

    // flutterBlue.stopScan();
    // emit(
    //     state.copyWith(devices: devices, status: BluetoothStatus.disconnected));
  }

  _onConnect(
    Connect event,
    Emitter<BluetoothState> emit,
  ) async {
    // List<BluetoothService> services = await event.device.discoverServices();
    // // services.forEach((service) {
    // //   service.characteristics[0]
    // // });
    // event.device.connect();
    // emit(state.copyWith(status: BluetoothStatus.connected));
  }

  _onDisconnect(
    Disconnect event,
    Emitter<BluetoothState> emit,
  ) {
    // event.device.disconnect();
    // emit(state.copyWith(status: BluetoothStatus.disconnected));
  }

  _onRetrieveData(
    RetrieveData event,
    Emitter<BluetoothState> emit,
  ) {
    //emit(BluetoothState.initial());
  }
}
