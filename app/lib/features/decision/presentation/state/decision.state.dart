import 'package:dart_mappable/dart_mappable.dart';

part 'decision.state.mapper.dart';

@MappableClass()
class DecisionState with DecisionStateMappable {
  const DecisionState({
    required this.isLoading,
    this.errorMessage,
  });

  final bool isLoading;
  final String? errorMessage;
}
