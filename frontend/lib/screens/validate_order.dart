import 'package:flutter/material.dart';
import 'package:flutter_project/screens/orders.dart';
import 'package:flutter_project/widgets/tabbar_menu.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ValidateOrder extends StatelessWidget {
  const ValidateOrder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.red,
      appBar: AppBar(
        //backgroundColor: Colors.transparent,
        backgroundColor: Color(0x44000000),
        foregroundColor: Colors.white,
        elevation: 0,
        title: Text('Validar Entrega'),
      ),
      body: MobileScanner(
          allowDuplicates: false,
          onDetect: (barcode, args) {
            if (barcode.rawValue == null) {
              print('Failed to scan QR COde!');
            } else {
              final String code = barcode.rawValue!;
              showDialog(
                context: context,
                barrierDismissible: true,
                builder: (context) => AlertDialog(
                  title: Column(
                    children: [
                      Text('Entrega Validada!'),
                      Text(
                        '$code',
                        style: TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                  actions: [
                    TextButton(
                      child: Text('OK'),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => Orders(
                              isValidated: true,
                            ),
                          ),
                        );
                      },
                    )
                  ],
                ),
              );
            }
          }),
    );
  }
}
