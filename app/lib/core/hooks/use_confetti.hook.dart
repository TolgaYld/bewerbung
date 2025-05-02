import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

ConfettiController useConfettiController({required Duration duration}) {
  return use(
    _ConfettiControllerHook(duration),
  );
}

class _ConfettiControllerHook extends Hook<ConfettiController> {
  const _ConfettiControllerHook(this.duration);
  final Duration duration;

  @override
  HookState<ConfettiController, Hook<ConfettiController>> createState() =>
      _ConfettiControllerHookState();
}

class _ConfettiControllerHookState
    extends HookState<ConfettiController, _ConfettiControllerHook> {
  late final ConfettiController _controller;

  @override
  void initHook() {
    super.initHook();
    _controller = ConfettiController(duration: hook.duration);
  }

  @override
  ConfettiController build(BuildContext context) => _controller;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
