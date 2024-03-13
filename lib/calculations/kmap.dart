import "solveBool.dart";

String solveKMapMinTerms(List<List<bool>> kMap, int numVariables) {
  // Define the variable names (up to 4 variables)
  List<String> vars = ['A', 'B', 'C', 'D'];
  
  // Ensure the number of variables does not exceed the size of 'vars'
  if (numVariables > 4) {
    return 'Number of variables exceeds limit of 4.';
  }
  
  // Initialize an empty list for minterms
  List<String> minterms = [];

  // Adjust indexing for Gray code sequence in the K-map
  List<int> grayCodeIndex = [0, 1, 3, 2];

  // Iterate over the K-map
  for (int i = 0; i < kMap.length; i++) {
    int rowIndex = grayCodeIndex[i]; // Adjusted for Gray code
    for (int j = 0; j < kMap[i].length; j++) {
      int colIndex = grayCodeIndex[j]; // Adjusted for Gray code
      // Check if the current cell is true (1)
      if (kMap[i][j]) {
        String minterm = '';
        // Construct the minterm based on the adjusted indexes
        if (numVariables > 2) minterm += vars[2] + ((rowIndex & 2) == 0 ? '\'' : ''); // C
        if (numVariables > 3) minterm += vars[3] + ((rowIndex & 1) == 0 ? '\'' : ''); // D
        if (numVariables > 0) minterm += vars[0] + ((colIndex & 2) == 0 ? '\'' : ''); // A
        if (numVariables > 1) minterm += vars[1] + ((colIndex & 1) == 0 ? '\'' : ''); // B
        
        // Add the minterm to the list
        minterms.add(minterm);
      }
    }
  }
  String mintermsJoint = minterms.join(' + ').trim();
  //String result = AbsorptionLaw.solve(mintermsJoint);
  
  // Join all minterms with a + (OR) operator
  return mintermsJoint;
}

String solveKMapMinTermsMathTex(List<List<bool>> kMap, int numVariables) {
  // Define the variable names (up to 4 variables)
  List<String> vars = ['A', 'B', 'C', 'D'];
  
  // Ensure the number of variables does not exceed the size of 'vars'
  if (numVariables > 4) {
    return 'Number of variables exceeds limit of 4.';
  }
  
  // Initialize an empty list for minterms
  List<String> minterms = [];

  // Adjust indexing for Gray code sequence in the K-map
  List<int> grayCodeIndex = [0, 1, 3, 2];

  // Iterate over the K-map
  for (int i = 0; i < kMap.length; i++) {
    int rowIndex = grayCodeIndex[i]; // Adjusted for Gray code
    for (int j = 0; j < kMap[i].length; j++) {
      int colIndex = grayCodeIndex[j]; // Adjusted for Gray code
      // Check if the current cell is true (1)
      if (kMap[i][j]) {
        String minterm = '';
        // Construct the minterm based on the adjusted indexes
        // \bar{y}
        if (numVariables > 2) minterm += ((rowIndex & 2) == 0 ? '\\bar{' : '') + vars[2] + ((rowIndex & 2) == 0 ? '}' : ''); // C
        if (numVariables > 3) minterm += ((rowIndex & 1) == 0 ? '\\bar{' : '') + vars[3] + ((rowIndex & 1) == 0 ? '}' : ''); // D
        if (numVariables > 0) minterm += ((colIndex & 2) == 0 ? '\\bar{' : '') + vars[0] + ((colIndex & 2) == 0 ? '}' : ''); // A
        if (numVariables > 1) minterm += ((colIndex & 1) == 0 ? '\\bar{' : '') + vars[1] + ((colIndex & 1) == 0 ? '}' : ''); // B
        
        // Add the minterm to the list
        minterms.add(minterm);
      }
    }
  }
  String mintermsJoint = minterms.join(' + ').trim();
  //String result = AbsorptionLaw.solve(mintermsJoint);
  
  // Join all minterms with a + (OR) operator
  return mintermsJoint;
}


