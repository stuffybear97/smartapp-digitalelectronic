
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'calculations/number_system_functions.dart';
import 'calculations/kmap.dart';

import 'package:flutter/material.dart';
import 'package:flutter_tex/flutter_tex.dart';

import 'package:flutter_math_fork/ast.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'package:flutter_math_fork/tex.dart';

import 'mathdemo/demo.dart';
import 'mathdemo/equations.dart';
import 'mathdemo/feature.dart';



class newBaseNSolverPG2 extends StatefulWidget {
  @override
  _newBaseNSolverStatePG2 createState() => _newBaseNSolverStatePG2();
}

class _newBaseNSolverStatePG2 extends State<newBaseNSolverPG2> {
  List _result = ['',''];
  String dropdownValueArithmetic = '+'; //default the dropdown value to plus
  String dropdownValueUnknownSelection = 'x is unknown';
  TextEditingController _controllerA = TextEditingController();
  TextEditingController _controllerBaseA = TextEditingController();
  TextEditingController _controllerB = TextEditingController();
  TextEditingController _controllerBaseB = TextEditingController();
  TextEditingController _controllerZ = TextEditingController(); // Added TextField for Z

    void _convert() async {
      SystemChrome.setPreferredOrientations([
            DeviceOrientation.portraitUp,
                  DeviceOrientation.landscapeLeft,


    ]);
    List result = ['',''];
    String A = '';
    String B = '';
    String Z = '';
    String x = '';
    String y = '';
    if (dropdownValueArithmetic == '+') {
          if(dropdownValueUnknownSelection == "x is unknown"){
          A = _controllerA.text;
          B = _controllerB.text;
          Z = _controllerZ.text;
          y = _controllerBaseB.text;
          x = _controllerBaseA.text;
          result = calculateUnknownX_add(A,B,y,Z);
        }
        else if(dropdownValueUnknownSelection == "A is unknown")
        {
          A = _controllerA.text;
          B = _controllerB.text;
          Z = _controllerZ.text;
          y = _controllerBaseB.text;
          x = _controllerBaseA.text;
          result = calculateUnknownA_add(B,y,Z,x);
        }
        else{
          A = _controllerA.text;
          B = _controllerB.text;
          Z = _controllerZ.text;
          y = _controllerBaseB.text;
          x = _controllerBaseA.text;
          result = calculateUnknownX_add(A,B,y,Z);
        }
    } else if (dropdownValueArithmetic == '-') {
        if(dropdownValueUnknownSelection == "x is unknown"){
          A = _controllerA.text;
          B = _controllerB.text;
          Z = _controllerZ.text;
          y = _controllerBaseB.text;
          x = _controllerBaseA.text;
          result = calculateUnknownX_sub(A,B,y,Z);
        }
        else if(dropdownValueUnknownSelection == "A is unknown")
        {
          A = _controllerA.text;
          B = _controllerB.text;
          Z = _controllerZ.text;
          y = _controllerBaseB.text;
          x = _controllerBaseA.text;
          result = calculateUnknownA_sub(B,y,Z,x);
        }
        else{
          A = _controllerA.text;
          B = _controllerB.text;
          Z = _controllerZ.text;
          y = _controllerBaseB.text;
          x = _controllerBaseA.text;
          result = calculateUnknownX_sub(A,B,y,Z);
        }
    } else if (dropdownValueArithmetic == '*') {
      if(dropdownValueUnknownSelection == "x is unknown"){
          A = _controllerA.text;
          B = _controllerB.text;
          Z = _controllerZ.text;
          y = _controllerBaseB.text;
          x = _controllerBaseA.text;
          result = calculateUnknownX_mul(A,B,y,Z);
        }
        else if(dropdownValueUnknownSelection == "A is unknown")
        {
          A = _controllerA.text;
          B = _controllerB.text;
          Z = _controllerZ.text;
          y = _controllerBaseB.text;
          x = _controllerBaseA.text;
          result = calculateUnknownA_mul(B,y,Z,x);
        }
        else{
          A = _controllerA.text;
          B = _controllerB.text;
          Z = _controllerZ.text;
          y = _controllerBaseB.text;
          x = _controllerBaseA.text;
          result = calculateUnknownX_mul(A,B,y,Z);
        }
    } else if (dropdownValueArithmetic == '/') {
      if(dropdownValueUnknownSelection == "x is unknown"){
          A = _controllerA.text;
          B = _controllerB.text;
          Z = _controllerZ.text;
          y = _controllerBaseB.text;
          x = _controllerBaseA.text;
          result = calculateUnknownX_divide(A,B,y,Z);
        }
        else if(dropdownValueUnknownSelection == "A is unknown")
        {
          A = _controllerA.text;
          B = _controllerB.text;
          Z = _controllerZ.text;
          y = _controllerBaseB.text;
          x = _controllerBaseA.text;
          result = calculateUnknownA_divide(B,y,Z,x);
        }
        else{
          A = _controllerA.text;
          B = _controllerB.text;
          Z = _controllerZ.text;
          y = _controllerBaseB.text;
          x = _controllerBaseA.text;
          result = calculateUnknownX_divide(A,B,y,Z);
        }
      
    }

    

    setState(() {
      _result = result;
    });
  }  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('new Base N Solver'),
      ),
      body: Center(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Math.tex(
              "A_x + B_y = Z", 
              textStyle: TextStyle(color: const Color.fromARGB(255, 19, 21, 19)),
            ),
            //a dropwdown for selection of unknown variable A or x
            DropdownButton<String>(
              value: dropdownValueUnknownSelection,
              onChanged: (String? newValue) {
                setState(() {
                  dropdownValueUnknownSelection = newValue!;
                });
              },
              items: <String>['x is unknown', 'A is unknown']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),

            //row of textfields for input for A, subscript x, B, subscript y, and Z
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //textfield for A
                Container(
                  width: 50,
                  child: TextField(
                    controller: _controllerA,
                    decoration: InputDecoration(
                      hintText: 'A',
                    ),
                  ),
                ),
                //textfield for subscript x
                Container(
                  width: 50,
                  child: TextField(
                    controller: _controllerBaseA,
                    decoration: InputDecoration(
                      hintText: 'x',
                    ),
                  ),
                ),
                //drowpdown for selection of + or - or * or /
                DropdownButton<String>(
                  value: '+',
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownValueArithmetic = newValue!;
                    });
                  },
                  items: <String>['+', '-', '*', '/']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                //textfield for B
                Container(
                  width: 50,
                  child: TextField(
                    controller: _controllerB,
                    decoration: InputDecoration(
                      hintText: 'B',
                    ),
                  ),
                ),
                //textfield for subscript y
                Container(
                  width: 50,
                  child: TextField(
                    controller: _controllerBaseB,
                    decoration: InputDecoration(
                      hintText: 'y',
                    ),
                  ),
                ),
                Container(
                  width: 50,
                  child: Text(" = ")

                ),
                //textfield for Z
                Container(
                  width: 50,
                  child: TextField(
                    controller: _controllerZ,
                    decoration: InputDecoration(
                      hintText: 'Z',
                    ),
                  ),
                ),
              ],

            ),
            //button to solve the equation
            
            ElevatedButton(
              onPressed: _convert,
              child: Text('Solve'),
            ),
            //output the result in Math.tex in a scroll view  
            Expanded(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height - 300,
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Math.tex(
                          _result[0] + _result[1],
                          textScaleFactor: 1.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            ConstrainedBox(constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height,
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
                child: Row(children: [
                  Padding(padding:  EdgeInsets.all(8.0),
                  child: Math.tex(_result[0]+_result[1],textScaleFactor: 1.0,)
                  ),
                
                ],),
                      
            ),
            ),

            //text for the output that can does not lead to pixel overflow
            ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height,
              ),
              child: TeXView(
                renderingEngine: const TeXViewRenderingEngine.katex(),
                child: TeXViewDocument(_result[0]+_result[1]),
              ),
            ),
            

            ElevatedButton(
              onPressed: () {
                // Navigate back to the first page using a named route
                Navigator.pop(context);
              },
              child: Text('Return to Main Menu'),
            ),
          ],
        ),
      ),
    );
  }
}




