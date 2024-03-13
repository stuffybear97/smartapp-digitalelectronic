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

class NullLaw {
  static String solve(String expression) {
    return expression.replaceAll(RegExp(r'[01]\s*[+\*]\s*[A-Z]'), (match) {
      final parts = match.group(0)!.split(RegExp(r'[+\*]'));
      final value = parts[0].trim();
      final variable = parts[1].trim();
      return value == '0' ? '0' : '1';
    } as String);
  }
}

class IdempotentLaw {
  static String solve(String expression) {
    return expression.replaceAll(RegExp(r'([A-Z])\s*[+\*]\s*\1'), (match) {
      final variable = match.group(1)!;
      return variable;
    } as String);
  }
}

class InverseLaw {
  static String solve(String expression) {
    return expression.replaceAll(RegExp(r'([A-Z])\s*[+\*]\s*[01]'), (match) {
      final parts = match.group(0)!.split(RegExp(r'[+\*]'));
      final variable = parts[0].trim();
      final value = parts[1].trim();
      return value == '0' ? '0' : '1';
    } as String);
  }
}

class CommutativeLaw {
  static String solve(String expression) {
    return expression.replaceAllMapped(RegExp(r'([A-Z])\s*([+\*])\s*([A-Z])'), (match) {
      final operand1 = match.group(1)!;
      final operator = match.group(2)!;
      final operand2 = match.group(3)!;
      return '$operand2 $operator $operand1';
    });
  }
}

class AssociativeLaw {
  static String solve(String expression) {
    return expression.replaceAllMapped(RegExp(r'\(([A-Z])\s*([+\*])\s*([A-Z])\)\s*([+\*])\s*([A-Z])'), (match) {
      final operand1 = match.group(1)!;
      final operator1 = match.group(2)!;
      final operand2 = match.group(3)!;
      final operator2 = match.group(4)!;
      final operand3 = match.group(5)!;
      return '$operand1 $operator1 ($operand2 $operator2 $operand3)';
    });
  }
}

class DistributiveLaw {
  static String solve(String expression) {
    return expression.replaceAllMapped(RegExp(r'([A-Z])\s*[+\*]\s*(\([A-Z]\s*[+\*]\s*[A-Z]\))'), (match) {
      final operand1 = match.group(1)!;
      final operand2 = match.group(2)!;
      final parts = operand2.substring(1, operand2.length - 1).split(RegExp(r'[+\*]'));
      final subOperand1 = parts[0].trim();
      final subOperand2 = parts[1].trim();
      return '($operand1 + $subOperand1) * ($operand1 + $subOperand2)';
    });
  }
}

class AbsorptionLaw {
  static String solve(String expression) {
    return expression.replaceAll(RegExp(r'([A-Z])\s*[+\*]\s*\(\1\s*[+\*]\s*[A-Z]\)'), (match) {
      final variable = match.group(1)!;
      return variable;
    } as String);
  }
}

class DeMorgansLaw {
  static String solve(String expression) {
    return expression.replaceAllMapped(RegExp(r'~\(([A-Z])\s*([+\*])\s*([A-Z])\)'), (match) {
      final operand1 = match.group(1)!;
      final operator = match.group(2)!;
      final operand2 = match.group(3)!;
      final newOperator = operator == '+' ? '*' : '+';
      return '(~$operand1 $newOperator ~$operand2)';
    });
  }
}