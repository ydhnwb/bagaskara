import 'dart:io';

import 'package:aksara/aksara.dart';
import 'package:bagaskara_redefined/bloc/aksara/aksara_event.dart';
import 'package:bagaskara_redefined/bloc/aksara/aksara_state.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:image_picker/image_picker.dart';

class AksaraBloc extends Bloc<AksaraEvent, AksaraState>{
  var _aksara = AksaraJava();
  final TextRecognizer textRecognizer = FirebaseVision.instance.textRecognizer();


  @override
  AksaraState get initialState => AksaraInitState();

  @override
  Stream<AksaraState> mapEventToState(AksaraEvent event) async* {
    if(event is AksaraToLatin){
      String s = _aksara.javaToLatin(event.s);
      yield AksaraLoadedState(domainText: event.s, targetText: s, isFromFile: false);
    }else if(event is LatinToAksara){
      String s = _aksara.latinToJava(event.s, isCopas: true);
      yield AksaraLoadedState(domainText: event.s, targetText: s, isFromFile: false);
    }else if(event is ScanFromCamera){
      yield AksaraLoadingState();
      var image = await ImagePicker.pickImage(source: ImageSource.camera);
      File _imageFile = image;
      FirebaseVisionImage visionImage = FirebaseVisionImage.fromFile(_imageFile);
      VisionText visionText = await textRecognizer.processImage(visionImage);
      String translated = _aksara.latinToJava(visionText.text.toString(), isCopas: true);
      print("isianku "+ visionText.text.toString());
      yield AksaraLoadedState(domainText: visionText.text.toString(), targetText: translated, isFromFile: true);
    }

  }
}