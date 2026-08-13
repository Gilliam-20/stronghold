import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/utils/responsive.dart';
import '../../../core/widgets/reveal_on_scroll.dart';
import '../../../data/models/plan_model.dart';
import '../controllers/home_controller.dart';

class PricingSection extends StatelessWidget {
  const PricingSection({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<HomeController>();
    final isDesktop = Responsive.isDesktop(context);
    final gutter = Responsive.gutter(context);

    return Container(
      key: c.pricingKey,
      color: AppColors.surface,
      padding: EdgeInsets.symmetric(horizontal: gutter, vertical: isDesktop ? 100 : 64),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RevealOnScroll(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('MEMBERSHIP', style: AppTextStyles.eyebrow()),
                const SizedBox(height: 16),
                Text('Straightforward pricing.\nNo contracts, ever.',
                    style: AppTextStyles.headline(size: isDesktop ? 44 : 32)),
                const SizedBox(height: 16),
                Text('M-Pesa, card, or cash at the front desk.',
                    style: AppTextStyles.body(size: 14.5)),
              ],
            ),
          ),
          SizedBox(height: isDesktop ? 56 : 40),
          !isDesktop
              ? Column(
                  children: [
                    for (var i = 0; i < c.plans.length; i++) ...[
                      RevealOnScroll(
                        delay: Duration(milliseconds: i * 90),
                        child: _PlanCard(plan: c.plans[i]),
                      ),
                      if (i != c.plans.length - 1) const SizedBox(height: 24),
                    ],
                  ],
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (var i = 0; i < c.plans.length; i++) ...[
                      if (i != 0) const SizedBox(width: 24),
                      Expanded(
                        child: RevealOnScroll(
                          delay: Duration(milliseconds: i * 110),
                          child: _PlanCard(plan: c.plans[i]),
                        ),
                      ),
                    ],
                  ],
                ),
        ],
      ),
    );
  }
}

class _PlanCard extends StatelessWidget {
  const _PlanCard({required this.plan});
  final PlanModel plan;

  @override
  Widget build(BuildContext context) {
    final c = Get.find<HomeController>();
    final featured = plan.featured;

    return Container(
      color: featured ? AppColors.caution : AppColors.concrete,
      padding: const EdgeInsets.all(28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (featured)
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Text('MOST MEMBERS PICK THIS',
                  style: AppTextStyles.dataSmall(color: AppColors.onCaution, size: 11)),
            ),
          Text(
            plan.name,
            style: AppTextStyles.titleCard(
              size: 24,
              color: featured ? AppColors.onCaution : AppColors.bone,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            plan.description,
            style: AppTextStyles.body(
              size: 13.5,
              color: featured ? AppColors.onCaution.withOpacity(0.75) : AppColors.fog,
            ),
          ),
          const SizedBox(height: 22),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                plan.price,
                style: AppTextStyles.data(
                  size: 34,
                  color: featured ? AppColors.onCaution : AppColors.bone,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                plan.period,
                style: AppTextStyles.dataSmall(
                  color: featured ? AppColors.onCaution.withOpacity(0.7) : AppColors.fog,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Container(height: 1, color: featured ? AppColors.onCaution.withOpacity(0.2) : AppColors.hairline),
          const SizedBox(height: 22),
          for (final f in plan.features) ...[
            _FeatureRow(text: f, featured: featured),
            const SizedBox(height: 12),
          ],
          const SizedBox(height: 12),
          _PlanButton(featured: featured, onTap: () => c.scrollTo(c.contactKey)),
        ],
      ),
    );
  }
}

class _FeatureRow extends StatelessWidget {
  const _FeatureRow({required this.text, required this.featured});
  final String text;
  final bool featured;

  @override
  Widget build(BuildContext context) {
    final color = featured ? AppColors.onCaution : AppColors.bone;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Icons.check, size: 16, color: featured ? AppColors.onCaution : AppColors.caution),
        const SizedBox(width: 10),
        Expanded(
          child: Text(text, style: AppTextStyles.body(size: 14, color: color)),
        ),
      ],
    );
  }
}

class _PlanButton extends StatefulWidget {
  const _PlanButton({required this.featured, required this.onTap});
  final bool featured;
  final VoidCallback onTap;

  @override
  State<_PlanButton> createState() => _PlanButtonState();
}

class _PlanButtonState extends State<_PlanButton> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    final base = widget.featured ? AppColors.onCaution : AppColors.caution;
    final hoverColor = widget.featured ? AppColors.concrete : AppColors.bone;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 160),
          width: double.infinity,
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(vertical: 15),
          color: _hover ? hoverColor : base,
          child: Text(
            'GET STARTED',
            style: AppTextStyles.button(
              color: widget.featured ? AppColors.bone : AppColors.onCaution,
            ),
          ),
        ),
      ),
    );
  }
}
