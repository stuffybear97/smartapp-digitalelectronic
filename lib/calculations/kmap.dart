String solveKMap(List<List<bool>> kMap, int numVariables) {
  // Define the variable names (up to 4 variables)
  List<String> vars = ['A', 'B', 'C', 'D'];
  
  // Ensure the number of variables does not exceed the size of 'vars'
  if (numVariables > 4) {
    return 'Number of variables exceeds limit of 4.';
  }
  
  // Initialize an empty list for minterms
  List<String> minterms = [];

  // Iterate over the K-map
  for (int i = 0; i < kMap.length; i++) {
    for (int j = 0; j < kMap[i].length; j++) {
      // Check if the current cell is true (1)
      if (kMap[i][j]) {
        String minterm = '';
        // Adjust variable assignment based on their positions
        if (numVariables > 2) minterm += vars[2] + ((i & 2) == 0 ? '\'' : ''); // C
        if (numVariables > 3) minterm += vars[3] + ((i & 1) == 0 ? '\'' : ''); // D
        if (numVariables > 0) minterm += vars[0] + ((j & 2) == 0 ? '\'' : ''); // A
        if (numVariables > 1) minterm += vars[1] + ((j & 1) == 0 ? '\'' : ''); // B
        
        // Add the minterm to the list
        minterms.add(minterm);
      }
    }
  }
  
  // Join all minterms with a + (OR) operator
  return minterms.join(' + ');
}