class newBaseNSolver extends StatefulWidget {
  @override
  _newBaseNSolverState createState() => _newBaseNSolverState();
}

class _newBaseNSolverState extends State<newBaseNSolver> {
  List _result = ['','','',''];
  String dropdownValueArithmetic = '+'; //default the dropdown value to plus
  String dropdownValueUnknownSelection = 'x is unknown';
  TextEditingController _controllerA = TextEditingController();
  TextEditingController _controllerBaseA = TextEditingController();
  TextEditingController _controllerB = TextEditingController();
  TextEditingController _controllerBaseB = TextEditingController();
  TextEditingController _controllerZ = TextEditingController(); // Added TextField for Z

    void _convert() async {
      SystemChrome.setPreferredOrientations([
            DeviceOrientation.portraitUp,
                  DeviceOrientation.landscapeLeft,


    ]);
    List result = ['',''];
    String A = '';
    String B = '';
    String Z = '';
    String x = '';
    String y = '';
    if (dropdownValueArithmetic == '+') {
          if(dropdownValueUnknownSelection == "x is unknown"){
          A = _controllerA.text;
          B = _controllerB.text;
          Z = _controllerZ.text;
          y = _controllerBaseB.text;
          x = _controllerBaseA.text;
          result = calculateUnknownX_add(A,B,y,Z);
        }
        else if(dropdownValueUnknownSelection == "A is unknown")
        {
          A = _controllerA.text;
          B = _controllerB.text;
          Z = _controllerZ.text;
          y = _controllerBaseB.text;
          x = _controllerBaseA.text;
          result = calculateUnknownA_add(B,y,Z,x);
        }
        else{
          A = _controllerA.text;
          B = _controllerB.text;
          Z = _controllerZ.text;
          y = _controllerBaseB.text;
          x = _controllerBaseA.text;
          result = calculateUnknownX_add(A,B,y,Z);
        }
    } else if (dropdownValueArithmetic == '-') {
        if(dropdownValueUnknownSelection == "x is unknown"){
          A = _controllerA.text;
          B = _controllerB.text;
          Z = _controllerZ.text;
          y = _controllerBaseB.text;
          x = _controllerBaseA.text;
          result = calculateUnknownX_sub(A,B,y,Z);
        }
        else if(dropdownValueUnknownSelection == "A is unknown")
        {
          A = _controllerA.text;
          B = _controllerB.text;
          Z = _controllerZ.text;
          y = _controllerBaseB.text;
          x = _controllerBaseA.text;
          result = calculateUnknownA_sub(B,y,Z,x);
        }
        else{
          A = _controllerA.text;
          B = _controllerB.text;
          Z = _controllerZ.text;
          y = _controllerBaseB.text;
          x = _controllerBaseA.text;
          result = calculateUnknownX_sub(A,B,y,Z);
        }
    } else if (dropdownValueArithmetic == '*') {
      if(dropdownValueUnknownSelection == "x is unknown"){
          A = _controllerA.text;
          B = _controllerB.text;
          Z = _controllerZ.text;
          y = _controllerBaseB.text;
          x = _controllerBaseA.text;
          result = calculateUnknownX_mul(A,B,y,Z);
        }
        else if(dropdownValueUnknownSelection == "A is unknown")
        {
          A = _controllerA.text;
          B = _controllerB.text;
          Z = _controllerZ.text;
          y = _controllerBaseB.text;
          x = _controllerBaseA.text;
          result = calculateUnknownA_mul(B,y,Z,x);
        }
        else{
          A = _controllerA.text;
          B = _controllerB.text;
          Z = _controllerZ.text;
          y = _controllerBaseB.text;
          x = _controllerBaseA.text;
          result = calculateUnknownX_mul(A,B,y,Z);
        }
    } else if (dropdownValueArithmetic == '/') {
      if(dropdownValueUnknownSelection == "x is unknown"){
          A = _controllerA.text;
          B = _controllerB.text;
          Z = _controllerZ.text;
          y = _controllerBaseB.text;
          x = _controllerBaseA.text;
          result = calculateUnknownX_divide(A,B,y,Z);
        }
        else if(dropdownValueUnknownSelection == "A is unknown")
        {
          A = _controllerA.text;
          B = _controllerB.text;
          Z = _controllerZ.text;
          y = _controllerBaseB.text;
          x = _controllerBaseA.text;
          result = calculateUnknownA_divide(B,y,Z,x);
        }
        else{
          A = _controllerA.text;
          B = _controllerB.text;
          Z = _controllerZ.text;
          y = _controllerBaseB.text;
          x = _controllerBaseA.text;
          result = calculateUnknownX_divide(A,B,y,Z);
        }
      
    }

    

    setState(() {
      _result = result;
    });
  }  
  List<String> arithmeticItems = ['+', '-', '*', '/'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Base N Solver'),
      ),
      body: Center(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //a dropwdown for selection of unknown variable A or x
            DropdownButton<String>(
              value: dropdownValueUnknownSelection,
              onChanged: (String? newValue) {
                setState(() {
                  dropdownValueUnknownSelection = newValue!;
                });
              },
              items: <String>['x is unknown', 'A is unknown']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),

            //row of textfields for input for A, subscript x, B, subscript y, and Z
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //textfield for A
                Container(
                  width: 50,
                  child: TextField(
                    controller: _controllerA,
                    decoration: InputDecoration(
                      hintText: 'A',
                    ),
                  ),
                ),
                //textfield for subscript x
                Container(
                  width: 50,
                  child: TextField(
                    controller: _controllerBaseA,
                    decoration: InputDecoration(
                      hintText: 'x',
                    ),
                  ),
                ),
                //drowpdown for selection of + or - or * or /
                DropdownButton<String>(
                  value: dropdownValueArithmetic,
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownValueArithmetic = newValue!;
                    });
                  },
                  items: <String>['+', '-', '*', '/']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                //textfield for B
                Container(
                  width: 50,
                  child: TextField(
                    controller: _controllerB,
                    decoration: InputDecoration(
                      hintText: 'B',
                    ),
                  ),
                ),
                //textfield for subscript y
                Container(
                  width: 50,
                  child: TextField(
                    controller: _controllerBaseB,
                    decoration: InputDecoration(
                      hintText: 'y',
                    ),
                  ),
                ),

                //text to show the equal sign
                Container(
                  width: 30,
                  child: Text(
                          '=',
                          style: TextStyle(
                            fontSize: 20.0,
                          ),
                        )


                ),
                //textfield for Z
                Container(
                  width: 50,
                  child: TextField(
                    controller: _controllerZ,
                    decoration: InputDecoration(
                      hintText: 'Z',
                    ),
                  ),
                ),
              ],

            ),
            //button to solve the equation
            
            ElevatedButton(
              onPressed: _convert,
              child: Text('Solve'),
            ),
            //output the result in Math.tex in a scroll view  
            ConstrainedBox(constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height - 300,
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
                child: Row(children: [
                  Padding(padding:  EdgeInsets.all(8.0),
                  child: Math.tex(_result[2]+"~"+_result[3],textScaleFactor: 4.0,)
                  ),
                
                ],),
                      
            ),
            ),

            //text for the output that can does not lead to pixel overflow
            ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height - 300,
              ),
              child: TeXView(
                renderingEngine: const TeXViewRenderingEngine.katex(),
                child: TeXViewDocument(_result[0]+_result[1]),
              ),
            ),
            

            ElevatedButton(
              onPressed: () {
                // Navigate back to the first page using a named route
                Navigator.pop(context);
              },
              child: Text('Return to Main Menu'),
            ),
          ],
        ),
      ),
    );
  }
}




