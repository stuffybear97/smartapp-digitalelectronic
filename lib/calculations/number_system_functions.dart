//import 'dart:js_interop';

import 'package:flutter_tex/flutter_tex.dart';

import 'package:flutter_math_fork/ast.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'package:flutter_math_fork/tex.dart';



Future<String> convertBinaryToDecimal(String binaryValue) async {
  try {
    int decimal = int.parse(binaryValue, radix: 2);
    String stepsToSolve = '';
    int lenght = binaryValue.length;
    var digits = binaryValue.split('');
    int power = lenght-1;
    for (int i = 0; i < lenght; i++) {
      int check1or0;
      if(i==0) {
        check1or0 = int.parse(digits[i], radix: 2);
        stepsToSolve = "$stepsToSolve\n$check1or0* \ 2^$power \ ";

      }
      else{
        check1or0 = int.parse(digits[i], radix: 2);
       
        stepsToSolve = stepsToSolve + "\n +" + check1or0.toString() + "* 2^" + power.toString();
      }
      power = power - 1;
          }
    return   "\n" +stepsToSolve + " = " + decimal.toString();
  } catch (e) {
    return 'Invalid Input';
  }
}

Future<String> convertDecimalToBinary(String decimalValue) async {
    try {
    int decimal = int.parse(decimalValue);
    if (decimal == 0) {
      return "0\n\nDecimal 0 in binary is 0.";
    }

    String binary = "";
    String steps = "working:\n";
    
    while (decimal > 0) {
      int remainder = decimal % 2;
      binary = remainder.toString() + binary;
      steps += "Decimal:$decimal/2 = Q: ${decimal ~/ 2}, R:$remainder(binary digit).\n";
      decimal = decimal ~/ 2;
    }

    String result = "$binary \n$steps";
    return result;
  } catch (e) {
    return 'Invalid Input';
  }

}


Future<String> convertDecimalToHex(String decimalValue) async {
  try {
    int decimal = int.parse(decimalValue);
    if (decimal == 0) {
      return "0\n\nDecimal 0 in hexadecimal is 0.";
    }

    String hexa = "";
    String steps = "working:\n";
    
    while (decimal > 0) {
      int remainder = decimal % 16;
      String hexDigit = getHexDigit(remainder);
      hexa = hexDigit + hexa;
      steps += "Decimal: $decimal/16 = Q: ${decimal ~/ 16}, R: $remainder (becomes $hexDigit in hex)\n";
      decimal = decimal ~/ 16;
    }

    String result = "$hexa, \n\n$steps";
    return result;
  } catch (e) {
    return 'Invalid Input';
  }
}

String getHexDigit(int remainder) {
  if (remainder >= 0 && remainder <= 9) {
    return remainder.toString();
  } else {
    return String.fromCharCode('A'.codeUnitAt(0) + (remainder - 10));
  }
}



Future<String> convertHexToDecimal(String hexValue) async {
  try {
    int decimal = 0;
    String steps = "Step-by-step working:\n";

    // Process each digit from right to left
    for (int i = 0; i < hexValue.length; i++) {
      int digitValue = getDecimalValueFromHexDigit(hexValue[hexValue.length - i - 1]);
      int positionValue = digitValue * (1 << (4 * i)); // Equivalent to pow(16, i)
      decimal += positionValue;
      
      steps += "${hexValue[hexValue.length - i - 1]} (hex) => $digitValue * 16^$i = $positionValue\n";
    }

    steps += "Sum of all position values = $decimal (decimal)";

    String result = "Decimal: $decimal\n\n$steps";
    return result;
  } catch (e) {
    return 'Invalid Input';
  }
}

int getDecimalValueFromHexDigit(String hexDigit) {
  return int.parse(hexDigit, radix: 16);
}


//convert binary to hex and hex to binary 

Future<String> convertBinaryToHex(String binaryValue) async {
  try {
    int i = 32;
    // Padding the binary string so its length is a multiple of 4
    while (binaryValue.length % 4 != 0) {
      binaryValue = "0" + binaryValue;
    }

    String hex = "";
    String steps = "Step-by-step working:\n";

    // Process each group of 4 bits
    for (int i = 0; i < binaryValue.length; i += 4) {
      String binaryChunk = binaryValue.substring(i, i + 4);
      int decimalValue = int.parse(binaryChunk, radix: 2);
      String hexDigit = decimalValue.toRadixString(16).toUpperCase();

      hex += hexDigit;
      
      steps += "Binary: $binaryChunk => Decimal: $decimalValue => Hex: $hexDigit\n";
    }

    String result = "Hexadecimal: $hex\n\n$steps";
    return result;
  } catch (e) {
    return 'Invalid Input';
  }
}


Future<String> convertHexToBinary(String hexValue) async {
  try {
    String binary = "";
    String steps = "Step-by-step working:\n";

    // Process each hexadecimal digit
    for (int i = 0; i < hexValue.length; i++) {
      String hexDigit = hexValue[i].toUpperCase(); // Ensuring uppercase for consistency
      int decimalValue = int.parse(hexDigit, radix: 16);
      String binaryChunk = decimalValue.toRadixString(2).padLeft(4, '0'); // Convert to binary and pad with zeros

      binary += binaryChunk;
      
      steps += "Hex: $hexDigit => Decimal: $decimalValue => Binary: $binaryChunk\n";
    }

    String result = "Binary: $binary\n\n$steps";
    return result;
  } catch (e) {
    return 'Invalid Input';
  }
}

