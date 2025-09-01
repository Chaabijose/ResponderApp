import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:responder_app/base/base_view.dart';
import 'package:responder_app/main.dart';
import 'package:responder_app/models/api/page_properties.dart';
import 'package:responder_app/screens/home/home_controller.dart';
import 'package:responder_app/screens/home/widgets/bottom_card_info.dart';
import 'package:responder_app/screens/home/widgets/drawer_panel.dart';
import 'package:responder_app/screens/home/widgets/notification_panel.dart';
import 'package:responder_app/screens/home/widgets/user_widget.dart';
import 'package:responder_app/theme/app_colors.dart';
import 'package:responder_app/utils/date_time_util.dart';
import 'package:responder_app/widgets/avatar/circular_avatar.dart';
import 'package:responder_app/widgets/loaders/loader.dart';
import '../../models/local_enums.dart';
import '../../utils/constants.dart';
import 'unit_danger/unit_danger_card.dart';
import '../../utils/location_utils.dart';

// Custom gesture recognizer for two-finger long press
class TwoFingerLongPressGestureRecognizer extends LongPressGestureRecognizer {
  @override
  bool isPointerAllowed(PointerDownEvent event) {
    // Only allow if we have exactly 2 pointers
    return _pointers.length < 2;
  }

  final Set<int> _pointers = <int>{};

  @override
  void addAllowedPointer(PointerDownEvent event) {
    _pointers.add(event.pointer);
    if (_pointers.length == 2) {
      // Start recognizing when we have exactly 2 fingers
      super.addAllowedPointer(event);
    }
  }

  @override
  void handleEvent(PointerEvent event) {
    if (event is PointerUpEvent || event is PointerCancelEvent) {
      _pointers.remove(event.pointer);
    }
    if (_pointers.length == 2) {
      super.handleEvent(event);
    }
  }

  @override
  void dispose() {
    _pointers.clear();
    super.dispose();
  }
}

class HomeScreen extends BaseView<HomeController> {
  HomeScreen({super.key});

