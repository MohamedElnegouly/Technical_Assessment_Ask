import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:technical_assessment_task/features/Projects/presentation/screens/widgets/empty_state_view.dart';

void main() {
  testWidgets('EmptyStateView shows the given message and icon', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: EmptyStateView(message: 'No projects yet.', icon: Icons.folder_off_outlined),
      ),
    );

    expect(find.text('No projects yet.'), findsOneWidget);
    expect(find.byIcon(Icons.folder_off_outlined), findsOneWidget);
  });
}
