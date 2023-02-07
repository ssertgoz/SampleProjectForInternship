import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../blocs/bluetooth/bluetooth_bloc.dart';

class RetrieveDataScreen extends StatelessWidget {
  const RetrieveDataScreen({Key? key}) : super(key: key);

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
                children: [
                  Visibility(
                    visible:
                        bluetoothState.status != BluetoothStatus.dataRetrieved,
                    child: Expanded(
                      child: Center(
                        child: FittedBox(
                          child: Text(
                            "Veriler",
                            style: TextStyle(fontSize: height * 0.03),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child:
                        bluetoothState.status == BluetoothStatus.retrievingData
                            ? Center(
                                child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SpinKitDoubleBounce(
                                    size: height * 0.1,
                                    color: Colors.amber,
                                  ),
                                  FittedBox(
                                    child: Text(
                                      "Veriler Alınıyor",
                                      style: TextStyle(fontSize: height * 0.03),
                                    ),
                                  )
                                ],
                              ))
                            : ListView.builder(
                                itemCount: 5,
                                itemBuilder: ((context, index) => Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: height * 0.03,
                                          vertical: height * 0.01),
                                      height: height * 0.1,
                                      child: Padding(
                                        padding: EdgeInsets.all(height * 0.01),
                                        child: Row(
                                          children: [
                                            Expanded(
                                                flex: 4,
                                                child: Text(
                                                  "Veri $index",
                                                  style: TextStyle(
                                                      fontSize: height * 0.03),
                                                )),
                                          ],
                                        ),
                                      ),
                                    ))),
                  ),
                  Visibility(
                    visible:
                        bluetoothState.status != BluetoothStatus.dataRetrieved,
                    child: Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: height * 0.01, vertical: height * 0.02),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    const RetrieveDataScreen()));
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.amber),
                          child: Padding(
                              padding: EdgeInsets.all(height * 0.01),
                              child: Text(
                                "Firebase'de Gör",
                                style: TextStyle(fontSize: height * 0.03),
                              )),
                        ),
                      ),
                    ),
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
