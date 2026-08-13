# STRONGHOLD Athletic — Gym Marketing Site

Flutter Web build for a fictional Nairobi gym ("STRONGHOLD," Peponi Road,
Westlands). GetX for state/DI/navigation, Dio for the one real network call
on the site.

## Run it

```
flutter create . --platforms web   # only needed once, to generate web/, android/ etc.
flutter pub get
flutter run -d chrome
```

## Architecture

Strict View → Controller → Repository, same pattern as your other builds:

```
lib/
  app/
    core/            # theme, image registry, responsive helper, shared widgets
    data/
      models/        # plain data classes
      services/      # ApiService — Dio client as a GetxService singleton
      repositories/  # GymRepository (static content), ContactRepository (Dio)
    modules/
      home/
        controllers/ # HomeController — scroll nav, form state, submit logic
        bindings/    # HomeBinding — lazyPut wiring
        views/       # HomeView — assembles all sections into one scroll
        widgets/     # one file per section (hero, programs, pricing, etc.)
    routes/
  main.dart
```

Single-page site, sections addressed by `GlobalKey` + `Scrollable.ensureVisible`
rather than named routes — this is a marketing page, not a multi-screen app,
so real navigation would be overkill.

## Where Dio is actually used

Everything else on the page (programs, coaches, pricing, testimonials) is
static content served from `GymRepository` — there's no reason for a single
gym's marketing copy to round-trip a server. The one place Dio does real
work is `ContactRepository.submitEnquiry()`, called from the contact form.

`ApiService.baseUrl` currently points at a placeholder
(`api.stronghold.example.com`), so in this build the POST will fail and
`HomeController.submitEnquiry()` falls back to a local "message received"
state rather than showing a dead-end error. Point `baseUrl` at a real
endpoint (a Cloud Function, a form-relay service, whatever the actual
backend ends up being) and the same code path goes live with no other
changes needed.

## Fonts

No `google_fonts` here — fetching font files over the network on first run
is what broke an earlier build, so this one rides entirely on system-safe
fonts (`Arial Black` / `Helvetica Neue` fallback stack for headlines,
`Roboto Mono` fallback for stats/prices/the ticker) styled with heavy
weights and tight negative tracking to get a condensed, gym-signage feel
without a custom asset.

If you want a real display face later (Anton, Bebas Neue, etc.): drop the
`.ttf` into `assets/fonts/`, register it in `pubspec.yaml` under `flutter:
fonts:`, and swap the family name into `AppTextStyles._displayFallback`.

## Photography

Six real, free-license Unsplash photos, verified and pulled through their
CDN with resize params — registered in one place,
`lib/app/core/constants/gym_images.dart`, so the whole site's photography
can be swapped for the gym's own shoot later by editing that single file.
Photographer credits are listed in that same file. Coach and member
headshots use `pravatar.cc` as placeholders until real portraits exist —
also swappable in one place (`GymImages.coach()` / `GymImages.member()`).

## Content that's made up and needs replacing

- Phone number, email, Instagram/TikTok/WhatsApp links (`contact_section.dart`,
  `footer_section.dart`) — currently placeholders
- Pricing in KSh (`gym_repository.dart` → `fetchPlans()`) — sanity-check
  against real membership pricing before launch
- Coach names/bios and member testimonials — entirely placeholder, obviously

## Design notes

Palette leans into the gym's own materials rather than a generic dark
theme — poured-concrete backgrounds, a chalk/hazard-tape yellow as the one
accent, worn-rust red used sparingly. The scrolling diagonal-stripe ticker
under the nav (and again before the CTA band) is the one signature device,
meant to read like loading-zone tape on a gym floor.
