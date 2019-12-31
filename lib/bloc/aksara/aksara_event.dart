import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class AksaraEvent extends Equatable{}

class LatinToAksara implements AksaraEvent {
  final String s;
  LatinToAksara({@required this.s});
  @override
  List<Object> get props => [s];
}

class AksaraToLatin implements AksaraEvent {
  final String s;
  AksaraToLatin({@required this.s});
  @override
  List<Object> get props => [s];
}

class ScanFromCamera implements AksaraEvent{
  @override
  List<Object> get props => null;
}