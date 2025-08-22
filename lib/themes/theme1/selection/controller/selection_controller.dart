import 'package:get/get.dart';
import 'package:flutter/material.dart';

class SelectionController extends GetxController {
  final List<RxBool> loadingStates = [false.obs, false.obs, false.obs];

  Future<void> handleButtonTap(int index, String routeName) async {

    // check if another button is already loading
    if (loadingStates.any((state) => state.value)) {
      return;
    }

    loadingStates[index].value = true;


    await Future.delayed(const Duration(seconds: 2));
    Get.offAllNamed(routeName);
    loadingStates[index].value = false;
  }
}