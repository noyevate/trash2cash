import 'package:flutter/material.dart';

extension IntExtention on int? {
  int validate({int value  = 0}) {
    return this ?? value;
  }

  Widget get l => SizedBox(
    height: this?.toDouble(),
  );

  Widget get b => SizedBox(
    width: this?.toDouble(),
  );
}


String apiKey = "AIzaSyCmPEJz8RGp0qdZnnV0A0Owq9NKh0hBFOo";