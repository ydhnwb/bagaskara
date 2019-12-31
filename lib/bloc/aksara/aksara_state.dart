
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class AksaraState extends Equatable{}

class AksaraInitState extends AksaraState{
  @override
  List<Object> get props => null;
}

class AksaraLoadingState extends AksaraState{
  @override
  List<Object> get props => [];
}

class AksaraLoadedState extends AksaraState{
  String domainText = "";
  String targetText = "";
  bool isFromFile = false;
  AksaraLoadedState({@required this.domainText, @required this.targetText, @required this.isFromFile});
  @override
  List<Object> get props => [domainText, targetText];

}