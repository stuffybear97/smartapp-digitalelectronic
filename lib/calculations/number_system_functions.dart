//import 'dart:js_interop';
import 'base_conversion.dart';
import 'package:flutter_tex/flutter_tex.dart';

import 'package:flutter_math_fork/ast.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'package:flutter_math_fork/tex.dart';
import 'dart:math';



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


//create fuinction that does A_x + B_y where either one of the number or the base of the number are unknown


// Function to allow user to input the answer to A_x + B_y = Z and find the unknown x
String findUnknownX(String A, String B, String y, String Z) {
  String explanation = '';
  int A_value = int.parse(A);
  int y_value = int.parse(y);
  int Z_value = int.parse(Z);
  int B_value = int.parse(B,radix: y_value);

  // Step 1: Solve for x
  int x = (Z_value - (B_value * y_value)) ~/ A_value;

  // Step 2: Generate working explanation
  explanation += "1. Solve for x: x = (Z - (B * y)) ~/ A\n";
  explanation += "   x = ($Z_value - ($B_value * $y_value)) ~/ $A_value\n";
  explanation += "   x = $x\n";

  // Step 3: Return answer and elaborate on the working explanation
  return "Answer: x = $x\n\nWorking Explanation:\n$explanation";
}


List<String> calculateUnknownX(String A, String B, String y, String Z) {
  try{
    String explanation = '';
    int A_Base10 = 0;
    int y_value = int.parse(y);
    int Z_value = int.parse(Z);
    int B_value = baseToDecimalConversionFunc(B,y_value);
    int x = 0;
    A_Base10 = Z_value - B_value;
    String A_Basei = '';
   /*  for(int i = 2; i <= 37; i++)
    {
      try
      {
      A_Basei=A_Base10.toRadixString(i);
      if(A_Basei == A)
        {
          x = i;
          break;
        }


      }
      catch(E)
      {
        continue;
      }

    }  */
    // Step 1: Solve for x
    
    // Step 2: Generate working explanation
    explanation += "1. Solve for x:\n";
    explanation += "A in base 10 = $Z_value - $B_value = $A_Base10\n";
    explanation += "find the base by trail and error starting from the largest value of A_x + 1 and convert to check with A_base10";
    // Step 3: Return answer and working explanation
    return [A + " convert to decimal incement the base and compaore to its decimal value: " + A_Base10.toString(),explanation];
  }
  catch(E){
    return ['Error: Invalid input.','Error: Invalid input.'];
  }
  
  
}

// Function to solve for A in A_x + B_y = Z
List<String> calculateUnknownA(String B, String y, String Z, String x) {
  try{
    String explanation = '';
    int x_value = int.parse(x);
    int y_value = int.parse(y);
    int Z_value = int.parse(Z);
    int B_value = baseToDecimalConversionFunc(B, y_value);

    // Step 1: Solve for A
    int A = 0;
    //for A in base 10
    A = Z_value - B_value;
    String A_x = A.toRadixString(x_value);
    //for A value in base x
    explanation += "Solve for A: A_"+x+" = "+Z+"_10 - "+B+"_"+y+"\n";
    explanation += " A in base 10 = $Z_value - $B_value = $A \n";
    explanation += "A in base $x = $A_x\n";

    //A = Z_value
    // Step 2: Generate working explanation
    

    // Step 3: Return answer and working explanation
    return [A_x.toString(),explanation];
  }
  catch(E){
    return ['Error: Invalid input.','Error: Invalid input.'];
  }
  
}


String baseToDecimalConversion(String value_baseN) {
  try{
    List<String> parts = value_baseN.split(',');
      String baseNValue = parts[0];
      int baseN = int.parse(parts[1]);
      String steps = "Step-by-step working:\n";
      int decimal = 0;
          // Process each digit from right to left
        for (int i = 0; i < baseNValue.length; i++) {
          int digitValue = getDecimalValueFromHexDigit(baseNValue[baseNValue.length - i - 1]);
          num positionValue = digitValue * pow(baseN, i); // Equivalent to pow(16, i)
          decimal += int.parse(positionValue.toString());
          
          steps += "${baseNValue[baseNValue.length - i - 1]} (hex) => $digitValue * 16^$i = $positionValue\n";
        }

      steps += "Sum of all position values = $decimal (decimal)";
      String result = "Decimal: $decimal\n\n$steps";
      //int decimalValue = int.parse(parts[0], radix: int.parse(parts[1]));
      return result;
  }
  catch(e)
  {
    return "error";
  }
  
}


