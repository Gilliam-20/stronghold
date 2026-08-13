/// Central registry for every photographic asset used on the site.
///
/// All action / equipment photography is sourced from Unsplash (free
/// license, no attribution required) and requested through their imgix
/// pipeline so each call site gets the exact crop and weight it needs
/// instead of downloading one oversized master image everywhere.
///
/// Keeping every URL in one place — rather than inline in each widget —
/// means the whole site's photography can be swapped (e.g. for the gym's
/// own real photos once they're shot) by editing this single file.
class GymImages {
  GymImages._();

  static String _unsplash(String id, {int w = 1600, int q = 80}) {
    return 'https://images.unsplash.com/$id?auto=format&fit=crop&w=$w&q=$q';
  }

  // Photographers, for the credits section — Unsplash license doesn't
  // require attribution, but it's good practice to keep the record.
  static const List<Map<String, String>> credits = [
    {'title': 'A man lifting weights', 'author': 'Morrow Solutions'},
    {'title': 'A close up of a barbell on a gym floor', 'author': 'Eduardo Cano Photo Co.'},
    {'title': 'A pair of boxing gloves hanging from a hook', 'author': 'Mike Cox'},
    {'title': 'A gym filled with lots of exercise equipment', 'author': 'Jinish Shah'},
    {'title': 'A black and white photo of a barbell in a gym', 'author': 'Ambitious Studio* | Rick Barrett'},
    {'title': 'A gym with a barbell and weight plates', 'author': 'Eduardo Cano Photo Co.'},
  ];

  /// Hero — lifter mid-rep, the single most characteristic image on the site.
  static String get hero => _unsplash('photo-1656774950529-44a6153521ee', w: 2000, q: 82);

  /// Open floor / interior — wide shot used in About and as the Open Floor
  /// program card.
  static String get interiorWide => _unsplash('photo-1671970922029-0430d2ae122c', w: 1800);

  /// Strength floor — barbell close-up on the platform.
  static String get strength => _unsplash('photo-1620188526357-ff08e03da266', w: 1400);

  /// Conditioning — boxing gloves, used for the conditioning program.
  static String get conditioning => _unsplash('photo-1633394782368-6e7260566004', w: 1400);

  /// Gallery — black & white barbell, moody texture shot.
  static String get galleryMono => _unsplash('photo-1706029831385-1c89922848eb', w: 1200);

  /// Gallery — loaded bar and plates, floor-level detail.
  static String get galleryPlates => _unsplash('photo-1620188467120-5042ed1eb5da', w: 1200);

  /// CTA band background — reuses the interior shot at higher crop weight
  /// with a heavier overlay applied in the widget itself.
  static String get ctaBackground => _unsplash('photo-1620188467120-5042ed1eb5da', w: 1800);

  /// Coach headshots. These are placeholder portraits (pravatar — a stable
  /// service built for exactly this purpose) standing in until the gym's
  /// own coach photography is shot; swap the URLs below for real portraits
  /// whenever they're ready.
  static String coach(int seed) => 'https://i.pravatar.cc/480?img=$seed';

  /// Member headshots for testimonials — same placeholder approach as coaches.
  static String member(int seed) => 'https://i.pravatar.cc/240?img=$seed';
}
