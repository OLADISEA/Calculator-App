import 'package:flutter/material.dart';
import 'package:calculator/identity.dart';
import 'package:math_expressions/math_expressions.dart';


class Home extends StatefulWidget {
  Home({ Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<HomeButton> buttonList = [
    HomeButton(buttonText: 'C'),
    HomeButton(buttonText: '⌫'),
    HomeButton(buttonText: '%'),
    HomeButton(buttonText: '÷',gridColor: Colors.blueAccent,textColor: Colors.white),
    HomeButton(buttonText: '7'),
    HomeButton(buttonText: '8'),
    HomeButton(buttonText: '9'),
    HomeButton(buttonText: '⨯',gridColor: Colors.blueAccent,textColor: Colors.white),
    HomeButton(buttonText: '4'),
    HomeButton(buttonText: '5'),
    HomeButton(buttonText: '6'),
    HomeButton(buttonText: '-', gridColor: Colors.blueAccent,textColor: Colors.white),
    HomeButton(buttonText: '1'),
    HomeButton(buttonText: '2'),
    HomeButton(buttonText: '3'),
    HomeButton(buttonText: '+',gridColor: Colors.blueAccent,textColor: Colors.white),
    HomeButton(buttonText: '00'),
    HomeButton(buttonText: '0'),
    HomeButton(buttonText: '.'),
    HomeButton(buttonText: '=', gridColor: Colors.redAccent,textColor: Colors.white)

  ];
  String calculating = '';
  String result = '';
  String expression = '';


  void calculate(HomeButton hb){
    setState(() {
      if(hb.buttonText == '=' ){
        expression = calculating;
        expression = expression.replaceAll('⨯','*');
        expression = expression.replaceAll('÷','/');
        expression = expression.replaceAll('%','/100');
        try{
          Parser p = new Parser();
          Expression exp = p.parse(expression);

          ContextModel cm = ContextModel();
          result = '${exp.evaluate((EvaluationType.REAL), cm)}';
        }catch(e){
          result = 'Error';
        }
        calculating = '';
        result = result;
      }else if(hb.buttonText == 'C'){
        calculating = '';
        result = '0';
      }else if(hb.buttonText =='⌫'){
        calculating = calculating.substring(0, calculating.length - 1);
      }else{
        if(calculating == '0'){
          calculating = '';
        }
        calculating += hb.buttonText;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    result = calculating;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Simple Calculator'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              margin: EdgeInsets.only(top: 100.0),
              padding: EdgeInsets.fromLTRB(0, 0, 10.0, 0),
              alignment: Alignment.bottomRight,
              child: Text('$calculating',
                  style: TextStyle(fontSize: 35.0,fontWeight: FontWeight.bold),),


              ),
            ),
          Expanded(
              flex: 2,
            child: Container(
              margin: EdgeInsets.only(top: 40.0),
              alignment: Alignment.bottomRight,
              padding: EdgeInsets.fromLTRB(0,0,10.0,0),
              child: Text('$result',
              style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.bold
              ))
            )
          ),

          Expanded(
            flex: 5,
                child: GridView.builder(
                  itemCount: buttonList.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      mainAxisSpacing: 9,
                      crossAxisSpacing: 9,
                      childAspectRatio: 1.2,

                    ),
                    itemBuilder: (context, index){
                      return SizedBox(
                        height: 15.0,
                        width: 15.0,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: buttonList[index].gridColor,
                          ),

                          onPressed: () {calculate(buttonList[index]);},
                          child: Text(buttonList[index].buttonText,
                          style: TextStyle(
                              fontSize: buttonList[index].buttonText == '=' || buttonList[index].buttonText == 'x'?
                              35.0 : 25.0,
                              color: buttonList[index].textColor,
                              fontWeight: FontWeight.normal
                          ),
                          ),
                        ),
                      );
                    }
                )
              )
        ],
      ),
    );
  }
}
