import 'package:flutter_test/flutter_test.dart';
import 'package:technical_assessment_task/features/Projects/data/model/task_model.dart';

void main() {
  group('TaskModel.fromJson', () {
    test('parses a full json map correctly', () {
      final json = {
        '_id': 't1',
        'projectId': '1',
        'title': 'Design login screen',
        'status': 'Done',
        'priority': 'High',
      };

      final task = TaskModel.fromJson(json);

      expect(task.id, 't1');
      expect(task.projectId, '1');
      expect(task.title, 'Design login screen');
      expect(task.status, 'Done');
      expect(task.priority, 'High');
    });

    test('falls back to defaults when optional fields are missing', () {
      final task = TaskModel.fromJson({'_id': 't2', 'projectId': '1'});

      expect(task.title, '');
      expect(task.status, 'Pending');
      expect(task.priority, 'Medium');
    });
  });
}
