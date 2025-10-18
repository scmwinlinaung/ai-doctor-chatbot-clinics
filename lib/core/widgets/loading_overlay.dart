import 'dart:io';

import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:clinics/core/config/app_colors.dart';
import 'package:clinics/core/navigation/app_router.dart';

class LoadingOverlay {
  static OverlayEntry? _overlay;
  static bool _backButtonInterceptor(
    bool stopDefaultButtonEvent,
    RouteInfo routeInfo,
  ) => true;

  static bool get overlayExists => _overlay != null;

  // static GlobalKey<NavigatorState> rootNavigatorKey =
  //     GlobalKey<NavigatorState>();

  // static void setRootNavigatorKey(GlobalKey<NavigatorState> key) {
  //   rootNavigatorKey = key;
  // }

  static void show([
    BuildContext? ctx,
    bool isShowSpinkit = true,
    Color? backgroundColor,
  ]) {
    final context = ctx ?? rootNavigatorKey.currentContext!;
    if (Platform.isIOS || Platform.isAndroid) {
      BackButtonInterceptor.add(_backButtonInterceptor);
    }
    if (_overlay == null) {
      _overlay = OverlayEntry(
        builder: (context) => ColoredBox(
          color: backgroundColor ?? const Color(0x80000000),
          child: !isShowSpinkit ? null : const LoadingWidget(),
          // : const Center(
          //     child: SpinKitChasingDots(color: AppColors.bgWhite),

          //  Material(
          //   color: Colors.black26,
          //   borderRadius: BorderRadius.all(Radius.circular(5)),
          //   child: SizedBox(
          //     height: 100,
          //     width: 100,
          //     child: Padding(
          //       padding: EdgeInsets.symmetric(horizontal: 20),
          //       child: Column(
          //         mainAxisAlignment: MainAxisAlignment.center,
          //         children: [
          //           // SizedBox(
          //           //   height: 25,
          //           //   width: 25,
          //           //   child: LoadingWidget(
          //           //     strokeWidth: 2,
          //           //     valueColor: AlwaysStoppedAnimation(Colors.blue),
          //           //   ),
          //           // ),
          //           // SizedBox(height: 10),
          //           // Text(
          //           //   'yeyint_customer',
          //           //   style: TextStyle(
          //           //       fontSize: 14, color: bgColor),
          //           // )
          //         ],
          //       ),
          //     ),
          //   ),
          // ),
          // ),
        ),
      );
      Overlay.of(context).insert(_overlay!);
    }
  }

  static void hide() {
    if (Platform.isIOS || Platform.isAndroid) {
      BackButtonInterceptor.remove(_backButtonInterceptor);
    }
    if (_overlay != null) {
      _overlay!.remove();
      _overlay = null;
    }
  }
}

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SizedBox(
        width: 90,
        height: 90,
        child: Material(
          elevation: 24.0,
          color: Colors.white,
          type: MaterialType.card,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          //Modify to the widget we want to display here, the external properties are consistent with other Dialogs.
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 10),
              SpinKitWave(color: AppColors.primaryColor, size: 20),
              Padding(
                padding: EdgeInsets.only(top: 15),
                child: Text(
                  "Loading",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                ),
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
