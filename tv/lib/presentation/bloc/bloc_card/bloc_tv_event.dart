import 'package:tv/tv.dart';

abstract class BlocTvEvent extends Equatable {
  const BlocTvEvent();

  @override
  List<Object> get props => [];
}

class BlocGetTvEvent extends BlocTvEvent{}
