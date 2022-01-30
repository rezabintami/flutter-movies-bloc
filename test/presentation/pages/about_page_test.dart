import 'package:ditonton/presentation/pages/about_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() async {
  Widget buildTestableWidget(Widget widget) {
    return MediaQuery(
        data: const MediaQueryData(), child: MaterialApp(home: widget));
  }

  testWidgets('test about pages', (tester) async {
    final aboutDesc = find.byType(Text);
    final iconButton = find.byType(IconButton);
    await tester.pumpWidget(buildTestableWidget(AboutPage()));
    final iconBack = find.byType(IconButton);
    await tester.tap(iconBack);
    await tester.pump();

    expect(aboutDesc, findsOneWidget);
    expect(iconButton, findsOneWidget);
  });
}
