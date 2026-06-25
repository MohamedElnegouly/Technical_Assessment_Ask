import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:technical_assessment_task/features/Projects/data/model/project_model.dart';
import 'package:technical_assessment_task/features/Projects/presentation/screens/widgets/project_card.dart';

void main() {
  final project = ProjectModel(
    id: '1',
    title: 'Mobile App Redesign',
    description: 'Revamp the UI/UX of the mobile app',
    status: 'Active',
  );

  testWidgets('ProjectCard shows title, description and status', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(body: ProjectCard(project: project, onTap: () {})),
      ),
    );

    expect(find.text('Mobile App Redesign'), findsOneWidget);
    expect(find.text('Revamp the UI/UX of the mobile app'), findsOneWidget);
    expect(find.text('Active'), findsOneWidget);
  });

  testWidgets('ProjectCard invokes onTap when tapped', (tester) async {
    var tapped = false;
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ProjectCard(project: project, onTap: () => tapped = true),
        ),
      ),
    );

    await tester.tap(find.byType(InkWell));
    expect(tapped, isTrue);
  });
}
