import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

abstract interface class UrlLauncherService {
  Future<bool> canLaunch(Uri url);
  Future<bool> launch(Uri url);
}

final urlLauncherServiceProvider = Provider<UrlLauncherService>(
  (ref) => UrlLauncherServiceImpl(),
);

class UrlLauncherServiceImpl implements UrlLauncherService {
  @override
  Future<bool> canLaunch(Uri url) async => await canLaunchUrl(url);

  @override
  Future<bool> launch(Uri url) async => await launchUrl(url);
}
