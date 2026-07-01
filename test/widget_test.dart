// Basic smoke test for the app scaffold.
//
// Note: theme assembly uses google_fonts (Rajdhani), which fetches the font at
// runtime in the real app. That network dependency can't run in a headless
// test, so this file verifies the parts that don't require it.
import 'package:flutter_test/flutter_test.dart';

import 'package:airsoft_cascavel/router/app_routes.dart';

void main() {
  test('core route paths are defined', () {
    expect(AppRoutes.splash, '/splash');
    expect(AppRoutes.login, '/login');
    expect(AppRoutes.home, '/home');
    expect(AppRoutes.events, '/events');
    expect(AppRoutes.profile, '/profile');
  });
}
