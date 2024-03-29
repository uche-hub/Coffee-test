import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Coffee Test',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      home: MyHomePage(title: 'Coffee Test'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  int _selectedPosition = -1;
  
  String _coffeePrice ="0";

  int _cupsCounter =0;

  int price = 0;

  String _currency ="₦";

  static const String coffeeCup ="images/coffee_cup_size.png";

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: FlatButton(
          onPressed: (){
            //TODO: Uncomment the _confirmOrderModalBottomSheet() method to show summary of order
            _confirmOrderModalBottomSheet(totalPrice: "$_currency$price", numOfCups: "x $_cupsCounter");
          },
          child: Text("Buy Now",style: TextStyle(color: Colors.black87),),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0), side: BorderSide(color: Colors.blue))
        ),
        actions: [
          InkWell(
            onTap: (){
              //TODO: Uncomment the setState() function to clear the price and cups
              //TODO: Change the 'price' to 0 when this button is clicked
              setState(() {
              this.price = 0;
              this._cupsCounter =0;
              // });
            },
            child: Icon(Icons.clear),
          ),
          Container(
            height: double.maxFinite,
            alignment: Alignment.center,
            child: Text("$_cupsCounter Cups = $_currency$price.00", style: TextStyle(fontSize: 18),),
          )
        ],
      ),
      body: Padding(padding: EdgeInsets.all(20), child: _mainBody(),) // This trailing comma makes auto-formatting nicer for build methods.
    );
  }


  Widget _mainBody(){
    return Container(
      height: double.maxFinite,
      width: double.maxFinite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 0,
              child: Stack(
            children: [
              Container(
                width: double.maxFinite,
                height: 250,
                margin: EdgeInsets.only(left: 50, right: 50, bottom: 50, top: 60),
                decoration: BoxDecoration(borderRadius:
                BorderRadius.all(Radius.circular(180)),
                    color: Color.fromRGBO(239, 235, 233, 100)),
              ),
              Container(
                alignment: Alignment.center,
                width: double.maxFinite,
                height: 350,
                child: Image.asset("images/cup_of_coffee.png", height: 300,),
              )
            ],
          )),
          Padding(padding: EdgeInsets.all(10),),
          Expanded(flex: 0,child: Text("Caffè Americano",
            style: TextStyle(fontWeight: FontWeight.bold,
              fontSize: 30),)),
          Padding(padding: EdgeInsets.all(6),),
          Expanded(flex: 0, child: Text("Select the cup size you want and we will deliver it to you in less than 48hours",
            style: TextStyle(fontWeight: FontWeight.bold,
              fontSize: 14, color: Colors.black45,),
            textAlign: TextAlign.start,),
          ),
          Container(
            margin: EdgeInsets.only(top: 30, left: 20),
            height: 55,
            width: double.maxFinite,
            alignment: Alignment.center,
            child:Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                RichText(text: TextSpan(
                  text: _currency,
                  style: TextStyle(fontWeight: FontWeight.bold,
                      fontSize: 25, color: Colors.black87),
                  children: [
                    TextSpan(text: _coffeePrice, style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold))
                  ]
                ),),
                Padding(
                  padding: EdgeInsets.only(right: 15),
                ),
                ListView.builder(itemBuilder: (context, index){

                  return InkWell(
                    child: _coffeeSizeButton(_selectedPosition == index,
                        index ==0? "S" : index ==1? "M": "L"),
                    onTap: (){
                      setState(() {
                        this._coffeePrice= index ==0? "300" : index ==1? "600": "900";
                        _selectedPosition = index;
                      });
                    },
                  );
                }, scrollDirection: Axis.horizontal,
                  itemCount: 3, shrinkWrap: true,),

              ],),
          ),

          Container(
            margin: EdgeInsets.only(top: 30),
            padding: EdgeInsets.all(10),
            width: double.maxFinite,
            height: 70,
            child: FlatButton(onPressed: (){
              //TODO: Currently _cupsCounter only show 1 when this button is clicked.
              // TODO: Increment the _cupsCounter when 'Add to Bag' button is clicked'
              //TODO: Call setState((){}) method to update both price and cups counter when 'Add to Bag' button is clicked

              // put the increment inside the setState to perform the increment
              // which at the same time will provide an update for price.

              /*
              When updating your values, putting the operation i.e _cupsCounter += 1;
              in setState will update the state of your widget which makes values change in your widgets.
               */

              /*
              Also you can use setState by putting it after your operation which will update the state of your widget after the operation is done.
               */
              setState((){
                  _cupsCounter += 1; // make it +=1 instead of =1.
                  price += int.parse(_coffeePrice);
                  }); // call setState like this
            }, child: Center(child: Text("Add to Bag",
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),)
              ,),
              color: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50)
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _coffeeSizeButton(bool isSelected, String coffeeSize){
    return Stack(
      children: [
        Container(alignment: Alignment.center,  width: 55,
          child: Text(coffeeSize, style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold,
              color: isSelected? Colors.blue: Colors.black45),),),
        new Container(
          margin: EdgeInsets.only(right: 10),
          child: Image.asset(coffeeCup, width:50, color: isSelected ? Colors.blue: Colors.black45,),
          decoration: BoxDecoration(border: Border(top: BorderSide(color: isSelected? Colors.blue: Colors.black45,
              width: isSelected? 2: 1), left: BorderSide(color: isSelected? Colors.blue: Colors.black45,
              width: isSelected? 2: 1), bottom: BorderSide(color: isSelected? Colors.blue: Colors.black45,
              width: isSelected? 2: 1), right:  BorderSide(color: isSelected ?Colors.blue: Colors.black45 ,
              width: isSelected? 2: 1)), borderRadius: BorderRadius.all(Radius.circular(5))),
        )
      ],
    );
  }

  void _confirmOrderModalBottomSheet({String totalPrice, String numOfCups}){
    showModalBottomSheet(
        context: context,
        builder: (builder){
          return new Container(
            height: 150.0,
            color: Colors.transparent, //could change this to Color(0xFF737373),
            //so you don't have to change MaterialApp canvasColor
            child: new Container(
              padding: EdgeInsets.all(10),
                decoration: new BoxDecoration(
                    color: Colors.white,
                    borderRadius: new BorderRadius.only(
                        topLeft: const Radius.circular(10.0),
                        topRight: const Radius.circular(10.0))),
                child: Column(
                  children: [
                    Container(
                      child: Text("Confirm Order",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
              alignment: Alignment.center, height: 30, decoration: BoxDecoration(
            ), ),
                    _getEstimate(totalPrice, numOfCups)
                  ],
                )),
          );
        }
    );
  }

  Widget _getEstimate(String totalPrice, String numOfCups){
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Image.asset("images/cup_of_coffee.png", height: 70, width: 50,),
        Padding(padding: EdgeInsets.all(10)),
        Text(numOfCups, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
        Padding(padding: EdgeInsets.all(10)),
        Text(totalPrice, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),)
      ],
    );
  }

}
