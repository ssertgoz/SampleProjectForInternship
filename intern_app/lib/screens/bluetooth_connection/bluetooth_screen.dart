import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../blocs/bluetooth/bluetooth_bloc.dart';
import '../retrieve_data/retrieve_data_screen.dart';

class BluetoothScreen extends StatelessWidget {
  const BluetoothScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: BlocProvider(
          create: (context) => BluetoothBloc(),
          child: BlocBuilder<BluetoothBloc, BluetoothState>(
            builder: (context, bluetoothState) {
              return Column(
                  // children: [
                  //   bluetoothState.status == BluetoothStatus.scanning
                  //       ? Container()
                  //       : Expanded(
                  //           child: Center(
                  //             child: FittedBox(
                  //               child: Text(
                  //                 "Cihazlar",
                  //                 style: TextStyle(fontSize: height * 0.03),
                  //               ),
                  //             ),
                  //           ),
                  //         ),
                  //   Expanded(
                  //     flex: 5,
                  //     child: bluetoothState.status == BluetoothStatus.scanning
                  //         ? Center(
                  //             child: Column(
                  //             mainAxisAlignment: MainAxisAlignment.center,
                  //             children: [
                  //               SpinKitDoubleBounce(
                  //                 size: height * 0.1,
                  //                 color: Colors.amber,
                  //               ),
                  //               FittedBox(
                  //                 child: Text(
                  //                   "Cihazlar aranıyor",
                  //                   style: TextStyle(fontSize: height * 0.03),
                  //                 ),
                  //               )
                  //             ],
                  //           ))
                  //         : ListView.builder(
                  //             itemCount: 5,
                  //             itemBuilder: ((context, index) => Container(
                  //                   padding: EdgeInsets.symmetric(
                  //                       horizontal: height * 0.03,
                  //                       vertical: height * 0.01),
                  //                   height: height * 0.1,
                  //                   child: ElevatedButton(
                  //                     onPressed: () {
                  //                       Navigator.of(context).push(
                  //                           MaterialPageRoute(
                  //                               builder: (context) =>
                  //                                   const RetrieveDataScreen()));
                  //                     },
                  //                     style: ElevatedButton.styleFrom(
                  //                         backgroundColor: Colors.amber),
                  //                     child: Padding(
                  //                       padding: EdgeInsets.all(height * 0.01),
                  //                       child: Row(
                  //                         children: [
                  //                           Expanded(
                  //                               flex: 4,
                  //                               child: Text(
                  //                                 "Cihaz $index",
                  //                                 style: TextStyle(
                  //                                     fontSize: height * 0.03),
                  //                               )),
                  //                         ],
                  //                       ),
                  //                     ),
                  //                   ),
                  //                 ))),
                  //   ),
                  // ],
                  );
            },
          ),
        ),
      ),
    );
  }
}