class NumbSysConversion extends StatefulWidget {
  @override
  _NumbSysConversionState createState() => _NumbSysConversionState();
}
const List<String> list = <String>['Binary to Dec', 'Dec to Binary', 'Dec to Hex', 'Hex to Dex'
,'Hex to Binary','Binary to Hex','dec to 2complements','hex to 2complements','baseN to Dec','Dec to baseN'];
String _selection = 'Binary to Dec';
String hintTextSelected = '';
String baseNhintTextSelected = '';
class DropdownButtonSelection extends StatefulWidget {
  //Add a callback function parameter to the constructor:
  final Function(String) onSelectionChanged;
  const DropdownButtonSelection({super.key, required this.onSelectionChanged});

  @override
  State<DropdownButtonSelection> createState() => _DropdownButtonSelection();
}

class _DropdownButtonSelection extends State<DropdownButtonSelection> {
  String dropdownValue = list.first;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String? value) {
        
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = value!;
          _selection = value; 
        });
        widget.onSelectionChanged(value!); // Call the callback function here

      },
      items: list.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}

class NumSysSelection {
  const NumSysSelection(this.selected);
  final String selected;
} 
class _NumbSysConversionState extends State<NumbSysConversion> {
  final TextEditingController  _controllerBDC= TextEditingController();
  final TextEditingController _controllerBaseN = TextEditingController();
  bool showBaseN = false;

