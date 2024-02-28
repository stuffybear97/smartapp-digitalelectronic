import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'calculations/number_system_functions.dart';

import 'package:flutter/material.dart';
import 'package:flutter_tex/flutter_tex.dart';

import 'package:flutter_math_fork/ast.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'package:flutter_math_fork/tex.dart';

import 'mathdemo/demo.dart';
import 'mathdemo/equations.dart';
import 'mathdemo/feature.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
  
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => FirstPage(),
        '/second': (context) => SecondPage(),
        '/third': (context) => ThirdPage(),
        '/fourth': (context) => FourthPage(),
        '/fifth': (context) => FifthPage(),
        '/LaTex test': (context) => TeXViewDocumentExamples(),
        '/MathTest': (context) => MathExample()
        //Math.tex(r'\frac a b', mathStyle: MathStyle.text)

        
      },
    );
  }
}

class FirstPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Main Menu'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ElevatedButton(
            onPressed: () {
              // Navigate to the second page using a named route
              Navigator.pushNamed(context, '/second');
            },
            child: Text('Go to basic number system'),
          ),
          ElevatedButton(
            onPressed: () {
              // Navigate to the third page using a named route
              Navigator.pushNamed(context, '/third');
            },
            child: Text('Go to intermidiet number system'),
          ),
          ElevatedButton(
            onPressed: () {
              // Navigate to the fourth page using a named route
              Navigator.pushNamed(context, '/fourth');
            },
            child: Text('Go to expert number system'),
          ),
          ElevatedButton(
            onPressed: () {
              // Navigate to the fourth page using a named route
              Navigator.pushNamed(context, '/LaTex test');
            },
            child: Text('laTex example'),
          ),
          ElevatedButton(
            onPressed: () {
              // Navigate to the fourth page using a named route
              Navigator.pushNamed(context, '/fifth');
            },
            child: Text('Go to fifht Page'),
            
          ),
          ElevatedButton(
            onPressed: () {
              // Navigate to the fourth page using a named route
              Navigator.pushNamed(context, '/MathTest');
            },
            child: Text('go to math example'),
            
          ),
        ],
      ),
    );
  }
}

/* class SecondPage extends StatefulWidget {

/* class _SecondPageState extends State<SecondPage> {
  String decimalValue = '';
  String binaryValue = '';
  late Future<String>  binaryPlaceholder;
  binaryPlaceholder = convertBinaryToDecimal(decimalValue);
  setState((){
  binaryValue = convertBinaryToDecimal(decimalValue)
  }); */
  /* void convertBinaryToDecimal() {
    try {
      int decimal = int.parse(binaryValue, radix: 2);
      setState(() {
        decimalValue = decimal.toString();
      });
    } catch (e) {
      setState(() {
        decimalValue = 'Invalid Input';
      });
    } */
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Binary to Decimal Converter'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              onChanged: (value) {
                
                  binaryValue = value;
                
              },
              decoration: InputDecoration(labelText: 'Enter Binary Number'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                convertBinaryToDecimal();
              },
              child: Text('Convert'),
            ),
            SizedBox(height: 16),
            Text('Decimal Value: $decimalValue'),
            Spacer(),
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
} */

class SecondPage extends StatefulWidget {
  @override
  _SecondPageState createState() => _SecondPageState();
}
const List<String> list = <String>['Binary to Dec', 'Dec to Binary', 'Dec to Hex', 'Hex to Dex'
,'Hex to Binary','Binary to Hex','dec to 2complements','hex to 2complements'];
String _selection = 'Binary to Dec';
String hintTextSelected = '';
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
class _SecondPageState extends State<SecondPage> {
  final TextEditingController _controllerBDC = TextEditingController();
  String _result = '';

