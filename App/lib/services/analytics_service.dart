import 'package:firebase_analytics/firebase_analytics.dart';

class AnalyticsService {
  static final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

  Future<void> logScreenView(String screenName) async {
    try {
      await _analytics.logScreenView(screenName: screenName);
    } catch (e) {
      print('Analytics error: $e');
    }
  }

  Future<void> logEvent(String name, Map<String, dynamic> parameters) async {
    try {
      await _analytics.logEvent(name: name, parameters: parameters);
    } catch (e) {
      print('Analytics error: $e');
    }
  }

  Future<void> logProjectView(String projectName) async {
    await logEvent('project_view', {'project_name': projectName});
  }

  Future<void> logContactSubmission() async {
    await logEvent('contact_form_submission', {});
  }

  Future<void> logExternalLink(String linkType, String url) async {
    await logEvent('external_link_click', {
      'link_type': linkType,
      'url': url,
    });
  }
}