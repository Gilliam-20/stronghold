import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/ticker_strip.dart';
import '../controllers/home_controller.dart';
import '../widgets/about_section.dart';
import '../widgets/contact_section.dart';
import '../widgets/cta_section.dart';
import '../widgets/footer_section.dart';
import '../widgets/gallery_section.dart';
import '../widgets/hero_section.dart';
import '../widgets/navbar.dart';
import '../widgets/pricing_section.dart';
import '../widgets/programs_section.dart';
import '../widgets/stats_strip.dart';
import '../widgets/testimonials_section.dart';
import '../widgets/trainers_section.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  static const _tickerItems = [
    'NO CONTRACTS',
    'M-PESA ACCEPTED',
    'WALK-INS WELCOME',
    'COACHED FLOOR',
    'OPEN 7 DAYS',
    'PEPONI ROAD, WESTLANDS',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.concrete,
      body: Stack(
        children: [
          CustomScrollView(
            controller: controller.scrollController,
            slivers: const [
              SliverToBoxAdapter(child: HeroSection()),
              SliverToBoxAdapter(child: TickerStrip(items: _tickerItems)),
              SliverToBoxAdapter(child: StatsStrip()),
              SliverToBoxAdapter(child: AboutSection()),
              SliverToBoxAdapter(child: ProgramsSection()),
              SliverToBoxAdapter(child: TrainersSection()),
              SliverToBoxAdapter(child: GallerySection()),
              SliverToBoxAdapter(child: PricingSection()),
              SliverToBoxAdapter(child: TestimonialsSection()),
              SliverToBoxAdapter(child: CtaSection()),
              SliverToBoxAdapter(child: ContactSection()),
              SliverToBoxAdapter(child: FooterSection()),
            ],
          ),
          const Positioned(top: 0, left: 0, right: 0, child: Navbar()),
          const MobileMenuOverlay(),
        ],
      ),
    );
  }
}