  String _result = '';

  void _convert() async {
      SystemChrome.setPreferredOrientations([
            DeviceOrientation.portraitUp,
                  DeviceOrientation.landscapeLeft,


    ]);
    String result = '';
    String binaryString = '';
    if(_selection == "Binary to Dec"){
      showBaseN = false;
      binaryString = _controllerBDC.text;
        //hintTextSelected = 'Enter binary';
      result = await convertBinaryToDecimal(binaryString);
    }
    else if(_selection == "Dec to Binary")
    {
      showBaseN = false;
      binaryString = _controllerBDC.text;
      //hintTextSelected = 'Enter decimal';
      result = await convertDecimalToBinary(binaryString);

    }
    else if(_selection == "Dec to Hex") {
      showBaseN = false;
      binaryString = _controllerBDC.text;
      //hintTextSelected = 'Enter decimal';
      result = await convertDecimalToHex(binaryString);
    }
    else if(_selection == "Hex to Dex") {
      showBaseN = false;
      binaryString = _controllerBDC.text;
      //hintTextSelected = 'Enter Hex digits';
      result = await convertHexToDecimal(binaryString);
    }
    else if(_selection == "Hex to Binary") {
      showBaseN = false;
      binaryString = _controllerBDC.text;
      //hintTextSelected = 'Enter Hex digits';
      result = await convertHexToBinary(binaryString);
    }else if(_selection == "Binary to Hex") {
      showBaseN = false;
      binaryString = _controllerBDC.text;
      //hintTextSelected = 'Enter binary(limited to 32bits)';
      result = await convertBinaryToHex(binaryString);

    }else if(_selection == "dec to 2complements"){
      
      binaryString = _controllerBDC.text;
      //hintTextSelected = 'Enter dec(limited to 32bits)';
      result = await convertDecimalTo2sComplement(binaryString);
    }
    else if (_selection == "hex to 2complements"){
      binaryString = _controllerBDC.text;
      result = await convertHexTo2sComplement(binaryString);
    }
    //baseN to Dec
    else if(_selection == "baseN to Dec") 
    {
      binaryString = _controllerBDC.text;
      binaryString = binaryString + ", " + _controllerBaseN.text;

      result = await baseToDecimalConversion(_controllerBDC.text,_controllerBaseN.text);
    }
    else if(_selection == "Dec to baseN") 
    {
      binaryString = _controllerBDC.text;
      binaryString = binaryString + ", " + _controllerBaseN.text;
      result = await convertDecimalToBaseNGivenDec(_controllerBDC.text,_controllerBaseN.text);
    }
    else{
      //hintTextSelected = 'error default to BDC';
      binaryString = _controllerBDC.text;
      result = await convertBinaryToDecimal(binaryString);
    }

    setState(() {
      _result = result;
    });
  }  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        title: Text('number system conversion'),
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            DropdownButtonSelection(
                onSelectionChanged: (newValue) {
                setState(() {
                  _selection = newValue;
                  // Update hintTextSelected based on new selection
                  switch (_selection) {
                    case 'Binary to Dec':
                      hintTextSelected = 'Enter binary';
                      showBaseN = false;
                      break;
                    case 'Dec to Binary':
                      hintTextSelected = 'Enter decimal';
                      showBaseN = false;
                      break;
                    case 'Dec to Hex':
                      hintTextSelected = 'Enter decimal';
                      showBaseN = false;
                      break;
                    case 'Hex to Binary':
                      hintTextSelected = 'Enter hex';
                      showBaseN = false;
                      break;
                    case 'Binary to Hex':
                      hintTextSelected = 'Enter binary(limited to 32bits)';
                      showBaseN = false;
                      break;
                    case 'dec to 2complements':
                    hintTextSelected = 'Enter dec(limited to 32bits)';
                    showBaseN = false;
                    break;
                    case 'hex to 2complements':
                    hintTextSelected = 'Enter hex(limited to 32bits)';
                    showBaseN = false;
                    break;
                    case 'baseN to Dec':
                    showBaseN = true;
                    hintTextSelected = 'number,baseN (e.g. 101,2 or E,16)';
                    baseNhintTextSelected = 'baseN (e.g. if num is 101, input 2 or E,input 16)';
                    break;
                    case 'Dec to baseN':
                    showBaseN = true;
                    hintTextSelected = 'dec';
                    baseNhintTextSelected = 'desired baseN (e.g. if 8,input 2 to get 1000)';
                    break;
                    default:
                    showBaseN = false;
                      hintTextSelected = ''; 
                  }
                });
              },
            ),
            Text(_selection),
            TextField(
              controller: _controllerBDC,
              decoration: InputDecoration(
                hintText: hintTextSelected,
              ),
              //keyboardType: TextInputType.number,
            ),
            showBaseN? TextField(
              controller: _controllerBaseN,
              decoration: InputDecoration(
                hintText: baseNhintTextSelected,
              ),

            ):
            Container(),

