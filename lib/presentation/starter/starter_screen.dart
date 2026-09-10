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
    final cardRadius = shortestSide < 390 ? 26.0 : 34.0;

    return Scaffold(
      backgroundColor: const Color(0xFFE90707),
      body: SafeArea(
        minimum: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
        child: Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(cardRadius),
            child: Stack(
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
                        Color(0xCC000000),
                      ],
                      stops: [0, 0.48, 1],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(28, 28, 28, 48),
                  child: Column(
                    children: [
                      const _StarterStatusBar(),
                      const Spacer(),
                      const _StarterMark(),
                      const SizedBox(height: 28),
                      Text(
                        'Start Stream',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.displaySmall
                            ?.copyWith(
                              color: CupertinoColors.white,
                              fontWeight: FontWeight.w800,
                              height: 1.08,
                            ),
                      ),
                      Text(
                        'Unlimited Anime',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.displaySmall
                            ?.copyWith(
                              color: CupertinoColors.white,
                              fontWeight: FontWeight.w800,
                              height: 1.08,
                            ),
                      ),
                      const SizedBox(height: 18),
                      Text(
                        'Discover thousands of series and\nmovies tailored to your taste.',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(
                              color: CupertinoColors.white.withValues(
                                alpha: 0.78,
                              ),
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
          ),
        ),
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

class _StarterMark extends StatelessWidget {
  const _StarterMark();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 92,
      height: 92,
      decoration: BoxDecoration(
        color: CupertinoColors.white.withValues(alpha: 0.94),
        shape: BoxShape.circle,
        border: Border.all(color: const Color(0xFFE2E3EA), width: 2),
        boxShadow: const [
          BoxShadow(
            color: Color(0x40000000),
            blurRadius: 24,
            offset: Offset(0, 12),
          ),
        ],
      ),
      child: const Center(
        child: Text(
          'ANY-ME',
          style: TextStyle(
            color: Color(0xFFE90707),
            fontSize: 13,
            fontWeight: FontWeight.w800,
            letterSpacing: 0,
          ),
        ),
      ),
    );
  }
}

class _SwipeStartControl extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        const knobSize = 58.0;
        final maxTravel = constraints.maxWidth - knobSize - 14;
        final dx = (maxTravel * progress).clamp(0.0, maxTravel);

        return GestureDetector(
          onTap: onTap,
          onHorizontalDragUpdate: (details) => onDragUpdate(details, maxTravel),
          onHorizontalDragEnd: onDragEnd,
          child: Container(
            height: 72,
            decoration: BoxDecoration(
              color: CupertinoColors.white,
              borderRadius: BorderRadius.circular(36),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x33000000),
                  blurRadius: 24,
                  offset: Offset(0, 12),
                ),
              ],
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 76, right: 22),
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      'SWIPE FOR START',
                      maxLines: 1,
                      style: TextStyle(
                        color: Color(0xFF141414),
                        fontSize: 15,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 0,
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
                      color: Color(0xFFE90707),
                      shape: BoxShape.circle,
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
        );
      },
    );
  }
}
