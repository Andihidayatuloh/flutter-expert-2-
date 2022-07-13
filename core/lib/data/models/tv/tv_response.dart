import 'package:core/data/models/tv/tv_model.dart';
import 'package:equatable/equatable.dart';

class TvResponse extends Equatable {
  final List<Result> tvlist;

  TvResponse({required this.tvlist});

  factory TvResponse.fromJson(Map<String, dynamic> json) => TvResponse(
        tvlist: List<Result>.from((json["results"] as List)
            .map((x) => Result.fromJson(x))
            .where((element) => element.posterPath != null)),
      );

  Map<String, dynamic> toJson() => {
        "results": List<dynamic>.from(tvlist.map((x) => x.toJson())),
      };

  @override
  List<Object> get props => [tvlist];
}