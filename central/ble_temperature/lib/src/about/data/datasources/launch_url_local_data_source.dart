import 'package:url_launcher/url_launcher.dart' as launcher;

abstract class LaunchUrlLocalDataSource {
  Future<void> launchUrl(String url);
}

class LaunchUrlLocalDataSourceImpl implements LaunchUrlLocalDataSource {
  @override
  Future<void> launchUrl(String url) async {
    await launcher.launchUrl(Uri.parse(url));
  }
}
