import 'package:flutter/material.dart';
import 'package:worm/model/paymentModel.dart';
import 'package:worm/page/pembayaran/detailPayment.dart';
import 'package:worm/page/pembayaran/payment.dart';
import 'package:worm/widgets/navbar.dart';
import 'package:worm/page/detailJadwal.dart';
import 'package:worm/page/FormEditJadwal.dart';
import 'package:worm/page/jadwalPage.dart';
import 'package:worm/page/pembayaran/editPayment.dart';
import 'package:worm/page/pembayaran/tambahDetailPayment.dart';
import 'package:worm/page/pembayaran/editDetailPayment.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WORM',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color.fromRGBO(246, 246, 246, 1),
        fontFamily: 'Poppins',
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => navbar(index: 0),
        '/detail-page': (context) => detailJadwal(),
        '/edit-jadwal': (context) => editJadwal(),
        '/jadwal-page': (context) => jadwalPage(),
        '/detail-payment': (context) => detailPayment(),
        '/payment-page': (context) => PagePayment(),
        '/edit-payment': (context) => editPayment(),
        '/tambahDetail-payment': (context) => uploadPayment(),
        '/editDetail-payment': (context) => editDetailPayment(),
      },
    );
  }
}
