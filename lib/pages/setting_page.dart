import 'package:bagaskara_redefined/bloc/aksara/aksara_bloc.dart';
import 'package:bagaskara_redefined/bloc/aksara/aksara_event.dart';
import 'package:bagaskara_redefined/bloc/aksara/aksara_state.dart';
import 'package:bagaskara_redefined/utils/utilities.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  AksaraBloc _aksaraBloc;
  Utilities _utils = Utilities();

  @override
  void initState() {
    super.initState();
    _aksaraBloc = AksaraBloc();
    _aksaraBloc.add(InitSettings());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Pengaturan"),
        ),
        body: BlocBuilder<AksaraBloc, AksaraState>(
            bloc: _aksaraBloc,
            builder: (context, state) {
              return SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        if (state is AksaraToggleState) {
                          _utils.setMurdha(!state.isMurdha);
                          setState(() {
                            state.isMurdha = !state.isMurdha;
                          });
                        }
                      },
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: SizedBox(
                          width: double.infinity,
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                  child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    "Gunakan Aksara murdha",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text("Jika menyala, aksara murdha akan digunakan.")
                                ],
                              )),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  Switch(
                                      value: (state is AksaraToggleState)
                                          ? state.isMurdha
                                          : false,
                                      onChanged: (e) {
                                        if (state is AksaraToggleState) {
                                          _utils.setMurdha(!state.isMurdha);
                                          setState(() {
                                            state.isMurdha = !state.isMurdha;
                                          });
                                        }
                                      })
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Divider(),
                    InkWell(
                      onTap: () {
                        if (state is AksaraToggleState) {
                          _utils.setCopas(!state.isCopas);
                          setState(() {
                            state.isCopas = !state.isCopas;
                          });
                        }
                      },
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: SizedBox(
                          width: double.infinity,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      "Gunakan é untuk taling dan e untuk pepet",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                        "Anda bisa kopipas dari artikel yang menggunakan huruf 'e' beraksen (è/é), misalnya dari artikel Wikipedia bahasa Jawa."+
                                         " Anda juga bisa menggunakan mode ini untuk mengetik kata-kata dalam bahasa Indonesia, misalnya, karena mayoritas huruf 'e' dalam bahasa Indonesia (terutama imbuhan), adalah pepet. Jika dimatikan, gunakan x untuk pepet")
                                  ],
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  Switch(
                                    value: (state is AksaraToggleState)
                                        ? state.isCopas
                                        : false,
                                    onChanged: (e) {
                                      if (state is AksaraToggleState) {
                                        _utils.setCopas(!state.isCopas);
                                        setState(() {
                                          state.isCopas = !state.isCopas;
                                        });
                                      }
                                    },
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),

                    Divider(),

                    InkWell(
                      onTap: () {
                        if (state is AksaraToggleState) {
                          _utils.setSpasi(!state.isSpasi);
                          setState(() {
                            state.isSpasi = !state.isSpasi;
                          });
                        }
                      },
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: SizedBox(
                          width: double.infinity,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      "Gunakan spasi",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                        "Saat menyala, setiap spasi diubah menjadi karakter khusus sehingga dapat ditransliterasi kembali ke Latin dengan spasi.")
                                  ],
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  Switch(
                                    value: (state is AksaraToggleState) ? state.isSpasi : false,
                                    onChanged: (e) {
                                      if (state is AksaraToggleState) {
                                        _utils.setSpasi(!state.isSpasi);
                                        setState(() {
                                          state.isSpasi = !state.isSpasi;
                                        });
                                      }
                                    },
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),


                  ],
                ),
              );
            }));
  }
}
