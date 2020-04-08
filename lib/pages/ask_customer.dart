import 'package:etteo_demo/custome/custome_button.dart';
import 'package:etteo_demo/custome/custome_radio_button.dart';
import 'package:etteo_demo/pages/access_home_page.dart';
import 'package:flutter/material.dart';

class AskCustomerToTakeServeyOrNot extends StatefulWidget {
  @override
  _AskCustomerToTakeServeyOrNotState createState() => _AskCustomerToTakeServeyOrNotState();
}

class _AskCustomerToTakeServeyOrNotState extends State<AskCustomerToTakeServeyOrNot> {
  dynamic selectedValue = '';
  List<RadioModel> sampleData = new List<RadioModel>();

  @override
  void initState() {
    super.initState();
    sampleData.add(new RadioModel(false, 'Yes'));
    sampleData.add(new RadioModel(false, 'No'));
  }
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
     return Scaffold(
      body: Stack(
        children: <Widget>[
          Positioned(
            top: 60,
            left: 20,
            child: Container(
              child: Text("Did you ask the customer\nto take the survey?",style: TextStyle(fontSize:size.height/29),),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Center(
                  child: Container(
                    alignment: Alignment.center,
                    height: MediaQuery.of(context).size.height/4,
                    width:MediaQuery.of(context).size.width/2,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/icons/Customer_Survey.png")
                      )
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height/10,),
                buildWidget(0,size.height/34),
                Divider(color: Colors.grey,),
                buildWidget(1,size.height/34),
              ],
            ),
          ),

         Positioned(
            bottom: 20,
            child: CustomBorderRoundedButton(
              text: "Next",
              callback: selectedValue == 'Yes'  ||  selectedValue == 'No' ?()=> Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AdditionalUpgradeItemToAddOrNot())):null
            
            )
          ),
          Positioned(
            top: 20,
            right: 0,
            child: IconButton(
              icon: Icon(Icons.close,color:Colors.black),
              onPressed: (){
                Navigator.pop(context);
              }
            )
          )
        ],
      ),
    );
  }
   Widget buildWidget(int index, double size){
    return InkWell(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(sampleData[index].text,style: TextStyle(fontSize:size)),
          Icon(Icons.check,
          color:sampleData[index].isSelected ? Colors.blue : Colors.white,         
          ),
        ],
      ),
      onTap: (){
        setState(() {
            sampleData.forEach((element) => element.isSelected = false);
            sampleData[index].isSelected = true;
            selectedValue = sampleData[index].text;
          });
      },
    );
  }
}