  void _convert() async {
      SystemChrome.setPreferredOrientations([
            DeviceOrientation.portraitUp,
                  DeviceOrientation.landscapeLeft,


    ]);
    String result = '';
    String binaryString = '';
    if(_selection == "Binary to Dec"){
      binaryString = _controllerBDC.text;
        //hintTextSelected = 'Enter binary';
      result = await convertBinaryToDecimal(binaryString);
    }
    else if(_selection == "Dec to Binary")
    {
      binaryString = _controllerBDC.text;
      //hintTextSelected = 'Enter decimal';
      result = await convertDecimalToBinary(binaryString);

    }
    else if(_selection == "Dec to Hex") {
      binaryString = _controllerBDC.text;
      //hintTextSelected = 'Enter decimal';
      result = await convertDecimalToHex(binaryString);
    }
    else if(_selection == "Hex to Dex") {
      binaryString = _controllerBDC.text;
      //hintTextSelected = 'Enter Hex digits';
      result = await convertHexToDecimal(binaryString);
    }
    else if(_selection == "Hex to Binary") {
      binaryString = _controllerBDC.text;
      //hintTextSelected = 'Enter Hex digits';
      result = await convertHexToBinary(binaryString);
    }else if(_selection == "Binary to Hex") {
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
        title: Text('number system easy'),
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
                      break;
                    case 'Dec to Binary':
                      hintTextSelected = 'Enter decimal';
                      break;
                    case 'Dec to Hex':
                      hintTextSelected = 'Enter decimal';
                      break;
                    case 'Hex to Binary':
                      hintTextSelected = 'Enter hex';
                      break;
                    case 'Binary to Hex':
                      hintTextSelected = 'Enter binary(limited to 32bits)';
                      break;
                    case 'dec to 2complements':
                    hintTextSelected = 'Enter dec(limited to 32bits)';
                    break;
                    case 'Hex to 2complements':
                    hintTextSelected = 'Enter hex(limited to 32bits)';
                    break;
                    default:
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
            SizedBox(height: 20),
            TextButton(
              child: Text('Convert'),
              onPressed: 
              _convert, 
            ),
            SizedBox(height: 20),
            
            TeXView(
              renderingEngine: const TeXViewRenderingEngine.katex(),
              child:  TeXViewDocument(_result),
              //_result,
              //style: TextStyle(fontSize: 20),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
                child: Row(children: [
                  Padding(padding:  EdgeInsets.all(8.0),
                  child: Math.tex(_result,textScaleFactor: 4.0,)
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

class ThirdPage extends StatefulWidget {
  @override
  _ThirdPageState createState() => _ThirdPageState();
}

class _ThirdPageState extends State<ThirdPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Third Page'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Navigate back to the first page using a named route
            Navigator.pop(context);
          },
          child: Text('Go Back to Main Menu'),
        ),
      ),
    );
  }
}

class FourthPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fourth Page'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Navigate back to the first page using a named route
            Navigator.pop(context);
          },
          child: Text('Go Back to Main Menu'),
        ),
      ),
    );
  }
}

class FifthPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Fifth Page'),
      ),
      // ignore: prefer_const_constructors
      body:  TeXView(
        renderingEngine: const TeXViewRenderingEngine.katex(),
        child: const TeXViewDocument(r'''
          <h2>Mathematical Symbols in LaTeX</h2>
          <p>
            test:
          </p>
          <p>
            <br><b>Summation:</b> \( \sum_{i=1}^{n} i^2 \)
            <br><b>Integral:</b> \( \int_{a}^{b} x^2 dx \)
            <br><b>Matrix:</b> \( \begin{bmatrix} a & b \\ c & d \end{bmatrix} \)
            <br><b>Equation:</b> \( E=mc^2 \)
          </p>
        '''),
      ),
              floatingActionButton: FloatingActionButton(
          onPressed: () {
                        Navigator.pop(context);

           },
          child: const Text("goback"),)

    );
  }
}

class MathExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Flutter Math Demo v0.2.0',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: DefaultTabController(
          length: 3,
          child: Scaffold(
            appBar: AppBar(
              title: Text(
                'Flutter Math Demo v0.2.0',
              ),
              bottom: TabBar(tabs: [
                Text('Interactive Demo'),
                Text('Equation Samples'),
                Text('Supported Features'),
              ]),
            ),
            body: TabBarView(children: [
              DemoPage(),
              EquationsPage(),
              FeaturePage(),
            ]),
          ),
        ),
      );
}

class TeXExample {
  static TeXViewWidget introduction =
      _teXViewWidget(r"""<h4>Flutter \( \rm\TeX \)</h4>""", r""" 
             
      <p>Flutter \( \rm\TeX \) is a Flutter Package to render so many types of equations based on \( \rm\LaTeX \), It also includes full HTML with JavaScript
      support.</p>
      """);

  static TeXViewWidget quadraticEquation =
      _teXViewWidget(r"<h4>Quadratic Equation</h4>", r"""
     When \(a \ne 0 \), there are two solutions to \(ax^2 + bx + c = 0\) and they are
     $$x = {-b \pm \sqrt{b^2-4ac} \over 2a}.$$<br>""");

  static TeXViewWidget mathML =
      _teXViewWidget(r"<h4>MathML (MathJax Only)</h4>", r"""
<math xmlns = "http://www.w3.org/1998/Math/MathML">
   <mrow>
      <mrow>
         <msup> <mi>x</mi> <mn>2</mn> </msup> <mo>+</mo>
         <mrow>
            <mn>4</mn>
            <mo>⁢</mo>
            <mi>x</mi>
         </mrow>
         <mo>+</mo>
         <mn>4</mn>
      </mrow>
      
      <mo>=</mo>
      <mn>0</mn>
   </mrow>
</math>""");

  static TeXViewWidget bohrRadius = _teXViewWidget(r"<h4>Bohr's Radius</h4>",
      r"""\( a_0 = \frac{{\hbar ^2 }}{{m_e ke^2 }} \)""");

