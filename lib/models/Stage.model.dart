import 'package:sample_app/models/Plan.model.dart';

class Stage {
  final String name;
  final String description;
  final List<Plan> plans;
  final String path;

  Stage(this.name, this.plans, this.path, {this.description});

  Map<String, dynamic> toJson() {
    return {
      'stage': {
        'name': name,
        'plans': plans,
        'path': path,
        'description': description,
      }
    };
  }

  @override
  String toString() =>
      "Stage {name: $name, plans, $plans, path: $path, description: $description}";
}
