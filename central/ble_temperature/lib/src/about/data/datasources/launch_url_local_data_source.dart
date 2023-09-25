import 'package:url_launcher/url_launcher.dart' as launcher;

abstract class LaunchUrlLocalDataSource {
  Future<bool> launchUrl(String url);
}

class LaunchUrlLocalDataSourceImpl implements LaunchUrlLocalDataSource {
  @override
  Future<bool> launchUrl(String url) async {
    return launcher.launchUrl(Uri.parse(url));
  }
}