  @override
  Widget? buildBody(BuildContext context) {
    return GetBuilder(
      init: controller,
      builder: (_) => SizedBox(
        width: Get.width,
        height: Get.height,
        child: RawGestureDetector(
          gestures: {
            TwoFingerLongPressGestureRecognizer:
                GestureRecognizerFactoryWithHandlers<
                    TwoFingerLongPressGestureRecognizer>(
              () => TwoFingerLongPressGestureRecognizer(),
              (TwoFingerLongPressGestureRecognizer instance) {
                instance.onLongPress = () {
                  controller.onShowUnitDangerDialog();
                };
              },
            ),
          },
          child: Stack(
            children: [
              /// Map ********************************

              GetBuilder<HomeController>(
                init: controller,
                id: controller.mapWidgetId,
                builder: (controller) => controller.unitLocation != null
                    ? GoogleMap(
                        initialCameraPosition: CameraPosition(
                          target: LocationUtils.fallbackLocation,
                          zoom: controller.zoomLevel,
                        ),
                        markers: controller.markers,
                        onMapCreated: controller.onMapReady,
                        mapType: MapType.normal,
                        myLocationEnabled: true,
                        myLocationButtonEnabled: true,
                        zoomControlsEnabled: false,
                        zoomGesturesEnabled: true,
                        scrollGesturesEnabled: true,
                        rotateGesturesEnabled: true,
                        tiltGesturesEnabled: true,
                        compassEnabled: true,
                        indoorViewEnabled: true,
                        trafficEnabled: true,
                        buildingsEnabled: true,
                        minMaxZoomPreference: MinMaxZoomPreference.unbounded,
                      )
                    : Center(
                        child: Loader(
                          size: LoaderSize.large,
                        ),
                      ),
              ),

              /// Top App Bar ********************************
              Positioned(
                top: verticalPadding.h,
                left: horizontalPadding.w,
                right: horizontalPadding.w,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    /// Left Items
                    Column(
                      spacing: 14.h,
                      children: [
                        GestureDetector(
                          onTap: controller.onShowHideDrawer,
                          child: Container(
                            padding: EdgeInsets.all(customBorderRadius.r),
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(customBorderRadius.r),
                              color: kPrimaryLight,
                            ),
                            child: Icon(
                              Icons.menu,
                              size: 30.r,
                              color: kWhite,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: controller.onMapStyle,
                          child: Container(
                            padding: EdgeInsets.all(customBorderRadius.r),
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(customBorderRadius.r),
                              color: kGrey41,
                            ),
                            child: Icon(
                              Icons.layers_rounded,
                              size: 30.r,
                              color: kWhite,
                            ),
                          ),
                        ),
                      ],
                    ),

                    /// Right Items
                    Row(
                      spacing: 8.w,
                      children: [
                        /// Connection state __________________________
                        Container(
                          padding: EdgeInsets.all(customBorderRadius.r),
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(customBorderRadius.r),
                            color: kPrimaryLight,
                          ),
                          child: Row(
                            spacing: 8.w,
                            children: [
                              Icon(Icons.connect_without_contact,
                                  color: kAccent, size: 30.r),
                              Icon(Icons.wifi, color: kAccent, size: 30.r),
                            ],
                          ),
                        ),

                        /// Notifications __________________________
                        GestureDetector(
                          onTap: controller.onShowHideNotification,
                          child: Container(
                            padding: EdgeInsets.all(customBorderRadius.r),
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(customBorderRadius.r),
                              color: kPrimaryLight,
                            ),
                            child: Icon(
                              Icons.notifications_outlined,
                              size: 30.r,
                              color: kWhite,
                            ),
                          ),
                        ),

                        /// User Banner __________________________
                        UserWidget(
                          iconClicked: (bool value) =>
                              controller.onShowHideProfile(value),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              /// Bottom Card Info ********************************
              Align(
                alignment: AlignmentDirectional.bottomCenter,
                child: BottomCardInfo(
                    currentStatus: controller.currentStatus,
                    onUnitInfo: controller.onUnitInfo,
                    onAvailability: controller.onAvailability),
              ),

              // Left drawer
              if (controller.showDrawer.value)
                Positioned(
                  top: 0,
                  bottom: 0,
                  left: 0,
                  width: 400.w,
                  child: DrawerPanel(
                      currentStatus: controller.currentStatus,
                      onCloseDrawer: controller.onCloseDrawer,
                      onChangeMapView: (item) =>
                          controller.onChangeMapView(item),
                      selectedView: controller.selectedView,
                      onUnitProfile: controller.onUnitProfile,
                      onInquiry: controller.onInquiry,
                      onBroadcasts: controller.onBroadcasts,
                      onMessages: controller.onMessages,
                      onSettings: controller.onSettings,
                      onHelp: controller.onHelp,
                      version: controller.version!,
                      buildNumber: controller.buildNumber!),
                ),

              // Notifications
              if (controller.showNotification.value)
                Positioned(
                  top: 0,
                  bottom: 0,
                  right: 0,
                  width: 400.w,
                  child: NotificationPanel(
                      onCloseNotification: controller.onCloseNotification),
                ),

              // Profile
              if (controller.showProfile.value)
                Positioned(
                  top: 100.h,
                  bottom: 120.h,
                  right: 0,
                  width: 300.w,
                  child: _profilePanel(),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _profilePanel() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(customBorderRadius.r),
        color: kPrimary,
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: verticalPadding.h,
            ),
            CircularAvatar(),
            SizedBox(
              height: 22.h,
            ),
            Text(
              '${'officer'.tr} ${pref.user?.firstName}',
              style: Get.textTheme.headlineLarge?.copyWith(fontSize: 18.sp),
            ),
            SizedBox(
              height: 4.h,
            ),
            Text(
              'Field Officer · Riyadh 1',
              style: Get.textTheme.displayMedium?.copyWith(fontSize: 16.sp),
            ),
            SizedBox(
              height: 22.h,
            ),
            Divider(
              color: kGrey9C,
              thickness: 0.5.h,
            ),
            InkWell(
                onTap: () =>
                    controller.onUnitProfile(enumData: MyUnitEnum.shiftHistory),
                child: _profileItem(
                    icon: Icons.access_time_rounded,
                    title: 'my_shift_history',
                    body: 'view_past_shifts')),
            InkWell(
                onTap: () =>
                    controller.onUnitProfile(enumData: MyUnitEnum.unitDetails),
                child: _profileItem(
                    icon: Icons.car_rental,
                    title: 'my_assigned_unit',
                    body: 'Riyadh 1 . police',
                    extra:
                        'Last used: ${DateTimeUtil.toddMMYYYYDashFormat(DateTime.now())}')),
            Divider(
              color: kGrey9C,
              thickness: 0.5.h,
            ).paddingSymmetric(horizontal: horizontalPadding.w),
            InkWell(
                onTap: controller.onSettings,
                child: _profileItem(
                  icon: Icons.settings_outlined,
                  title: 'settings',
                  body: 'settings_body',
                )),
            Container(
              width: Get.width,
              color: kGrey2B,
              padding: EdgeInsets.symmetric(
                  horizontal: horizontalPadding.w, vertical: 16.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'theme'.tr,
                    style:
                        Get.textTheme.headlineMedium?.copyWith(fontSize: 16.sp),
                  ),
                  Container(
                    padding: EdgeInsets.all(8.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.r),
                      color: kGrey38,
                    ),
                    child: Row(
                      children: ThemeEnum.values
                          .map((item) => Expanded(
                                child: GestureDetector(
                                  onTap: () => controller.onChangeTheme(item),
                                  child: Container(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 10.h),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8.r),
                                      color: controller.themeController
                                                  .currentTheme ==
                                              item
                                          ? kGrey4c
                                          : Colors.transparent,
                                    ),
                                    child: Center(
                                      child: Text(
                                        item.title.tr,
                                        style: Get.textTheme.displayMedium
                                            ?.copyWith(
                                          fontSize: 14.sp,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ))
                          .toList(),
                    ),
                  )
                ],
              ),
            ),
            Divider(
              color: kGrey9C,
              thickness: 0.5.h,
            ).paddingSymmetric(horizontal: horizontalPadding.w),
            InkWell(
              onTap: controller.onlogout,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                spacing: 12.w,
                children: [
                  Icon(
                    Icons.logout,
                    color: kRed,
                    size: 20.r,
                  ),
                  Expanded(
                    child: Column(
                      spacing: 4.h,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'logout'.tr,
                          style: Get.textTheme.displayLarge?.copyWith(
                            fontSize: 16.sp,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          'end_session_and_return_to_login'.tr,
                          style: Get.textTheme.displayMedium
                              ?.copyWith(fontSize: 14.sp, color: kRed),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ).paddingSymmetric(
                  horizontal: horizontalPadding.w, vertical: 16.h),
            )
          ],
        ),
      ),
    );
  }

  Widget _profileItem({
    required IconData icon,
    required String title,
    required String body,
    String? extra,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 12.w,
      children: [
        Container(
          padding: EdgeInsets.all(8.r),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            color: kGrey38,
          ),
          child: Icon(
            icon,
            color: kBlueSky,
            size: 20.r,
          ),
        ),
        Expanded(
          child: Column(
            spacing: 4.h,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title.tr,
                style: Get.textTheme.displayLarge?.copyWith(
                  fontSize: 16.sp,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                body.tr,
                style: Get.textTheme.displayMedium?.copyWith(
                  fontSize: 14.sp,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              if (extra != null)
                Text(
                  extra,
                  style: Get.textTheme.labelMedium
                      ?.copyWith(fontSize: 12.sp, height: 0.5),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                )
            ],
          ),
        ),
      ],
    ).paddingSymmetric(horizontal: horizontalPadding.w, vertical: 16.h);
  }

  @override
  Widget? buildFloatButton() {
    return GetBuilder(
      init: controller,
      builder: (_) => controller.isUnitInDanger.value
          ? UnitDangerCard(
              onCancel: controller.onCancelSos,
            )
          : InkWell(
              onTap: () => controller.onShowUnitDangerDialog(),
              child: Container(
                padding: EdgeInsets.all(customBorderRadius.r),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: kRed,
                ),
                child: Icon(
                  Icons.warning_amber,
                  color: kWhite,
                  size: 30.r,
                ),
              ),
            ),
    );
  }

  @override
  PageProperties get pageProperties => PageProperties(showAppBar: false);
}
