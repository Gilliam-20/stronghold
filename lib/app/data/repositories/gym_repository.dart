import '../../core/constants/gym_images.dart';
import '../models/plan_model.dart';
import '../models/program_model.dart';
import '../models/testimonial_model.dart';
import '../models/trainer_model.dart';

/// Source of truth for the site's marketing content.
///
/// Everything here is static today, but the repository boundary is kept
/// deliberate: swapping these methods to `await _api.dio.get(...)` and
/// mapping the response is the only change needed if this content ever
/// moves to a CMS or backend — nothing in the controller or views would
/// need to change.
class GymRepository {
  List<ProgramModel> fetchPrograms() {
    return [
      ProgramModel(
        code: 'FLOOR A',
        name: 'Strength',
        tagline: 'Barbell work, coached.',
        description:
            'Progressive overload on the big lifts — squat, bench, deadlift, press — '
            'programmed by your coach and logged every session so the numbers on the '
            'bar keep moving in the right direction.',
        imageUrl: GymImages.strength,
        details: const [
          'Small coached groups, max 6 per rack',
          'Programming adjusted every 4 weeks',
          'Form check on every new PR attempt',
        ],
      ),
      ProgramModel(
        code: 'FLOOR B',
        name: 'Conditioning',
        tagline: 'Bag work, intervals, no clock-watching.',
        description:
            'Boxing-based conditioning circuits built around work-to-rest intervals — '
            'bags, pads, and ropes replace the treadmill for a cardio session that '
            'doesn\'t feel like one.',
        imageUrl: GymImages.conditioning,
        details: const [
          '45-minute coached sessions, 5x a week',
          'Pad rotations with a partner or coach',
          'Scaled for first-timers and fighters alike',
        ],
      ),
      ProgramModel(
        code: 'FLOOR C',
        name: 'Open Floor',
        tagline: 'Full equipment access, your own pace.',
        description:
            'Free weights, plate-loaded machines, and cardio bay — open access during '
            'all floor hours for members who\'d rather run their own programme.',
        imageUrl: GymImages.interiorWide,
        details: const [
          'Access during all listed floor hours',
          'Staff on the floor for spotting & advice',
          'App-based booking for peak-hour slots',
        ],
      ),
    ];
  }

  List<TrainerModel> fetchTrainers() {
    return [
      TrainerModel(
        name: 'Amani Otieno',
        role: 'Head Coach — Strength',
        bio: 'Ten years on the platform, four coaching. Runs the Strength Floor '
            'programming and the Saturday technique clinics.',
        imageUrl: GymImages.coach(12),
        specialties: const ['Powerlifting', 'Programming', 'Mobility'],
      ),
      TrainerModel(
        name: 'Faith Wanjiru',
        role: 'Conditioning Coach',
        bio: 'Former amateur boxer turned conditioning coach. Builds every '
            'circuit around intervals you can actually hold up under.',
        imageUrl: GymImages.coach(47),
        specialties: const ['Boxing', 'Conditioning', 'Nutrition basics'],
      ),
      TrainerModel(
        name: 'Brian Kiptoo',
        role: 'Performance Coach',
        bio: 'Works with members training for a specific event or sport — '
            'from a first 10K to weekend football.',
        imageUrl: GymImages.coach(33),
        specialties: const ['Athletic performance', 'Injury prevention'],
      ),
    ];
  }

  List<PlanModel> fetchPlans() {
    return const [
      PlanModel(
        name: 'Drop-In',
        price: 'KSh 800',
        period: 'per session',
        description: 'For visitors and anyone not ready to commit yet.',
        features: [
          'Full floor access for one session',
          'One conditioning class included',
          'No booking required',
        ],
      ),
      PlanModel(
        name: 'Committed',
        price: 'KSh 6,500',
        period: 'per month',
        description: 'The plan most members are on.',
        features: [
          'Unlimited floor access',
          'Unlimited conditioning classes',
          'Monthly check-in with a coach',
          'Pause anytime, no penalty',
        ],
        featured: true,
      ),
      PlanModel(
        name: 'All-Access',
        price: 'KSh 65,000',
        period: 'per year',
        description: 'Committed, paid annually — two months free.',
        features: [
          'Everything in Committed',
          '2 personal training sessions / month',
          'Priority booking for peak hours',
          'Guest pass, 2 per month',
        ],
      ),
    ];
  }

  List<TestimonialModel> fetchTestimonials() {
    return [
      TestimonialModel(
        name: 'Njeri M.',
        detail: 'Member since 2023',
        quote:
            'I\'d tried three gyms before this one. The difference is the coaching — '
            'someone actually watches your form, every session, not just the first one.',
        imageUrl: GymImages.member(5),
      ),
      TestimonialModel(
        name: 'David O.',
        detail: 'Member since 2022',
        quote:
            'Conditioning class is the only workout I\'ve stuck with for longer than '
            'a month. The 45 minutes go by fast and I\'m wrecked in the best way.',
        imageUrl: GymImages.member(15),
      ),
      TestimonialModel(
        name: 'Grace A.',
        detail: 'Member since 2024',
        quote:
            'Walked in knowing nothing about barbells. Six months later I pulled my '
            'first 100kg deadlift with Amani cueing me through it.',
        imageUrl: GymImages.member(9),
      ),
    ];
  }
}
