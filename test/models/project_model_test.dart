import 'package:flutter_test/flutter_test.dart';
import 'package:technical_assessment_task/features/Projects/data/model/project_model.dart';

void main() {
  group('ProjectModel.fromJson', () {
    test('parses a full json map correctly', () {
      final json = {
        '_id': '1',
        'title': 'Mobile App Redesign',
        'description': 'Revamp the UI/UX',
        'status': 'Active',
      };

      final project = ProjectModel.fromJson(json);

      expect(project.id, '1');
      expect(project.title, 'Mobile App Redesign');
      expect(project.description, 'Revamp the UI/UX');
      expect(project.status, 'Active');
    });

    test('falls back to defaults when optional fields are missing', () {
      final project = ProjectModel.fromJson({'_id': 2});

      expect(project.id, '2');
      expect(project.title, '');
      expect(project.description, '');
      expect(project.status, 'Active');
    });
  });
}