Future<String> convertDecimalTo2sComplement(String decimalValues) async {
  String explanation = ""; // Initialize explanation string
  int totalBits = 32;
  int decimal = int.parse(decimalValues);

  // For positive numbers and zero, directly convert to binary and pad to totalBits
  if (decimal >= 0) {
    String binary = decimal.toRadixString(2).padLeft(totalBits, '0');
    if (binary.length > totalBits) {
      return 'Error: Number too large for the specified bit width.';
    }
    explanation += "Since the number is positive, its 2's complement is the same as its binary representation.\n";
    explanation += "Binary representation: $binary\n";
    return binary + "\n\nExplanation:\n" + explanation;
  }

  // For negative numbers, convert absolute value to binary, invert, and add 1
  explanation += "Converting negative number to 2's complement involves several steps:\n";
  String binary = decimal.abs().toRadixString(2).padLeft(totalBits, '0');
  if (binary.length > totalBits) {
    return 'Error: Number too large for the specified bit width.';
  }
  explanation += "1. Convert the absolute value to binary: $binary\n";

  // Invert bits
  String invertedBinary = binary.split('').map((bit) => bit == '1' ? '0' : '1').join('');
  explanation += "2. Invert all bits for 1's complement: $invertedBinary\n";

  // Add 1 to the inverted binary string
  String twosComplement = addOneToBinaryReturnAns(invertedBinary, explanation);
  explanation = addOneToBinaryReturnWorking(invertedBinary, explanation);
  return twosComplement + "\n\nExplanation:\n" + explanation;
}

String addOneToBinaryReturnAns(String binary, String explanation) {
  List<String> binaryList = binary.split('');
  int index = binary.length - 1;
  bool carry = true;
  
  while (index >= 0 && carry) {
    if (binaryList[index] == '0') {
      binaryList[index] = '1';
      carry = false;
    } else {
      binaryList[index] = '0'; // Continue the carry
    }
    index--;
  }

  // Handling the case where all bits are flipped and an extra bit is needed
  if (carry) {
    return 'Error: Overflow. The number is too large for the specified bit width.';
  }
  
  explanation += "3. Add 1 to the 1's complement to get the 2's complement: " + binaryList.join('') + "\n";
  
  return binaryList.join('');
}
String addOneToBinaryReturnWorking(String binary, String explanation) {
  List<String> binaryList = binary.split('');
  int index = binary.length - 1;
  bool carry = true;
  
  while (index >= 0 && carry) {
    if (binaryList[index] == '0') {
      binaryList[index] = '1';
      carry = false;
    } else {
      binaryList[index] = '0'; // Continue the carry
    }
    index--;
  }

  // Handling the case where all bits are flipped and an extra bit is needed
  if (carry) {
    return 'Error: Overflow. The number is too large for the specified bit width.';
  }
  
  explanation += "3. Add 1 to the 1's complement to get the 2's complement: " + binaryList.join('') + "\n";
  
  return explanation;
}


Future<String> convertHexTo2sComplement(String hexValue) async {
try{
  int totalBits = 32;
    // Convert hex to binary with padding to ensure it has the correct length
  String binary = int.parse(hexValue, radix: 16).toRadixString(2).padLeft(totalBits, '0');
    if (binary.length > totalBits) {
      return 'Error: Binary representation exceeds specified bit width.';
    }

  // Determine if the binary number is positive or negative based on its MSB
  bool isNegative = hexValue.startsWith('-');
  //String sign = isNegative ? "negative" : "positive";
  String explanation = '';
  // Step 1: Convert hex to binary
  //String binary = hexToBinary(hexValue, totalBits);
 // if (binary.startsWith('Error')) {
 //   return binary; // Return error message if conversion fails
 // }

  // Step 2: Convert binary to 2's complement
  String twosComplement = convertBinaryTo2sComplement(binary);
  explanation = "Conversion steps:\n1. Hexadecimal to binary: $binary\n2. Binary to 2's complement: $twosComplement\n";

  // Explanation
  if(isNegative == false)
  {
    return "$binary\n\nExplanation:\n$explanation";
  }
  return "$twosComplement\n\nExplanation:\n$explanation";
}
catch(e){
return 'Error: Invalid hexadecimal input.';
}
  
}


String convertBinaryTo2sComplement(String binary) {
  // Step 1: Invert all bits
  String onesComplement = binary.split('').map((bit) => bit == '1' ? '0' : '1').join('');

  // Step 2: Add 1 to the least significant bit
  return addOneToBinary(onesComplement);
}

String addOneToBinary(String binary) {
  List<String> binaryList = binary.split('');
  bool carry = true;
  
  for (int i = binaryList.length - 1; i >= 0; i--) {
    if (binaryList[i] == '0') {
      binaryList[i] = '1';
      carry = false;
      break;
    } else {
      binaryList[i] = '0';
    }
  }

  if (carry) {
    // Handle overflow
    return 'Error: Overflow in addition; adjust total bits.';
  }

  return binaryList.join('');
}
