
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:test1/de_pages.dart';
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
import 'de_mainmenu.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
  
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => MainMenu(),
        '/de_mainmenu':(context) => de_mainmenu(),
        '/NumbSysConversion': (context) => NumbSysConversion(),
        '/NumberSystemBaseN': (context) => NumberSystemBaseN(),
        '/fourth': (context) => Kmap(),
        '/fifth': (context) => FifthPage(),
        '/LaTex test': (context) => TeXViewDocumentExamples(),
        '/MathTest': (context) => MathExample(),
        //Math.tex(r'\frac a b', mathStyle: MathStyle.text)
        '/newBaseNSolver':  (context) => newBaseNSolver(),
        '/newBaseNSolverPage2':  (context) => newBaseNSolverPG2()

        
      },
    );
  }
}

class MainMenu extends StatelessWidget {
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
              Navigator.pushNamed(context, '/de_mainmenu');
            },
            child: Text('to De Main Menu'),
          ),
          ElevatedButton(
            onPressed: () {
              // Navigate to the second page using a named route
              Navigator.pushNamed(context, '/NumbSysConversion');
            },
            child: Text('number system conversion'),
          ),
          ElevatedButton(
            onPressed: () {
              // Navigate to the third page using a named route
              Navigator.pushNamed(context, '/newBaseNSolverPage2');
            },
            child: Text('Base N addition page2'),
          ),
          ElevatedButton(
            onPressed: () {
              // Navigate to the third page using a named route
              Navigator.pushNamed(context, '/newBaseNSolver');
            },
            child: Text('new base N solver'),
          ),
          
          ElevatedButton(
            onPressed: () {
              // Navigate to the fourth page using a named route
              Navigator.pushNamed(context, '/fourth');
            },
            child: Text('kMap'),
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





/* class Kmap extends StatefulWidget {
  @override
  _KmapState createState() => _KmapState();
}

class _KmapState extends State<Kmap> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kmap'),
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
 */

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





//Tex codes for reference, to remove later

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

