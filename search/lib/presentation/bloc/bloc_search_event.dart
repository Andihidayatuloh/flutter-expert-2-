import 'package:equatable/equatable.dart';

abstract class BlocSearchEvent extends Equatable {
  const BlocSearchEvent();
  @override
  List<Object> get props => [];
}

class OnQueryChanged extends BlocSearchEvent {
  final String quaery;

  const OnQueryChanged(this.quaery);

  @override
  List<Object> get props => [quaery];
}






