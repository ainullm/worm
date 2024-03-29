import 'dart:async';

import 'package:flutter/material.dart';
import 'package:worm/page/pembayaran/detailPayment.dart';
import 'package:worm/model/paymentModel.dart';
import 'package:worm/page/pembayaran/tambahPayment.dart';
import 'package:worm/service/paymentService.dart';
import 'package:worm/format/formatAngka.dart';
import 'package:intl/intl.dart';

class PagePayment extends StatefulWidget {
  static final url = "/payment-page";
  const PagePayment({Key? key}) : super(key: key);

  @override
  State<PagePayment> createState() => _PagePayment();
}

class _PagePayment extends State<PagePayment> {
  late Future<Payment> _payments;
  int id = 0;

  @override
  void initState() {
    super.initState();
    _payments = PaymentService().getAllPayment();
  }

  void refreshData() {
    id++;
  }

  FutureOr onGoBack(dynamic value) {
    refreshData();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(padding: EdgeInsets.all(18.0)),
            Padding(padding: EdgeInsets.only(top: 8)),
            Container(
              margin: const EdgeInsets.only(top: 16, bottom: 16, left: 16),
              child: Container(
                  child: Row(
                children: [
                  Text(
                      "Rekap Pembayaran",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: Color.fromARGB(255, 24, 24, 24),
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                    ),
                  ),
                  const Padding(padding: EdgeInsets.only(left: 60)),
                  IconButton(
                      alignment: Alignment.bottomRight,
                      color: Colors.amber,
                      onPressed: () => Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return const tambahPayment();
                          })),
                      icon: const Icon(Icons.add)),
                ],
              )),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.79,
              child: FutureBuilder(
                future: _payments,
                builder: (context, AsyncSnapshot<Payment> snapshot) {
                  var state = snapshot.connectionState;
                  if (state != ConnectionState.done) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          var payment = snapshot.data!.data[index];
                          return InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, detailPayment.url,
                                  arguments: payment);
                            },
                            child: listItem(payment),
                          );
                        },
                        itemCount: snapshot.data!.data.length,
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text(
                          snapshot.error.toString(),
                        ),
                      );
                    } else {
                      return Text('');
                    }
                  }
                },
              ),
            ),
          ]),
    );
  }

  Widget listItem(payments view) {
    String tanggal = DateFormat.yMd().format(view.tanggal);
    return Container(
      margin: const EdgeInsets.only(right: 16, left: 16, bottom: 8),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 2,
              offset: Offset(0, 0), // Shadow position
            ),
          ],
        ),
        child: Column(
          children: <Widget>[
            ListTile(
              title: Text(tanggal),
              trailing: view.keterangan != "lunas"
                  ? Text(
                      view.keterangan,
                      style: TextStyle(color: Colors.red),
                    )
                  : Text(
                      view.keterangan,
                      style: TextStyle(color: Colors.green),
                    ),
            ),
            Divider(
              color: Colors.grey,
            ),
            ListTile(
              title: Text(view.namaVendor),
              subtitle: Text(
                formatAngka.convertToIdr(int.parse(view.tunaiKeseluruhan), 2),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Divider(
              color: Colors.grey,
            ),
            ListTile(
              title: Text(
                view.keterangan,
                style: TextStyle(color: Color(0xFF666D66)),
              ),
              trailing: Text(
                formatAngka.convertToIdr(int.parse(view.tunai), 2),
                style: TextStyle(color: Colors.green),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
