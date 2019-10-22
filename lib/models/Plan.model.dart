class Plan {
  final String name;
  final String path;
  final String id;
  final bool checked;

  Plan(this.id, this.name, this.path, {this.checked});

  Map<String, dynamic> toJson() {
    return {
      'plan': {'id': id, 'name': name, 'path': path, 'checked': checked}
    };
  }

  @override
  String toString() => "Plan {id: $id, name: $name, path: $path}";
}