//Conver Dec to BaseN
String convertDecimalToBaseNGivenDec (String decBaseN)  {
  try{
  List<String> parts = decBaseN.split(',');
  String DecValue = parts[0];
  int decimal = int.parse(DecValue);
  String DesiredBaseN = parts[1];
  int baseN = int.parse(DesiredBaseN);
  String steps = "working:\n";
  String BaseNValue = "";
      while (decimal > 0) {
      int remainder = decimal % baseN;
      String BaseNDigit = getBaseNDigitDigit(remainder);
      BaseNValue = BaseNDigit + BaseNValue;
      steps += "Decimal: $decimal/16 = Q: ${decimal ~/ baseN}, R: $remainder (becomes $BaseNDigit in $baseN)\n";
      decimal = decimal ~/ baseN;
    }

    String result = "$BaseNValue, \n\n$steps";
    return result;
  }
  catch(E){
    return 'Error: Invalid input.';
  }
}
String getBaseNDigitDigit(int remainder) 
{
  if (remainder >= 0 && remainder <= 9) {
    return remainder.toString();
  } else {
    return String.fromCharCode('A'.codeUnitAt(0) + (remainder - 10));
  }
}

/*
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
 */



List<String> calculateUnknownX_add(String A, String B, String y, String Z) {
  try{
    String explanation = '';
    int A_Base10 = 0;
    int y_value = int.parse(y);
    int Z_value = int.parse(Z);
    int B_value = baseToDecimalConversionFunc(B,y_value);
    int x = 0;
    A_Base10 = Z_value - B_value;
    String A_Basei = '';
    explanation += "1. Solve for x:\n";
    explanation += "A in base 10 = $Z_value - $B_value = $A_Base10\n";
    explanation += "find the base by trail and error starting from the largest value of A_x + 1 and convert to check with A_base10";
    // Step 3: Return answer and working explanation
    return [A + " convert to decimal incement the base and compaore to its decimal value: " + A_Base10.toString(),explanation];
  }
  catch(E){
    return ['Error: Invalid input.','Error: Invalid input.'];
  }
  
  
}

// Function to solve for A in A_x + B_y = Z
List<String> calculateUnknownA_add(String B, String y, String Z, String x) {
  try{
    String explanation = '';
    int x_value = int.parse(x);
    int y_value = int.parse(y);
    int Z_value = int.parse(Z);
    int B_value = baseToDecimalConversionFunc(B, y_value);

    // Step 1: Solve for A
    int A = 0;
    //for A in base 10
    A = Z_value - B_value;
    String A_x = A.toRadixString(x_value);

    explanation += "Solve for A: A_"+x+" = "+Z+"_10 - "+B+"_"+y+"\n";

    explanation += " A in base 10 = $Z_value - $B_value = $A \n";

    explanation += "A in base $x = $A_x\n";

 

    // Return answer and working explanation
    return [A_x.toString(),explanation];
  }
  catch(E){
    return ['Error: Invalid input.','Error: Invalid input.'];
  }
  
}

// Function to solve for A in A_x - B_y = Z(base 10)
List<String> calculateUnknownA_sub(String B, String y, String Z, String x) {
  try{
    String explanation = '';
    int x_value = int.parse(x);
    int y_value = int.parse(y);
    int Z_value = int.parse(Z);
    int B_value = baseToDecimalConversionFunc(B, y_value);

    // Step 1: Solve for A
    int A = 0;
    //for A in base 10
    A = Z_value + B_value;
    String A_x = A.toRadixString(x_value);
    //for A value in base x
    explanation += "Solve for A: A_"+x+" = "+Z+"_10 + "+B+"_"+y+"\n";
    explanation += " A in base 10 = $Z_value + $B_value = $A \n";
    explanation += "A in base $x = $A_x\n";

    //A = Z_value
    // Step 2: Generate working explanation
    

    // Step 3: Return answer and working explanation
    return [A_x.toString(),explanation];
  }
  catch(E){
    return ['Error: Invalid input.','Error: Invalid input.'];
  }
  
}

// Function to solve for x which is the base of A,  in A_x - B_y = Z(base 10)
List<String> calculateUnknownX_sub(String A, String B, String y, String Z) {
  try{
    String explanation = '';
    int A_Base10 = 0;
    int y_value = int.parse(y);
    int Z_value = int.parse(Z);
    int B_value = baseToDecimalConversionFunc(B,y_value);
    int x = 0;
    A_Base10 = Z_value + B_value;
    String A_Basei = '';
    explanation += "1. Solve for x:\n";
    explanation += "A in base 10 = $Z_value + $B_value = $A_Base10\n";
    explanation += "find the base by trail and error starting from the largest value of A_x + 1 and convert to check with A_base10";
    // Step 3: Return answer and working explanation
    return [A + " convert to decimal incement the base and compaore to its decimal value: " + A_Base10.toString(),explanation];
  }
  catch(E){
    return ['Error: Invalid input.','Error: Invalid input.'];
  }
  
  
}

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

