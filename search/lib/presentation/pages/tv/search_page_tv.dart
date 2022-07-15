import 'package:search/search.dart';
import 'package:core/core.dart';

class SearchTvPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Tv'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              key: const Key('search-textfield'),
              onChanged: (query) {
                context.read<BlocTvSearchBloc>().add(OnQueryTvChanged(query));
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
            BlocBuilder<BlocTvSearchBloc, BlocTvSearchState>(
              builder: (context, object) {
                if (object is BlocTvSearchLoading) {
                  return const Expanded(
                      child: Center(child: CircularProgressIndicator()));
                } else if (object is BlocTvSearchLoaded) {
                  final List<dynamic> resultData = [
                    ...object.data,
                  ];
                  return Expanded(
                    child: (resultData.isNotEmpty)
                        ? ListView.builder(
                            key: const Key('search-listview'),
                            itemBuilder: (context, index) =>
                                (resultData[index] is Tv)
                                    ? TvCard(resultData[index])
                                    : const Center(child: Text('Failed')),
                            itemCount: resultData.length,
                          )
                        : const Center(
                            child: Text('Data Tv tidak dapat ditemukan'),
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
