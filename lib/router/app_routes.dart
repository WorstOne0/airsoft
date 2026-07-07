/// All route paths in one place. Never hardcode a path string at a call site —
/// reference `AppRoutes.xxx` so paths stay refactorable.
///
/// Child paths are nested under their tab so the bottom navigation stays
/// visible when pushing detail/create screens.
abstract final class AppRoutes {
  // Auth
  static const splash = '/splash';
  static const onboarding = '/onboarding';
  static const login = '/login';
  static const register = '/register';
  static const accountCreated = '/account-created';

  // Home / Feed
  static const home = '/home';
  static const createPost = '/home/create-post';
  static const createStory = '/home/create-story';
  static const postDetail = '/home/post';
  static const storyView = '/home/story';

  // Marketplace
  static const market = '/market';
  static const marketItem = '/market/item';
  static const marketCreate = '/market/create';
  static const marketMine = '/market/mine';

  // Events
  static const events = '/events';
  static const eventDetail = '/event'; // full-screen, over the shell (no bottom bar)

  // Host a game (full-screen flow, over the shell)
  static const hostGame = '/host';
  static const hostPublished = '/host/published';

  // Community (friends)
  static const community = '/community';
  static const friendAdd = '/community/add';
  static const friendProfile = '/community/friend';

  // Profile
  static const profile = '/profile';
  static const profileEdit = '/profile/edit';

  // Misc
  static const settings = '/settings';
}