// Function to solve for A in A_x * B_y = Z
List<String> calculateUnknownA_mul(String B, String y, String Z, String x) {
  try {
    String explanation = '';
    int x_value = int.parse(x);
    int y_value = int.parse(y);
    int Z_value = int.parse(Z);
    int B_value = baseToDecimalConversionFunc(B, y_value);

    // Step 1: Solve for A
    int A = 0; // for A in base 10
    if (B_value != 0) {
      A = Z_value ~/ B_value;
    } else {
      throw Exception('Division by zero error: B cannot be zero.');
    }
    String A_x = convertFromDecimalToBase(A, x_value);

    explanation += "Solve for A: A_$x * $B\_$y = $Z\_10\n";
    explanation += " A in base 10 = $Z_value ÷ $B_value = $A\n";
    explanation += "A in base $x = $A_x\n";

    // Return answer and working explanation
    return [A_x.toString(), explanation];
  } catch (E) {
    return ['Error: Invalid input.', 'Error: Invalid input.'];
  }
}

// Function to solve for x which is the base of A, in A_x * B_y = Z
List<String> calculateUnknownX_mul(String A, String B, String y, String Z) {
  try {
    String explanation = '';
    int y_value = int.parse(y);
    int Z_value = int.parse(Z);
    int B_value = baseToDecimalConversionFunc(B, y_value);

    // Step 1: Convert A to decimal (base 10)
    int A_decimal = 0;
    for (int x = 2; x <= 36; x++) {
      try {
        A_decimal = baseToDecimalConversionFunc(A, x);
        if (A_decimal * B_value == Z_value) {
          explanation += "Convert A to decimal (base 10):\n";
          explanation += "Try base $x: $A\_$x = $A_decimal\_10\n";
          explanation += "Multiply A_decimal and B_decimal: $A_decimal * $B_value = ${A_decimal * B_value}\n";
          explanation += "Result matches Z_decimal ($Z_value), so x = $x\n";
          return [x.toString(), explanation];
        }
      } catch (e) {
        // Ignore invalid base conversion errors and continue the loop
      }
    }

    // If no valid base is found
    return ['No valid base found for A', 'No valid base found for A'];
  } catch (E) {
    return ['Error: Invalid input.', 'Error: Invalid input.'];
  }
}

// Function to solve for A in A_x / B_y = Z
// Function to solve for A in A_x / B_y = Z
List<String> calculateUnknownA_divide(String B, String y, String Z, String x) {
  try {
    String explanation = '';
    int x_value = int.parse(x);
    int y_value = int.parse(y);
    double Z_value = double.parse(Z);
    int B_value = baseToDecimalConversionFunc(B, y_value);

    // Step 1: Solve for A
    double A = 0; // for A in base 10
    if (B_value != 0) {
      A = Z_value * B_value;
    } else {
      throw Exception('Division by zero error: B cannot be zero.');
    }
    String A_x = convertFromDecimalToBase(A.round(), x_value);

    explanation += "Solve for A: A_$x / $B\_$y = $Z\_10\n";
    explanation += " A in base 10 = $Z_value × $B_value = $A\n";
    explanation += "A in base $x = $A_x\n";

    // Return answer and working explanation
    return [A_x.toString(), explanation];
  } catch (E) {
    return ['Error: Invalid input.', 'Error: Invalid input.'];
  }
}

// Function to solve for x (base of A) in A_x / B_y = Z
List<String> calculateUnknownX_divide(String A, String B, String y, String Z) {
  try {
    String explanation = '';
    int y_value = int.parse(y);
    double Z_value = double.parse(Z);
    int B_value = baseToDecimalConversionFunc(B, y_value);

    // Step 1: Convert A to decimal (base 10)
    double A_decimal = 0;
    for (int x = 2; x <= 36; x++) {
      try {
        A_decimal = baseToDecimalConversionFunc(A, x).toDouble();
        if ((A_decimal / B_value).toStringAsFixed(5) == Z_value.toStringAsFixed(5)) {
          explanation += "Convert A to decimal (base 10):\n";
          explanation += "Try base $x: $A\_$x = $A_decimal\_10\n";
          explanation += "Divide A_decimal by B_decimal: $A_decimal / $B_value = ${A_decimal / B_value}\n";
          explanation += "Result matches Z_decimal ($Z_value), so x = $x\n";
          return [x.toString(), explanation];
        }
      } catch (e) {
        // Ignore invalid base conversion errors and continue the loop
      }
    }

    // If no valid base is found
    return ['No valid base found for A', 'No valid base found for A'];
  } catch (E) {
    return ['Error: Invalid input.', 'Error: Invalid input.'];
  }
}