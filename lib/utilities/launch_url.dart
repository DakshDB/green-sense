import 'package:green_sense/constants/info.dart';
import 'package:url_launcher/url_launcher.dart';

launchEmail() async {
  Uri emailLaunchUri = Uri(
    scheme: 'mailto:$emailID',
  );
  if (await canLaunchUrl(emailLaunchUri)) {
    await launchUrl(emailLaunchUri);
  } else {
    throw 'Could not launch';
  }
}
