import 'package:get/get.dart';

import '../../models/helper/title_model.dart';

class DropDownController<M extends TitleModel> extends GetxController {
  /// Data **********************************************************************
  var selectedValue = Rx<M?>(null);

  /// Listeners ****************************************************************
  void setSelectedValue(M? value) {
    selectedValue.value = value;
    // update(['selected']);
  }
}
