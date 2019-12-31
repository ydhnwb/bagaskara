import 'dart:io';

import 'package:aksara/aksara.dart';
import 'package:bagaskara_redefined/bloc/aksara/aksara_event.dart';
import 'package:bagaskara_redefined/bloc/aksara/aksara_state.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AksaraBloc extends Bloc<AksaraEvent, AksaraState>{
  var _aksara = AksaraJava();
  final TextRecognizer textRecognizer = FirebaseVision.instance.textRecognizer();

  @override
  AksaraState get initialState => AksaraInitState();

  @override
  Stream<AksaraState> mapEventToState(AksaraEvent event) async* {
    bool isFirstTime = await getIsFirstTime();
    if(isFirstTime){
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool("IS_MURDHA", false);
      await prefs.setBool("IS_COPAS", true);
      await prefs.setBool("IS_SPASI", false);
      await prefs.setBool("IS_FIRST_TIME", false);
    }

    if(event is AksaraToLatin){
      String s = _aksara.javaToLatin(event.s);
      yield AksaraLoadedState(domainText: event.s, targetText: s, isFromFile: false);
    }else if(event is LatinToAksara){
      bool isMurdha = await getIsMurdha();
      bool isSpasi = await getIsSpasi();
      bool isCopas = await getIsUsingE();
      String s = _aksara.latinToJava(event.s, isCopas: isCopas, isSpasi: isSpasi, isMurdha: isMurdha);
      yield AksaraLoadedState(domainText: event.s, targetText: s, isFromFile: false);
    }else if(event is ScanFromCamera){
      yield AksaraLoadingState();
      bool isMurdha = await getIsMurdha();
      bool isSpasi = await getIsSpasi();
      bool isCopas = await getIsUsingE();
      var image = await ImagePicker.pickImage(source: ImageSource.camera);
      File _imageFile = image;
      FirebaseVisionImage visionImage = FirebaseVisionImage.fromFile(_imageFile);
      VisionText visionText = await textRecognizer.processImage(visionImage);
      String translated = _aksara.latinToJava(visionText.text.toString(), isCopas: isCopas, isSpasi: isSpasi, isMurdha: isMurdha);
      print("isianku "+ visionText.text.toString());
      yield AksaraLoadedState(domainText: visionText.text.toString(), targetText: translated, isFromFile: true);
    }else if(event is InitSettings){
      bool isFirstTime = await getIsFirstTime();
      if(!isFirstTime){
        bool isMurdha = await getIsMurdha();
        bool isSpasi = await getIsSpasi();
        bool isCopas = await getIsUsingE();
        yield AksaraToggleState(isMurdha: isMurdha, isCopas: isCopas, isSpasi: isSpasi);
      }else{
        yield AksaraToggleState(isMurdha: false, isCopas: true, isSpasi: false);
      }
    }
  }

  Future<bool> getIsMurdha() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool b = (prefs.getBool('IS_MURDHA') ?? false);
    return b;
  }

  Future<bool> getIsUsingE() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool b = (prefs.getBool('IS_COPAS') ?? true);
    return b;
  } 

  Future<bool> getIsSpasi() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool b = (prefs.getBool('IS_SPASI') ?? false);
    return b;
  }

  Future<bool> getIsFirstTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool b = (prefs.getBool('IS_FIRST_TIME') ?? true);
    return b;
  }
}