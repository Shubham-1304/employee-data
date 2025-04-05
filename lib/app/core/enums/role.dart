enum Role {
  productDesigner,
  flutterDeveloper,
  qaTester,
  productOwner,
}


extension RoleExtension on Role {
  String get name {
    switch (this) {
      case Role.flutterDeveloper:
        return 'Flutter Developer';
      case Role.productDesigner:
        return 'Product Designer';
      case Role.productOwner:
        return 'Product Owner';
      case Role.qaTester:
        return 'QA Tester';
    }
  }

}