import 'package:tv/tv.dart';

class TopRatedTvPage extends StatefulWidget {
  static const ROUTE_NAME = '/top-rated-tv';

  @override
  _TopRatedTvPageState createState() => _TopRatedTvPageState();
}

class _TopRatedTvPageState extends State<TopRatedTvPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
       context.read<BlocTopTvBloc>().add(BlocGetTvEvent()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Top Rated tv'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<BlocTopTvBloc, BlocTvState>(
          builder: (context, state) {
            if (state is TvLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is TvLoaded) {
              final result = state.result;
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tv = result[index];
                  return TvCard(tv);
                },
                itemCount: result.length,
              );
            } else if (state is TvError) {
              return Center(
                key: Key('error_message'),
                child: Text(state.message),
              );
            } else {
              return Expanded(child: Container());
            }
          },
        ),
      ),
    );
  }
}
