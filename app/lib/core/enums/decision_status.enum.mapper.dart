// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'decision_status.enum.dart';

class DecisionStatusMapper extends EnumMapper<DecisionStatus> {
  DecisionStatusMapper._();

  static DecisionStatusMapper? _instance;
  static DecisionStatusMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = DecisionStatusMapper._());
    }
    return _instance!;
  }

  static DecisionStatus fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  DecisionStatus decode(dynamic value) {
    switch (value) {
      case r'pending':
        return DecisionStatus.pending;
      case r'invited':
        return DecisionStatus.invited;
      case r'rejected':
        return DecisionStatus.rejected;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(DecisionStatus self) {
    switch (self) {
      case DecisionStatus.pending:
        return r'pending';
      case DecisionStatus.invited:
        return r'invited';
      case DecisionStatus.rejected:
        return r'rejected';
    }
  }
}

extension DecisionStatusMapperExtension on DecisionStatus {
  String toValue() {
    DecisionStatusMapper.ensureInitialized();
    return MapperContainer.globals.toValue<DecisionStatus>(this) as String;
  }
}