  static TeXViewWidget relationEnergyPrincipalQuantum = _teXViewWidget(
      r"<h4>Relationship between Energy and Principal Quantum Number</h4>",
      r"""\( E_n = - R_H \left( {\frac{1}{{n^2 }}} \right) = \frac{{ - 2.178 \times 10^{ - 18} }}{{n^2 }}joule \)""");

  static TeXViewWidget chemistryEquations =
      _teXViewWidget(r"<h4>Chemistry Equations</h4>", r"""<p>    
     \( \ce{CO2 + C -> 2 CO} \) <br>
     \( \ce{Hg^2+ ->[I-] HgI2 ->[I-] [Hg^{II}I4]^2-} \)<br>
     Scroll long formulas in Katex $$ \ce{x Na(NH4)HPO4 ->[\Delta] (NaPO3)_x + x Nh4 ^ + x H2O} $$ <br>
    </p>""");

  static TeXViewWidget matrix = _teXViewWidget(r"<h4>Matrix</h4>", r"""<p>
     $$ \begin{bmatrix}
         a & b \\
         c & d
      \end{bmatrix}$$</p>""");

  static TeXViewWidget alignedTag =
      _teXViewWidget(r"<h4>Aligned Tag</h4>", r"""    
           $$
           \begin{aligned}
           \dot{x} & = \sigma(y-x) \\
           \dot{y} & = \rho x - y - xz \\
           \dot{z} & = -\beta z + xy
           \end{aligned}
           $$""");

  static TeXViewWidget others = _teXViewWidget(r"<h4> Others </h4>", r"""<p>    
    $$ \oint_C {E \cdot d\ell = - \frac{d}{{dt}}} \int_S {B_n dA} $$<br>
    
     $$
     y = \frac{{n!}}{{k!\left( {n - k} \right)!}}p^k q^{n - k}  = \left( {\begin{array}{*{20}c}
              n  \\
              k  \\
            \end{array}} \right)p^k q^{n - k} 
     $$

    </p>""");

  static TeXViewWidget _teXViewWidget(String title, String body) {
    return TeXViewColumn(
        style: const TeXViewStyle(
            margin: TeXViewMargin.all(10),
            padding: TeXViewPadding.all(10),
            borderRadius: TeXViewBorderRadius.all(10),
            border: TeXViewBorder.all(TeXViewBorderDecoration(
                borderWidth: 2,
                borderStyle: TeXViewBorderStyle.groove,
                borderColor: Colors.green))),
        children: [
          TeXViewDocument(title,
              style: const TeXViewStyle(
                  padding: TeXViewPadding.all(10),
                  borderRadius: TeXViewBorderRadius.all(10),
                  textAlign: TeXViewTextAlign.center,
                  width: 250,
                  margin: TeXViewMargin.zeroAuto(),
                  backgroundColor: Colors.green)),
          TeXViewDocument(body,
              style: const TeXViewStyle(margin: TeXViewMargin.only(top: 10)))
        ]);
  }
}

class TeXViewDocumentExamples extends StatelessWidget {
  final TeXViewRenderingEngine renderingEngine;

  const TeXViewDocumentExamples(
      {super.key, this.renderingEngine = const TeXViewRenderingEngine.katex()});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("TeXViewDocument"),
      ),
      body: TeXView(
        renderingEngine: renderingEngine,
        child: TeXViewColumn(children: [
          TeXExample.introduction,
          TeXExample.mathML,
          TeXExample.quadraticEquation,
          TeXExample.relationEnergyPrincipalQuantum,
          TeXExample.alignedTag,
          TeXExample.bohrRadius,
          TeXExample.chemistryEquations,
          TeXExample.matrix,
          TeXViewDetails(
            title: "sdfsdfsdsd",
            style: const TeXViewStyle(backgroundColor: Colors.amber),
            body: TeXExample.matrix,
          ),
          if (renderingEngine.name == 'mathjax') ...[TeXExample.others]
        ]),
        style: const TeXViewStyle(
          margin: TeXViewMargin.all(10),
          elevation: 10,
          borderRadius: TeXViewBorderRadius.all(25),
          border: TeXViewBorder.all(
            TeXViewBorderDecoration(
                borderColor: Colors.blue,
                borderStyle: TeXViewBorderStyle.solid,
                borderWidth: 5),
          ),
          backgroundColor: Colors.white,
        ),
      ),
    );
  }
}

/* class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("test"),
          centerTitle: true,
          backgroundColor: const Color.fromRGBO(255, 0, 0, 50),
        ),
        body: Row(
          children: [
            Text(testText),
            TextButton(onPressed: (){
              // Navigate to the second page
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const NumberConverter()),
            );
            }, 
            child: const Text('Hello World'))
          ],

            
        
        ),
        
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            
           },
          child: const Text("test"),

        ),
      ),
    );
  }
}

class NumberConverter extends StatelessWidget {
  const NumberConverter({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Second Route'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
            // Navigate back to first route when tapped.
          },
          child: const Text('Go back!'),
        ),
      ),
    );
  }
}
 */