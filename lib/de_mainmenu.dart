

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

class de_mainmenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Digital Electronics'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
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
            child: Text('Base N solver + - * /'),
          ),
          
          
          ElevatedButton(
            onPressed: () {
              // Navigate to the fourth page using a named route
              Navigator.pushNamed(context, '/fourth');
            },
            child: Text('kMap'),
          ),
          
        ],
      ),
    );
  }
}