            SizedBox(height: 20),
            TextButton(
              child: Text('Convert'),
              onPressed: 
              _convert, 
            ),
            
            Wrap(
            direction: Axis.horizontal,
            children: [
              ConstrainedBox(constraints: BoxConstraints(maxWidth: 800),
              child: 
              SingleChildScrollView(
                            physics: ClampingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            child: SelectableMath.tex(
                                _result,
                                textStyle: TextStyle(fontSize: 18),
                              ),
                            ),
              )
            ],
            
            ),

/*             ConstrainedBox(constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height - 300,
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
                child: Row(children: [
                  Padding(padding:  EdgeInsets.all(8.0),
                  child: Math.tex(_result,textScaleFactor: 4.0,)
                  ),
                
                ],),
                      
            ),
            ),
             */

            ElevatedButton(
              onPressed: () {
                // Navigate back to the first page using a named route
                Navigator.pop(context);
              },
              child: Text('Return to Main Menu'),
            ),
          ],
          
        ),
      ),
    );
  }
}

class NumberSystemBaseN extends StatefulWidget {
  @override
  _NumberSystemBaseNState createState() => _NumberSystemBaseNState();
}

class _NumberSystemBaseNState extends State<NumberSystemBaseN> {
  String dropdownValue = 'x is unknown';
  TextEditingController _controllerA = TextEditingController();
  TextEditingController _controllerBaseA = TextEditingController();
  TextEditingController _controllerB = TextEditingController();
  TextEditingController _controllerBaseB = TextEditingController();
  TextEditingController _controllerZ = TextEditingController(); // Added TextField for Z
  List _result = ['',''];
  void _convert() async {
      SystemChrome.setPreferredOrientations([
            DeviceOrientation.portraitUp,
                  DeviceOrientation.landscapeLeft,


    ]);
    List result = ['',''];
    String A = '';
    String B = '';
    String Z = '';
    String x = '';
    String y = '';
    if(dropdownValue == "x is unknown"){
      A = _controllerA.text;
      B = _controllerB.text;
      Z = _controllerZ.text;
      y = _controllerBaseB.text;
      x = _controllerBaseA.text;
      result = calculateUnknownX(A,B,y,Z);
    }
    else if(dropdownValue == "A is unknown")
    {
      A = _controllerA.text;
      B = _controllerB.text;
      Z = _controllerZ.text;
      y = _controllerBaseB.text;
      x = _controllerBaseA.text;
      //hintTextSelected = 'Enter decimal';
      result = calculateUnknownA(B,y,Z,x);
    }
    else{
      //hintTextSelected = 'error default to BDC';
      A = _controllerA.text;
      B = _controllerB.text;
      Z = _controllerZ.text;
      y = _controllerBaseB.text;
      x = _controllerBaseA.text;
      result = calculateUnknownX(A,B,y,Z);
    }

    setState(() {
      _result = result;
    });
  }  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('A_x + B_y = Z Solver'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DropdownButton<String>(
              value: dropdownValue,
              onChanged: (String? newValue) {
                setState(() {
                  dropdownValue = newValue!;
                });
              },
              items: <String>['x is unknown', 'A is unknown']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            TextField(
              controller: _controllerA,
              decoration: InputDecoration(
                hintText: 'A',
              ),
            ),
            TextField(
              controller: _controllerBaseA,
              decoration: InputDecoration(
                hintText: 'x:Base of A',
              ),
            ),
            TextField(
              controller: _controllerB,
              decoration: InputDecoration(
                hintText: 'B',
              ),
            ),
            TextField(
              controller: _controllerBaseB,
              decoration: InputDecoration(
                hintText: 'y:Base of B',
              ),
            ),
            TextField(
              controller: _controllerZ, // Added TextField for Z
              decoration: InputDecoration(
                hintText: 'Z', // Hint text for Z
              ),
            ),
            ElevatedButton(
              onPressed:_convert,
              child: Text('Find Unknown'),
            ),
            TeXView(
              renderingEngine: const TeXViewRenderingEngine.katex(),
              child:  TeXViewDocument(_result[0]),
              //_result,
              //style: TextStyle(fontSize: 20),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
                child: Row(children: [
                  Padding(padding:  EdgeInsets.all(8.0),
                  child: Math.tex(_result[0],textScaleFactor: 4.0,)
                  ),
                
                ],),
                      
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
                child: Row(children: [
                  Padding(padding:  EdgeInsets.all(8.0),
                  child: Math.tex(_result[1],textScaleFactor: 4.0,)
                  ),
                
                ],),
                      
            ),
            ElevatedButton(
              onPressed: () {
                // Navigate back to the first page using a named route
                Navigator.pop(context);
              },
              child: Text('Return to Main Menu'),
            ),
          ],
        ),
      ),
    );
  }
}



