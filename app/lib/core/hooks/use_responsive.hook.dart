import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:pleasehiretolga/core/constants/breakpoints.dart';

enum DeviceType { mobile, tablet, desktop }

class ResponsiveDevice {
  const ResponsiveDevice._({
    required this.isMobile,
    required this.isTablet,
    required this.isDesktop,
    required this.type,
  });
  final bool isMobile;
  final bool isTablet;
  final bool isDesktop;
  final DeviceType type;
}

ResponsiveDevice useResponsive() {
  final context = useContext();
  final width = MediaQuery.sizeOf(context).width;

  final isMobile = width <= kMobileBreakpoint;
  final isTablet = width > kMobileBreakpoint && width < kTabletBreakpoint;
  final isDesktop = width >= kTabletBreakpoint;

  return ResponsiveDevice._(
    isMobile: isMobile,
    isTablet: isTablet,
    isDesktop: isDesktop,
    type: switch (width) {
      <= kMobileBreakpoint when (Platform.isIOS || Platform.isAndroid) =>
        DeviceType.mobile,
      < kTabletBreakpoint when (Platform.isIOS || Platform.isAndroid) =>
        DeviceType.tablet,
      _ => DeviceType.desktop,
    },
  );
}
