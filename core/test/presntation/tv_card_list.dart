import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tv = Tv(
    id: 52814,
    name: 'Halo',
    overview:
        'Depicting an epic 26th-century conflict between humanity and an alien threat known as the Covenant, the series weaves deeply drawn personal stories with action, adventure and a richly imagined vision of the future.',
    posterPath: '/nJUHX3XL1jMkk8honUZnUmudFb9.jpg',
  );

  group('Tv Show card Widget Test', () {
    Widget _makeTestableWidget() {
      return MaterialApp(home: Scaffold(body: TvCard(tv)));
    }

    testWidgets('Testing if title tv show shows', (WidgetTester tester) async {
      await tester.pumpWidget(_makeTestableWidget());
      expect(find.byType(Text), findsWidgets);
      expect(find.byType(InkWell), findsOneWidget);
      expect(find.byType(Card), findsOneWidget);
      expect(find.byType(ClipRRect), findsOneWidget);
      expect(find.byType(CachedNetworkImage), findsOneWidget);
    });
  });
}
