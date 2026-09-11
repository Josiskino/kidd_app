import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/services.dart';

import '../../core/providers/onboarding/app_entry_provider.dart';

class StarterScreen extends ConsumerStatefulWidget {
  const StarterScreen({super.key});

  @override
  ConsumerState<StarterScreen> createState() => _StarterScreenState();
}

class _StarterScreenState extends ConsumerState<StarterScreen> {
  static const double _completeThreshold = 0.72;

  double _dragProgress = 0;

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: [SystemUiOverlay.bottom],
    );
  }

  @override
  void dispose() {
    _restoreSystemOverlays();
    super.dispose();
  }

  void _complete() {
    _restoreSystemOverlays();
    ref.read(appEntryProvider.notifier).completeStarter();
  }

  void _restoreSystemOverlays() {
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: SystemUiOverlay.values,
    );
  }

  void _handleDragUpdate(DragUpdateDetails details, double maxDistance) {
    if (maxDistance <= 0) return;
    setState(() {
      _dragProgress = (_dragProgress + details.delta.dx / maxDistance).clamp(
        0,
        1,
      );
    });
  }

  void _handleDragEnd(DragEndDetails details) {
    if (_dragProgress >= _completeThreshold) {
      _complete();
      return;
    }

    setState(() => _dragProgress = 0);
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final shortestSide = mediaQuery.size.shortestSide;

    return Scaffold(
      backgroundColor: CupertinoColors.black,
      body: Stack(
        fit: StackFit.expand,
        children: [
          const Image(
            image: AssetImage('assets/images/starter_anime_collage.png'),
            fit: BoxFit.cover,
            alignment: Alignment.center,
          ),
          const DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0x33000000),
                  Color(0x99000000),
                  Color(0xD9000000),
                ],
                stops: [0, 0.46, 1],
              ),
            ),
          ),
          SafeArea(
            minimum: const EdgeInsets.fromLTRB(32, 18, 32, 44),
            child: Column(
              children: [
                const _StarterStatusBar(),
                const Spacer(),
                Text(
                  'Start Stream',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(
                    color: CupertinoColors.white,
                    fontWeight: FontWeight.w800,
                    height: 1.08,
                  ),
                ),
                Text(
                  'Unlimited Anime',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(
                    color: CupertinoColors.white,
                    fontWeight: FontWeight.w800,
                    height: 1.08,
                  ),
                ),
                const SizedBox(height: 18),
                Text(
                  'Discover thousands of series and\nmovies tailored to your taste.',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: CupertinoColors.white.withValues(alpha: 0.78),
                    height: 1.35,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 30),
                FractionallySizedBox(
                  widthFactor: shortestSide < 390 ? 0.92 : 0.82,
                  child: _SwipeStartControl(
                    progress: _dragProgress,
                    onTap: _complete,
                    onDragUpdate: _handleDragUpdate,
                    onDragEnd: _handleDragEnd,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StarterStatusBar extends StatelessWidget {
  const _StarterStatusBar();

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Text(
          '12:45',
          style: TextStyle(
            color: CupertinoColors.white,
            fontSize: 16,
            fontWeight: FontWeight.w800,
            letterSpacing: 0,
          ),
        ),
        Spacer(),
        Icon(CupertinoIcons.wifi, color: CupertinoColors.white, size: 18),
        SizedBox(width: 8),
        Icon(
          CupertinoIcons.battery_100,
          color: CupertinoColors.white,
          size: 24,
        ),
      ],
    );
  }
}

class _SwipeStartControl extends StatefulWidget {
  const _SwipeStartControl({
    required this.progress,
    required this.onTap,
    required this.onDragUpdate,
    required this.onDragEnd,
  });

  final double progress;
  final VoidCallback onTap;
  final void Function(DragUpdateDetails details, double maxDistance)
  onDragUpdate;
  final GestureDragEndCallback onDragEnd;

  @override
  State<_SwipeStartControl> createState() => _SwipeStartControlState();
}

class _SwipeStartControlState extends State<_SwipeStartControl>
    with SingleTickerProviderStateMixin {
  late final AnimationController _shimmer = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 2200),
  )..repeat();

  @override
  void dispose() {
    _shimmer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final progress = widget.progress;

    return LayoutBuilder(
      builder: (context, constraints) {
        const knobSize = 58.0;
        final maxTravel = constraints.maxWidth - knobSize - 14;
        final dx = (maxTravel * progress).clamp(0.0, maxTravel);
        // The sweep fades out while the user drags the knob.
        final sweepOpacity = (1 - progress * 1.6).clamp(0.0, 1.0);

        return GestureDetector(
          onTap: widget.onTap,
          onHorizontalDragUpdate: (details) =>
              widget.onDragUpdate(details, maxTravel),
          onHorizontalDragEnd: widget.onDragEnd,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(36),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
              child: Container(
                height: 72,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(36),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      CupertinoColors.white.withValues(alpha: 0.14),
                      CupertinoColors.white.withValues(alpha: 0.05),
                      const Color(0xFFB9C7FF).withValues(alpha: 0.08),
                    ],
                  ),
                  border: Border.all(
                    color: CupertinoColors.white.withValues(alpha: 0.28),
                    width: 1.2,
                  ),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x33000000),
                      blurRadius: 30,
                      offset: Offset(0, 14),
                    ),
                  ],
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned.fill(
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              CupertinoColors.white.withValues(alpha: 0.12),
                              CupertinoColors.white.withValues(alpha: 0),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned.fill(
                      child: IgnorePointer(
                        child: Opacity(
                          opacity: sweepOpacity,
                          child: AnimatedBuilder(
                            animation: _shimmer,
                            builder: (context, _) => DecoratedBox(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    CupertinoColors.white.withValues(alpha: 0),
                                    CupertinoColors.white.withValues(
                                      alpha: 0.22,
                                    ),
                                    CupertinoColors.white.withValues(alpha: 0),
                                  ],
                                  stops: const [0.35, 0.5, 0.65],
                                  transform: _SlideGradientTransform(
                                    _shimmer.value,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 76, right: 22),
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: AnimatedBuilder(
                          animation: _shimmer,
                          builder: (context, child) => ShaderMask(
                            blendMode: BlendMode.srcIn,
                            shaderCallback: (bounds) => LinearGradient(
                              colors: [
                                CupertinoColors.white.withValues(alpha: 0.55),
                                CupertinoColors.white,
                                CupertinoColors.white.withValues(alpha: 0.55),
                              ],
                              stops: const [0.3, 0.5, 0.7],
                              transform: _SlideGradientTransform(
                                _shimmer.value,
                              ),
                            ).createShader(bounds),
                            child: child,
                          ),
                          child: const Text(
                            'SWIPE FOR START',
                            maxLines: 1,
                            style: TextStyle(
                              color: CupertinoColors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 0,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 7 + dx,
                      child: Container(
                        width: knobSize,
                        height: knobSize,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [Color(0xFFFF2B2B), Color(0xFFE90707)],
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0x66E90707),
                              blurRadius: 18,
                              offset: Offset(0, 8),
                            ),
                          ],
                        ),
                        child: const Icon(
                          CupertinoIcons.chevron_right_2,
                          color: CupertinoColors.white,
                          size: 24,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

/// Slides a gradient horizontally: 0 → fully off the left edge,
/// 1 → fully off the right edge.
class _SlideGradientTransform extends GradientTransform {
  const _SlideGradientTransform(this.t);

  final double t;

  @override
  Matrix4? transform(Rect bounds, {TextDirection? textDirection}) {
    return Matrix4.translationValues(bounds.width * (t * 2 - 1), 0, 0);
  }
}
