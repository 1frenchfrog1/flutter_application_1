// lib/features/icons/presentation/bloc/icon_event.dart
import 'package:equatable/equatable.dart';

abstract class IconEvent extends Equatable {
  const IconEvent();

  @override
  List<Object?> get props => [];
}

class FetchIcons extends IconEvent {
  const FetchIcons();
}
