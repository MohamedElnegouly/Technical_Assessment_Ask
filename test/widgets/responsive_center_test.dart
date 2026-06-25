import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:technical_assessment_task/core/widgets/responsive_center.dart';

void main() {
  Future<void> pumpAt(WidgetTester tester, Size size) async {
    tester.view.physicalSize = size;
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ResponsiveCenter(
            maxWidth: 480,
            child: SizedBox(key: const Key('content'), height: 100, width: double.infinity),
          ),
        ),
      ),
    );
  }

  testWidgets('stays full width on a narrow phone screen', (tester) async {
    await pumpAt(tester, const Size(360, 800));

    final box = tester.getSize(find.byKey(const Key('content')));
    expect(box.width, 360);
  });

  testWidgets('is capped at maxWidth on a wide tablet screen', (tester) async {
    await pumpAt(tester, const Size(1200, 900));

    final box = tester.getSize(find.byKey(const Key('content')));
    expect(box.width, 480);
  });
}