String solveKMapMaxTerm(List<List<bool>> kMap, int numVariables) {
  // Define the variable names (up to 4 variables)
  List<String> vars = ['A', 'B', 'C', 'D'];
  
  // Ensure the number of variables does not exceed the size of 'vars'
  if (numVariables > 4) {
    return 'Number of variables exceeds limit of 4.';
  }
  
  // Initialize an empty list for minterms
  List<String> maxterms = [];

  // Adjust indexing for Gray code sequence in the K-map
  List<int> grayCodeIndex = [0, 1, 3, 2];

  // Iterate over the K-map
  for (int i = 0; i < kMap.length; i++) {
    int rowIndex = grayCodeIndex[i]; // Adjusted for Gray code
    for (int j = 0; j < kMap[i].length; j++) {
      int colIndex = grayCodeIndex[j]; // Adjusted for Gray code
      // Check if the current cell is true (1)
      if (kMap[i][j]) {
        String maxterm = '';
        // Construct the minterm based on the adjusted indexes
        if (numVariables > 2) maxterm += vars[2] + ((rowIndex & 2) == 0 ? '\'' : '') + "+"; // C
        if (numVariables > 3) maxterm += "${vars[3]}${(rowIndex & 1) == 0 ? '\'' : ''}+"; // D
        if (numVariables > 0) maxterm += vars[0] + ((colIndex & 2) == 0 ? '\'' : '')+ "+"; // A
        if (numVariables > 1) maxterm += vars[1] + ((colIndex & 1) == 0 ? '\'' : ''); // B
        
        // Add the minterm to the list
        maxterms.add(maxterm);
      }
    }
  }

  String maxtermsJoint = maxterms.join(' . ');
  //String result = AbsorptionLaw.solve(mintermsJoint);
  
  // Join all minterms with a + (OR) operator
  return maxtermsJoint;
}

String solveKMapMaxTermMathTex(List<List<bool>> kMap, int numVariables) {
  // Define the variable names (up to 4 variables)
  List<String> vars = ['A', 'B', 'C', 'D'];
  
  // Ensure the number of variables does not exceed the size of 'vars'
  if (numVariables > 4) {
    return 'Number of variables exceeds limit of 4.';
  }
  
  // Initialize an empty list for minterms
  List<String> maxterms = [];

  // Adjust indexing for Gray code sequence in the K-map
  List<int> grayCodeIndex = [0, 1, 3, 2];

  // Iterate over the K-map
  for (int i = 0; i < kMap.length; i++) {
    int rowIndex = grayCodeIndex[i]; // Adjusted for Gray code
    for (int j = 0; j < kMap[i].length; j++) {
      int colIndex = grayCodeIndex[j]; // Adjusted for Gray code
      // Check if the current cell is true (1)
      if (kMap[i][j]) {
        String maxterm = '';
        // Construct the minterm based on the adjusted indexes
                // \bar{y}  '}'

        if (numVariables > 2) maxterm += ((rowIndex & 2) == 0 ? '\\bar{' : '')+ vars[2] + ((rowIndex & 2) == 0 ? '}' : '') + "+"; // C
        if (numVariables > 3) maxterm += ((rowIndex & 1) == 0 ? '\\bar{' : '')+ vars[3] + ((rowIndex & 1) == 0 ? '}' : '') + "+"; // D
        if (numVariables > 0) maxterm += ((colIndex & 2) == 0 ? '\\bar{' : '')+ vars[0] + ((colIndex & 2) == 0 ? '}' : '') + "+"; // A
        if (numVariables > 1) maxterm += ((colIndex & 1) == 0 ? '\\bar{' : '')+ vars[1] + ((colIndex & 1) == 0 ? '}' : ''); // B
        
        // Add the minterm to the list
        maxterms.add(maxterm);
      }
    }
  }

  String maxtermsJoint = maxterms.join(' . ');
  //String result = AbsorptionLaw.solve(mintermsJoint);
  
  // Join all minterms with a + (OR) operator
  return maxtermsJoint;
}

String simplifyBooleanExpressions(List<String> expressions) {
  if (expressions.isEmpty) return '';

  // Split each expression into individual literals and store them in a list
  List<Set<String>> expressionLiterals = expressions.map((e) => e.split('').toSet()).toList();

  // Find common literals across all expressions
  Set<String> commonLiterals = expressionLiterals.fold<Set<String>>(expressionLiterals.first.toSet(), (a, b) => a.intersection(b));

  // Remove common literals from each expression, if they are redundant
  List<String> simplifiedExpressions = expressionLiterals.map((e) => e.difference(commonLiterals).join('')).toList();

  // Remove empty expressions and duplicates
  simplifiedExpressions = simplifiedExpressions.where((e) => e.isNotEmpty).toSet().toList();

  // Reconstruct the simplified expression
  String simplifiedResult = simplifiedExpressions.join(' + ');

  // Add back any common literals, if they were removed earlier
  if (commonLiterals.isNotEmpty && simplifiedExpressions.isNotEmpty) {
    simplifiedResult = commonLiterals.join('') + simplifiedResult;
  }

  return simplifiedResult.isEmpty ? '1' : simplifiedResult;
}

