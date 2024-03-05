import 'dart:math';


int baseToDecimalConversionFunc(String baseValue, int base) {
  int decimalValue = 0;
  for (int i = 0; i < baseValue.length; i++) {
    int digitValue = int.parse(baseValue[i], radix: base);
    decimalValue += (digitValue * pow(base, baseValue.length - i - 1)) as int;
  }
  return decimalValue;
}

String convertFromDecimalToBase(int decimalValue, int base) {
  if (base < 2 || base > 36) {
    throw ArgumentError('Base must be between 2 and 36');
  }
  return decimalValue.toRadixString(base);
}


