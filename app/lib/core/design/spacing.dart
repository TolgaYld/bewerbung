import 'package:flutter/widgets.dart';

class Spacers {
  static const double em = 4.0;

  static const double xxs = 1 * em;
  static const double xs = 2 * em;
  static const double s = 3 * em;
  static const double m = 4 * em;
  static const double l = 6 * em;
  static const double xl = 8 * em;
  static const double x2l = 12 * em;
  static const double x3l = 16 * em;
  static const double x4l = 24 * em;
  static const double x5l = 32 * em;
  static const double x6l = 40 * em;
  static const double x7l = 48 * em;
  static const double x8l = 64 * em;
  static const double x9l = 80 * em;
}

/// A horizontal space of given width
class HSpace extends StatelessWidget {
  const HSpace(this.width, {super.key});
  const HSpace.expand({Key? key}) : this(double.infinity, key: key);

  const HSpace.xxs({Key? key}) : this(Spacers.xxs, key: key);
  const HSpace.xs({Key? key}) : this(Spacers.xs, key: key);
  const HSpace.s({Key? key}) : this(Spacers.s, key: key);
  const HSpace.m({Key? key}) : this(Spacers.m, key: key);
  const HSpace.l({Key? key}) : this(Spacers.l, key: key);
  const HSpace.xl({Key? key}) : this(Spacers.xl, key: key);
  const HSpace.x2l({Key? key}) : this(Spacers.x2l, key: key);
  const HSpace.x3l({Key? key}) : this(Spacers.x3l, key: key);
  const HSpace.x4l({Key? key}) : this(Spacers.x4l, key: key);
  const HSpace.x5l({Key? key}) : this(Spacers.x5l, key: key);
  const HSpace.x6l({Key? key}) : this(Spacers.x6l, key: key);
  const HSpace.x7l({Key? key}) : this(Spacers.x7l, key: key);
  const HSpace.x8l({Key? key}) : this(Spacers.x8l, key: key);
  const HSpace.x9l({Key? key}) : this(Spacers.x9l, key: key);

  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: width);
  }
}

/// A vertical space of given height
class VSpace extends StatelessWidget {
  const VSpace(this.height, {super.key});
  const VSpace.expand({Key? key}) : this(double.infinity, key: key);

  const VSpace.xxs({Key? key}) : this(Spacers.xxs, key: key);
  const VSpace.xs({Key? key}) : this(Spacers.xs, key: key);
  const VSpace.s({Key? key}) : this(Spacers.s, key: key);
  const VSpace.m({Key? key}) : this(Spacers.m, key: key);
  const VSpace.l({Key? key}) : this(Spacers.l, key: key);
  const VSpace.xl({Key? key}) : this(Spacers.xl, key: key);
  const VSpace.x2l({Key? key}) : this(Spacers.x2l, key: key);
  const VSpace.x3l({Key? key}) : this(Spacers.x3l, key: key);
  const VSpace.x4l({Key? key}) : this(Spacers.x4l, key: key);
  const VSpace.x5l({Key? key}) : this(Spacers.x5l, key: key);
  const VSpace.x6l({Key? key}) : this(Spacers.x6l, key: key);
  const VSpace.x7l({Key? key}) : this(Spacers.x7l, key: key);
  const VSpace.x8l({Key? key}) : this(Spacers.x8l, key: key);
  const VSpace.x9l({Key? key}) : this(Spacers.x9l, key: key);

  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: height);
  }
}
