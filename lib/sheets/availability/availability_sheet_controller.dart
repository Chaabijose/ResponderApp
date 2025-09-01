import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responder_app/base/base_controller.dart';
import 'package:responder_app/sheets/availability/availability_sheet_repository.dart';

import '../../dialogs/confirm_change_status.dart';
import '../../models/status.dart';
import '../../theme/app_colors.dart';

class AvailabilitySheetController extends BaseController<AvailabilitySheetRepository>{

  @override
  injectRepository() {
  Get.put(AvailabilitySheetRepository(),tag: tag);
  }

  @override
  AvailabilitySheetRepository get repository => Get.find(tag:tag);

  /// Data ******************************************************************
  var otherStatus   = [
    Status(title: 'Available',body: 'Ready for assignment',color: kAccent,icon: Icons.check_box_rounded),
    Status(title: 'Out of Service', body: 'Not available for assignment', color: kRed, icon: Icons.clear,),
    Status(title: 'Available at Quarters',body: 'Available at station',icon: Icons.home,color:kAccent),
    Status(title: 'Available at Pagers',body: 'Monitoring pager system',icon: Icons.home,color:kAccent),
    Status(title: 'Available at Foot',body: 'Patrolling on foot',icon: Icons.directions_walk,color:kAccent),
    Status(title: 'Available at MDT',body: 'Working on mobile data terminal',icon: Icons.laptop,color:kAccent),
    Status(title: 'Available at Emergency',body: 'Emergency calls only',icon: Icons.emergency,color:kAccent),
    Status(title: 'Group member',body: 'Part of group assignment',icon: Icons.person,color:kBlueSky),
    Status(title: 'Pending available',body: 'Transitioning to available',icon: Icons.timer,color:kGrey9C),
    Status(title: 'Pending Mobile',body: 'Preparing for mobile status',icon: Icons.mobile_screen_share,color:kPink),
  ];
  var isOpen = false.obs;
  Status? selectedStatus ;
/// Listeners ******************************************************************
  void openCloseStatus(){
    isOpen.value = !isOpen.value;
    update();
  }

  Future<void> onSelectStatus(Status status)async{
    var res = await Get.dialog(ConfirmChangeStatus(newStatus: status,),arguments: selectedStatus);
    if(res == null) return;
    selectedStatus = res;
    Get.back(result: selectedStatus);
    update();
  }
  /// Data ******************************************************************
  /// Data ******************************************************************
  /// Data ******************************************************************

}