class Kmap extends StatefulWidget {
  @override
  _KmapState createState() => _KmapState();
}

class _KmapState extends State<Kmap> {
  int numVariables = 4;
  List<List<bool>> kMap = List.generate(4, (_) => List.generate(4, (_) => false));
  String result = '';
  String _result = '';
  String labelkmap = "AB    00 01 11 10 \nCD 00 [] [] [] []\n   01   [] [] [] []\n   11   [] [] [] []\n   10   [] [] [] []";

  void updateKMap() {
    int numRows = 1 << (numVariables ~/ 2);
    int numCols = 1 << (numVariables -numVariables ~/ 2);
    setState(() {
      kMap = List.generate(numRows, (_) => List.generate(numCols, (_) => false));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kmap'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            SizedBox(height: 20),
            Text('Number of Variables: $numVariables'),
            Slider(
              value: numVariables.toDouble(),
              min: 3,
              max: 4,
              divisions: 3,
              onChanged: (value) {
                setState(() {
                  numVariables = value.toInt();
                  switch(numVariables){
                    case 3:
                    labelkmap = "AB   00 01 11 10 \nC  0   [  ] [  ] [  ] [  ]\n    1   [  ] [  ] [  ] [  ]";
                    break;
                    case 4:
                    labelkmap ="AB    00 01 11 10 \nCD 00 [] [] [] []\n   01   [] [] [] []\n   11   [] [] [] []\n   10   [] [] [] []";
                    break;
                    default:
                    break;
                  }
                  updateKMap();
                });
              },
            ),
            SizedBox(height: 20),
          SizedBox(height: 20),
          Text(labelkmap),
          
          ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height - 300,
            ),
            child: GridView.builder(
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: kMap[0].length,
              ),
              itemCount: kMap.length * kMap[0].length,
              itemBuilder: (BuildContext context, int index) {
                final row = index ~/ kMap[0].length;
                final col = index % kMap[0].length;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      kMap[row][col] = !kMap[row][col];
                    });
                  },
                  child: Container(
                    color: kMap[row][col] ? Colors.blue : Colors.white,
                    child: Center(
                      child: Text(
                        kMap[row][col] ? '1' : '0',
                        style: TextStyle(fontSize: 24),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          Container(
            child: Row(
              children: <Widget>[
                 ElevatedButton(
                  child:  Text("give minterms"),
                  onPressed: () {
                        setState(() {
                          result = solveKMapMinTerms(kMap,numVariables);
                          _result = solveKMapMinTermsMathTex(kMap, numVariables);
                        });
                      },
                  ),
                ElevatedButton(
                  child: Text("give maxterms"),
                  onPressed: (){
                    setState(() {
                      result = solveKMapMaxTerm(kMap, numVariables);
                      _result = solveKMapMaxTermMathTex(kMap, numVariables);
                    });

                  },
                  ),
                  ElevatedButton(
                  child: Text("solve"),
                  onPressed: null,
                  ),
              ],

            ),
          ),
          

            SizedBox(height: 20),
            Text(
              'Result: $result',
              style: TextStyle(fontSize: 18),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
                child: Row(children: [
                  Padding(padding:  EdgeInsets.all(8.0),
                  child: Math.tex(_result,textScaleFactor: 4.0,)
                  ),
                
                ],),
                      
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Go Back to Main Menu'),
            ),
          ],
        ),
      ),
    );
  }
}


