// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:worm/page/jadwalPage.dart';
import 'package:worm/widgets/navbar.dart';
import 'package:worm/service/sceduleService.dart';
import 'package:worm/widgets/date.dart';
import 'package:intl/intl.dart';

class tambahJadwal extends StatefulWidget {
  const tambahJadwal({Key? key}) : super(key: key);

  @override
  State<tambahJadwal> createState() => _tambahJadwalState();
}

class _tambahJadwalState extends State<tambahJadwal> {
  TextEditingController _nameKegiatanController = TextEditingController();
  TextEditingController _detailKegiatanController = TextEditingController();
  TextEditingController _tanggalController = TextEditingController();
  TextEditingController _jamController = TextEditingController();
  TextEditingController _tempatController = TextEditingController();

  TimeOfDay time = TimeOfDay.now();
  void showTime() {
    showTimePicker(context: context, initialTime: TimeOfDay.now())
        .then((value) {
      setState(() {
        _jamController.text = value!.format(context).toString();
      });
    });
  }

  DateTime tanggal = DateTime.now();
  final TextStyle valueStyle = TextStyle(fontSize: 16.0);
  Future<Null> _selectDate(BuildContext context) async {
    // Initial DateTime FIinal Picked
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: tanggal,
        firstDate: DateTime(2015),
        lastDate: DateTime(2101));

    if (picked != null && picked != tanggal)
      setState(() {
        _tanggalController.text = picked.toString();
        tanggal = picked;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const Padding(padding: EdgeInsets.all(16.0)),
          Container(
            margin: const EdgeInsets.only(top: 16, right: 16, left: 16),
            height: 70,
            child: Row(
              children: <Widget>[
                Container(
                  height: 48,
                  width: 48,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 1,
                        offset: Offset(0, 0),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                          alignment: Alignment.centerRight,
                          onPressed: () => Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return navbar(index: 2);
                              })),
                          icon: const Icon(
                            Icons.arrow_back_ios,
                            size: 22,
                          )),
                    ],
                  ),
                ),
                const Padding(padding: EdgeInsets.only(left: 15)),
                const Text(
                  "Tambah Jadwal",
                  style: TextStyle(
                    color: Color.fromARGB(255, 24, 24, 24),
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                )
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 30, right: 16, left: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Nama Kegiatan",
                ),
                TextField(
                  controller: _nameKegiatanController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 20, right: 16, left: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Detail Kegiatan",
                ),
                TextField(
                  controller: _detailKegiatanController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),
          // Container(
          //   margin: const EdgeInsets.only(top: 20, right: 16, left: 16),
          //   child: DateTimePicker(
          //     dateMask: 'd MMM, yyyy',
          //     initialValue: DateTime.now().toString(),
          //     firstDate: DateTime(2000),
          //     lastDate: DateTime(2100),
          //     icon: const Icon(Icons.event),
          //     dateLabelText: 'Tanggal pelaksanaan',
          //     selectableDayPredicate: (date) {
          //       // Disable weekend days to select from the calendar
          //       if (date.weekday == 6 || date.weekday == 7) {
          //         return false;
          //       }
          //       return true;
          //     },
          //     onChanged: (val) => setState(() => _tanggalController.text = val),
          //     validator: (val) {
          //       print(val);
          //       return null;
          //     },
          //     onSaved: (val) => _tanggalController,
          //   ),
          // ),
          Container(
            margin: const EdgeInsets.only(top: 20, right: 16, left: 16),
            child: Column(children: [
              Divider(
                color: Colors.black,
              ),
              DateDropDown(
              labelText: "tanggal kegiatan",
              valueText: DateFormat.yMd().format(tanggal),
              valueStyle: valueStyle,
              onPressed: () {
                _selectDate(context);
              },
            ),
            ]),
          ),
          Container(
            margin: const EdgeInsets.only(top: 20, right: 16, left: 16),
            child: Column(children: [
              Divider(
                color: Colors.black,
              ),
              Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                  Column(children: [
                    Text("Jam"),
                IconButton(
                  onPressed: showTime,
                  icon: const Icon(Icons.timer),
                ),
                  ]),
                  Text("\n\n" + _jamController.text),
              ],
            ),
              Divider(
                color: Colors.black,
              ),
            ]),
          ),
          Container(
            margin: const EdgeInsets.only(top: 20, right: 16, left: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Tempat Kegiatan",
                ),
                TextField(
                  controller: _tempatController,
                  // obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 10, right: 20),
            child: Column(
              children: <Widget>[
                ElevatedButton(
                    onPressed: () async {
                      Map<String, dynamic> body = {
                        'nama_kegiatan': _nameKegiatanController.text,
                        'detail_kegiatan': _detailKegiatanController.text,
                        'tanggal': _tanggalController.text,
                        'jam': _jamController.text,
                        'tempat': _tempatController.text,
                      };

                      await SceduleService().createSchedule(body).then((value) {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return navbar(index: 1);
                        }));
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text(
                                    'You have successfully create a scedule')));
                      });
                    },
                    child: const Text(
                      'Save',
                      style: TextStyle(
                        color: Color.fromRGBO(
                          254,
                          204,
                          118,
                          1,
                        ),
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(255, 0, 0, 0),
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
