import 'package:search/search.dart';
import 'package:core/core.dart';

class SearchPage extends StatelessWidget {
  static const ROUTE_NAME = '/search';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Movies'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              key: const Key('search-textfield'),
              onChanged: (query) {
                context
                    .read<BlocMoviesSearchBloc>()
                    .add(OnQueryMoviesChanged(query));
              },
              decoration: const InputDecoration(
                hintText: 'Search title',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              textInputAction: TextInputAction.search,
            ),
            SizedBox(height: 16),
            Text(
              'Search Result',
              style: kHeading6,
            ),
            BlocBuilder<BlocMoviesSearchBloc, BlocMoviesSearchState>(
              builder: (context, object) {
                if (object is BlocMoviesSearchLoading) {
                  return const Expanded(
                      child: Center(child: CircularProgressIndicator()));
                } else if (object is BlocMoviesSearchLoaded) {
                  final List<dynamic> resultData = [
                    ...object.data,
                  ];
                  return Expanded(
                    child: (resultData.isNotEmpty)
                        ? ListView.builder(
                            key: const Key('search-listview'),
                            itemBuilder: (context, index) =>
                                (resultData[index] is Movie)
                                    ? MovieCard(resultData[index])
                                    : const Center(child: Text('Failed')),
                            itemCount: resultData.length,
                          )
                        : const Center(
                            child: Text('Data Movies tidak dapat ditemukan'),
                          ),
                  );
                } else {
                  return const SizedBox(key: Key('search-error'));
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
