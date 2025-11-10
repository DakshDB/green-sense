import 'package:share_plus/share_plus.dart';
import '../models/article.dart';
import '../models/daily_challenge.dart';

class ShareService {
  /// Share an article
  static Future<void> shareArticle(Article article) async {
    await Share.share(
      'I just read "${article.title}" on Green Sense! Learn more about ${article.category.displayName.toLowerCase()} and join me in taking action for our planet. Every green seed of awareness grows a brighter future! 🌱',
      subject: article.title,
    );
  }

  /// Share quiz result
  static Future<void> shareQuizResult(String quizName, int score, int total, String badge) async {
    final percentage = ((score / total) * 100).round();
    await Share.share(
      'I scored $score/$total ($percentage%) on the "$quizName" quiz on Green Sense and earned the $badge badge! 🏆 Test your environmental knowledge and see how you do!',
    );
  }

  /// Share calculator result
  static Future<void> shareCalculatorResult(double co2Tons) async {
    await Share.share(
      'I calculated my carbon footprint: ${co2Tons.toStringAsFixed(1)} tons CO2/year using Green Sense! Calculate yours and learn how to reduce your impact on our planet. 🌍 Every action counts!',
    );
  }

  /// Share pledge
  static Future<void> sharePledge(List<String> commitments) async {
    final commitmentsText = commitments.take(3).map((c) => '• $c').join('\n');
    await Share.share(
      'I\'ve made my Green Pledge! 🌱\n\n$commitmentsText${commitments.length > 3 ? '\n...and ${commitments.length - 3} more!' : ''}\n\nJoin me in making a difference! Make your pledge at Green Sense.',
    );
  }

  /// Share challenge completion
  static Future<void> shareChallenge(DailyChallenge challenge, int streak) async {
    final streakText = streak > 1 ? ' I\'m on a $streak day streak! 🔥' : '';
    await Share.share(
      'I completed today\'s Green Challenge: "${challenge.title}"!$streakText 💪\n\nJoin me in making a daily difference for our planet with Green Sense. Small actions add up to big change! 🌍',
    );
  }

  /// Share action guide
  static Future<void> shareActionGuide(String title) async {
    await Share.share(
      'I\'m taking action with "$title" from Green Sense! Join me in making sustainable choices for our planet. 🌱 Check out practical action guides at Green Sense.',
    );
  }

  /// Share success story
  static Future<void> shareSuccessStory(String title) async {
    await Share.share(
      'Feeling inspired by "$title" - a powerful environmental success story! 🌟 When we work together, real change is possible. Read more success stories at Green Sense.',
    );
  }

  /// General app share
  static Future<void> shareApp() async {
    await Share.share(
      'I\'ve been using Green Sense to learn about environmental issues and take meaningful action! 🌱 Every green seed of awareness grows a brighter future. Join me in making a difference!',
    );
  }
}
