//

class IdentityLaw {
  static String solve(String expression) {
    return expression.replaceAll(RegExp(r'[01]\s*[+\*]\s*[A-Z]'), (match) {
      final parts = match.group(0)!.split(RegExp(r'[+\*]'));
      final value = parts[0].trim();
      final variable = parts[1].trim();
      return value == '1' ? variable : value;
    } as String);
  }
}
