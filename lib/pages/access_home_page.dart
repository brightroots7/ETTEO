

import 'dart:io';

import 'package:etteo_demo/custome/custome_button.dart';
import 'package:etteo_demo/custome/custome_radio_button.dart';
// import 'package:etteo_demo/model/home_access_model/home_access_model.dart';
import 'package:etteo_demo/pages/ask_customer.dart';
import 'package:etteo_demo/pages/signature_page.dart';
import 'package:etteo_demo/pages/start_service_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:multi_image_picker/multi_image_picker.dart';


class AccessHomePage extends StatefulWidget {
  @override
  _AccessHomePageState createState() => _AccessHomePageState();
}

class _AccessHomePageState extends State<AccessHomePage> {

  dynamic yesOrNot  = '';
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
              child: Text("Were you able to access the\nhome for the service call?",style: TextStyle(fontSize:size.height/30),),
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
                        image: AssetImage("assets/icons/House.png")
                      )
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height/10,),
                buildWidget(0, size.height/34, 'yes'),
                Divider(color: Colors.grey, ),
                buildWidget(1, size.height/34,'no')
                // CustomRadio()
              ],
            ),
          ),
          Positioned(
            bottom: 20,
            child: CustomBorderRoundedButton(
              text: "Next",
              callback: yesOrNot == 'yes'?
              ()=>Navigator.of(context).push(MaterialPageRoute(builder: (context)=>FeeCollectorPage()))
              :yesOrNot == 'no'?()=> Navigator.of(context).push(MaterialPageRoute(builder: (context)=>NotAbleToAccessTheHome()))
              :null

             
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


 Widget buildWidget(int index, double size, selectedVal){
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
            yesOrNot = selectedVal;
          });
      },
    );
  }
}

























class NotAbleToAccessTheHome extends StatefulWidget {
  @override
  _NotAbleToAccessTheHomeState createState() => _NotAbleToAccessTheHomeState();
}

class _NotAbleToAccessTheHomeState extends State<NotAbleToAccessTheHome> {
 List<RadioModel> sampleData = new List<RadioModel>();
 dynamic selectedValue = '';
  @override
  void initState() {
    super.initState();
    sampleData.add(new RadioModel(false, 'Customer not at home'));
    sampleData.add(new RadioModel(false, 'Customer refused service'));
    sampleData.add(new RadioModel(false, 'Customer cancelled on site'));
    sampleData.add(new RadioModel(false, 'Other'));
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
              child: Text("Why weren't you able to\naccess the home?",style: TextStyle(fontSize:size.height/29),),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                 SizedBox(height:size.height/16),
                Center(
                  child: Container(
                    alignment: Alignment.center,
                    height: MediaQuery.of(context).size.height/4,
                    width:MediaQuery.of(context).size.width/2,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/icons/House.png")
                      )
                    ),
                  ),
                ),
                SizedBox(height:size.height/16),
                 Container(
                  alignment: Alignment.topCenter,
                  height: MediaQuery.of(context).size.height/3.6,
                   child: ListView.builder(
                     itemCount: sampleData.length,
                     itemBuilder: (context, index){
                       return Column(
                         children: <Widget>[
                           InkWell(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(sampleData[index].text,style: TextStyle(fontSize:size.height/36)),
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
                              ),
                            Divider(color: Colors.grey,),
                         ],
                       );
                     }
                    ),
                )
                // buildWidget(0,size.height/35),
                // Divider(color: Colors.grey,),
                // buildWidget(1,size.height/35),
                // Divider(color: Colors.grey,),
                // buildWidget(2,size.height/35),
                // Divider(color: Colors.grey,),
                // buildWidget(3,size.height/35),
              ],
            ),
          ),
         Positioned(
            bottom: 20,
            child: CustomBorderRoundedButton(
              text: "Next",
              callback: 
              selectedValue == 'Other' ?
              ()=>Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ExplainNotAbleToAccessHome()))

              :selectedValue == 'Customer not at home'
              || selectedValue == 'Customer refused service'
              ||selectedValue == 'Customer cancelled on site'?
              ()=>Navigator.of(context).push(MaterialPageRoute(builder: (context)=>TakePhotosPage()))
              :null

              // (){
              //   if(selectedValue == 'Other')
              //    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ExplainNotAbleToAccessHome()));
              // },
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
            selectedValue =sampleData[index].text;
          });
      },
    );
  }
}












class ExplainNotAbleToAccessHome extends StatefulWidget {
  @override
  _ExplainNotAbleToAccessHomeState createState() => _ExplainNotAbleToAccessHomeState();
}

class _ExplainNotAbleToAccessHomeState extends State<ExplainNotAbleToAccessHome> {
  TextEditingController explainTextController = new TextEditingController();
  String explainText = '';
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
     return Scaffold(
      body: Stack(
         children: <Widget>[
          Container(
            // color: Colors.red,
            height: MediaQuery.of(context).size.height ,
            padding: const EdgeInsets.only(left:30.0, right: 30, top: 60),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: size.width,
                    // color: Colors.red,
                    child: Text("Explain why weren't you able\nto access the home?",style: TextStyle(fontSize:size.height/32,),),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height/18,),
                  Center(
                  child: Container(
                    //  padding: const EdgeInsets.only(top: 60),
                    alignment: Alignment.center,
                    height: MediaQuery.of(context).size.height/4,
                    width:MediaQuery.of(context).size.width/2,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/icons/House.png")
                      )
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height/16,),
                  Container(
                    alignment: Alignment.topLeft,
                    width: MediaQuery.of(context).size.width/1.2,
                    height: MediaQuery.of(context).size.height/3.5,
                    decoration:BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Colors.grey,width: 2)
                    ) ,
                    child: TextField(
                      maxLines: 5,
                      // controller: explainTextController,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(8),
                        hintText: "Enter a desription explaining why\nyou were not able to access the home",
                         hintStyle: TextStyle(fontSize: size.height/50),
                        border: InputBorder.none
                      ),
                      onChanged: (val){
                         setState(() {
                           explainText = val;
                         });
                      },
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height/20,),
                  CustomBorderRoundedButton(
                    text: "Next",
                    callback:explainText != '' ?
                    ()=>
                      
                      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>TakePhotosPage()),(e) => false)
                    
                    :null
                    
                  )
                ],
              ),
            ),
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
}











class TakePhotosPage extends StatefulWidget {
  @override
  _TakePhotosPageState createState() => _TakePhotosPageState();
}

class _TakePhotosPageState extends State<TakePhotosPage> {
  //  BaseHomeAccessModel baseHomeAccessModel = new BaseHomeAccessModel(
  //   headerString: "Take a photo of the\ncustomers home",
  //   buttonText: "Finish",
  //   imageUrl: "https://img.icons8.com/officel/2x/add-image.png"
  //   );

  List<File> assetList = List<File>();
  String _error = 'No Error Dectected';





  // Widget buildGridView() {
  //   return GridView.count(
  //     crossAxisCount: 3,      
  //     children: List.generate(assetList.length, (index) {
  //       Asset asset = assetList[index];        
  //       return ViewImages(
  //         index,         
  //         asset,          
  //         key: UniqueKey(),       
  //       );      
  //     }),
  //   );  
  // }


  // Future<void> loadAssets() async {
  //   setState(() {
  //     assetList = List<Asset>();    
  //   });
  //   List<Asset> resultList = List<Asset>();    
  //   String error = 'No Error Dectected';
  //   try {
  //     resultList = await MultiImagePicker.pickImages(
  //       maxImages: 300,        
  //       enableCamera: false,        
  //       // options: CupertinoOptions(takePhotoIcon: "chat"),      
  //     );    
  //   } on PlatformException catch (e) {
  //     error = e.message;    
  //   }
  //   if (!mounted) return;
  //   setState(() {
  //     assetList = resultList;      
  //     _error = error;    
  //   });  
  // }






  @override
  Widget build(BuildContext context) {
    // print("assetList:${assetList.length}");
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Positioned(
            top: 60,
            left: 20,
            child: Container(
              child: Text("Take a photo of the\ncustomers home",style: TextStyle(fontSize:size.height/29),),
            ),
          ),
          Column(
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
                      image: AssetImage("assets/icons/Upload_Photos.png")
                    )
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height/30,),
              // SizedBox(height:30),
              CustomRoundedButton(
                text: "  Take\nPhotos",
                callback: ()async{
                  var image = await ImagePicker.pickImage(source: ImageSource.gallery);
                  if(image != null){
                    setState(() {
                    assetList.add(image);
                  });
                  }
                }
              ),
              SizedBox(height: MediaQuery.of(context).size.height/30,),
              assetList.length>0?
              Container(
                padding: const EdgeInsets.all(2),
                alignment: Alignment.center,
                height: 90,
                // width: 50,
                // color: Colors.black,
                child:ListView.builder(
                  itemCount: assetList.length,
                   scrollDirection: Axis.horizontal,
                   itemBuilder: (context, index){
                     var _asset = assetList[index];
                     
                    return  Row(
                      children: <Widget>[
                        Container(
                          height: 90,
                          width: 90,
                           decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                             image: DecorationImage(
                             image:FileImage(_asset),
                             fit: BoxFit.cover
                            //  AssetImage("assets/icons/Upload_Photos.png")
                            
                             )
                           ),
                         ),
                         SizedBox(width:10),
                        ],
                      );
                    },
                    
                  )
                
              )
              :Container()
            ],
          ),
         Positioned(
            bottom: 20,
            child: CustomBorderRoundedButton(
              text: "Finish",
              callback: assetList.length>0 ?
              ()=>
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (BuildContext context) => StartServicePage()),
                  ModalRoute.withName('/'),
                )
              :null
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
}




class FeeCollectorPage extends StatefulWidget {
  @override
  _FeeCollectorPageState createState() => _FeeCollectorPageState();
}

class _FeeCollectorPageState extends State<FeeCollectorPage> {
  
  //  BaseHomeAccessModel baseHomeAccessModel = new BaseHomeAccessModel(
  //   headerString: "Did you collect a service\nfee?",
  //   buttonText: "Next",
  //   imageUrl: "https://png.pngtree.com/png-vector/20190810/ourmid/pngtree-cost-fee-male-money-payment-salary-user-blue-dotted-line-l-png-image_1654820.jpg",
  //   onCancelButtonPressed: (){
  //   //  Navigator.of(context).pop();
  //   }
  //   );
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
              child: Text("Did you collect a service\nfee?",style: TextStyle(fontSize:size.height/29),),
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
                        image: AssetImage("assets/icons/Payment.png")
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
              callback: selectedValue == 'Yes' ?()=> Navigator.of(context).push(MaterialPageRoute(builder: (context)=>PaymentMethodPage()))
              :selectedValue == 'No'?()=> Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ServiceFeeNotCollectedPage()))
              :null
              // (){
              //   if(selectedValue == 'Yes')
              //    {
              //      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>PaymentMethodPage()));
              //    }else if(selectedValue == 'No'){
              //       Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ServiceFeeNotCollectedPage()));
              //    }
              // },
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





class ServiceFeeNotCollectedPage extends StatefulWidget {
  @override
  _ServiceFeeNotCollectedPageState createState() => _ServiceFeeNotCollectedPageState();
}

class _ServiceFeeNotCollectedPageState extends State<ServiceFeeNotCollectedPage> {
  dynamic selectedValue = '';
   List<RadioModel> sampleData = new List<RadioModel>();
  

  @override
  void initState() {
    super.initState();
    sampleData.add(new RadioModel(false, 'Customer refused to pay'));
    sampleData.add(new RadioModel(false, 'service fee already collected'));
    sampleData.add(new RadioModel(false, 'Service not required'));
    sampleData.add(new RadioModel(false, 'Other'));
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
              child: Text("Why was a service fee\nnot collected?",style: TextStyle(fontSize:size.height/29),),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: MediaQuery.of(context).size.height/11,),
                Center(
                  child: Container(
                    alignment: Alignment.center,
                    height: MediaQuery.of(context).size.height/4,
                    width:MediaQuery.of(context).size.width/2,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/icons/Payment.png")
                      )
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height/15,),

                Container(
                  // color: Colors.red,
                   alignment: Alignment.topLeft,
                  height: MediaQuery.of(context).size.height/3.1,
                   child: ListView.builder(
                     itemCount: sampleData.length,
                     itemBuilder: (context, index){
                       return Column(
                         children: <Widget>[
                           
                           InkWell(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(sampleData[index].text,style: TextStyle(fontSize:size.height/36)),
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
                              ),
                            Divider(color: Colors.grey,),
                         ],
                       );
                     }
                    ),
                )
                // buildWidget(0, size.height/35),
                // Divider(color: Colors.grey,),
                // buildWidget(1, size.height/35),
                // Divider(color: Colors.grey,),
                // buildWidget(2, size.height/35),
                // Divider(color: Colors.grey,),
                //  buildWidget(3, size.height/35),
              ],
            ),
          ),
         Positioned(
            bottom: 20,
            child: CustomBorderRoundedButton(
              text: "Next",
              callback: selectedValue == 'Other'
              ?()=> Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ServiceFeeNotCollectedDescription()))
              : selectedValue == 'Customer refused to pay' 
              || selectedValue == 'service fee already collected'
              || selectedValue == 'Service not required'
              ?()=>Navigator.of(context).push(MaterialPageRoute(builder: (context)=>TakePhotosOfCurrentSitePage()))
              :null
              // Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AdditionalItemsIdentifyDescription())); == sampleData[0].text?()=> Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ServiceFeeNotCollectedDescription()))
              // :null
              // (){
              //   if(selecteValue == sampleData[0].text)
              //   {
              //      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ServiceFeeNotCollectedDescription()));
              //   }
              // },
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
            selectedValue =  sampleData[index].text;
          });
      },
    );
  }
}

class ServiceFeeNotCollectedDescription extends StatefulWidget {
  @override
  _ServiceFeeNotCollectedDescriptionState createState() => _ServiceFeeNotCollectedDescriptionState();
}

class _ServiceFeeNotCollectedDescriptionState extends State<ServiceFeeNotCollectedDescription> {
  //  BaseHomeAccessModel baseHomeAccessModel = new BaseHomeAccessModel(
  //   headerString: "Why was a service fee\nnot collected?",
  //   buttonText: "Next",
  //   imageUrl: "https://png.pngtree.com/png-vector/20190810/ourmid/pngtree-cost-fee-male-money-payment-salary-user-blue-dotted-line-l-png-image_1654820.jpg",
  //   onCancelButtonPressed: (){
  //   //  Navigator.of(context).pop();
  //   }
  //   );

  String explainText = '';

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
   return Scaffold(
      body: Stack(
         children: <Widget>[
          Container(
            // color: Colors.red,
            height: MediaQuery.of(context).size.height ,
            padding: const EdgeInsets.only(left:30.0, right: 30, top: 60),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: size.width,
                    // color: Colors.red,
                    child: Text("Why was a service fee\nnot collected?",style: TextStyle(fontSize:size.height/29,),),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height/18,),
                  Center(
                  child: Container(
                    //  padding: const EdgeInsets.only(top: 60),
                    alignment: Alignment.center,
                    height: MediaQuery.of(context).size.height/4,
                    width:MediaQuery.of(context).size.width/2,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/icons/Payment.png")
                      )
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height/16,),
                  Container(
                    alignment: Alignment.topLeft,
                    height: MediaQuery.of(context).size.height/3.5,
                    decoration:BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Colors.grey,width: 2)
                    ) ,
                    child: TextField(
                      maxLines: 5,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(8),
                        hintText: "Enter a desription explaining why\na service fee was not collected",
                        hintStyle: TextStyle(fontSize: size.height/50),
                        border: InputBorder.none
                      ),
                      onChanged: (val){
                        setState(() {
                          explainText = val;
                        });
                      },
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height/20,),
                  CustomBorderRoundedButton(
                    text: "Next",
                    callback: explainText != ''?
                     ()=> Navigator.of(context).push(MaterialPageRoute(builder: (context)=>TakePhotosOfCurrentSitePage()))
                    :null
                  )
                ],
              ),
            ),
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
}



class PaymentMethodPage extends StatefulWidget {
  @override
  _PaymentMethodPageState createState() => _PaymentMethodPageState();
}

class _PaymentMethodPageState extends State<PaymentMethodPage> {
  List<RadioModel> sampleData = new List<RadioModel>();
  dynamic selectedValue = '';
  @override
  void initState() {
    super.initState();
    sampleData.add(new RadioModel(false, 'Cash'));
    sampleData.add(new RadioModel(false, 'Credit card'));
    sampleData.add(new RadioModel(false, 'Check'));
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
              child: Text("Method of collection",style: TextStyle(fontSize:size.height/29),),
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
                        image: AssetImage("assets/icons/Payment.png")
                      )
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height/10,),
                buildWidget(0,size.height/34),
                Divider(color: Colors.grey,),
                buildWidget(1,size.height/34),
                Divider(color: Colors.grey,),
                buildWidget(2,size.height/34),
             ],
           ),
         ),
          Positioned(
            bottom: 20,
            child: CustomBorderRoundedButton(
              text: "Next",
              callback: selectedValue!= ''?()=> Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AmountCollectorPage())):null
              // selectedValue == sampleData[0].text?()=>Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AmountCollectorPage()))
              // :null
              //  (){
              //   if(selectedValue == sampleData[0].text){
              //      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AmountCollectorPage()));
              //   }
               
              // },
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
            selectedValue =  sampleData[index].text;
          });
      },
    );
  }
}

class AmountCollectorPage extends StatefulWidget {
  @override
  _AmountCollectorPageState createState() => _AmountCollectorPageState();
}

class _AmountCollectorPageState extends State<AmountCollectorPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
     return Scaffold(
      body: Stack(
         children: <Widget>[
          Container(
            // color: Colors.red,
            height: MediaQuery.of(context).size.height ,
            padding: const EdgeInsets.only(left:30.0, right: 30, top: 60),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: size.width,
                    // color: Colors.red,
                    child: Text("Amount Collected",style: TextStyle(fontSize:size.height/29,),),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height/18,),
                  Center(
                    child: Container(
                      //  padding: const EdgeInsets.only(top: 60),
                      alignment: Alignment.center,
                      height: MediaQuery.of(context).size.height/4,
                      width:MediaQuery.of(context).size.width/2,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/icons/Payment.png")
                        )
                      ),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height/8,),
                  Container(
                    height:  MediaQuery.of(context).size.height/12,
                    child: TextField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        
                        border: OutlineInputBorder(),
                        hintText:"Enter Amount",
                        contentPadding: const EdgeInsets.all(5),
                        prefix: Text("\$",style: TextStyle(fontSize:20,color: Colors.black),)
                      ),
                    ),
                  ),
                  SizedBox(height: size.height/5,),
                  CustomBorderRoundedButton(
                    text: "Next",
                    callback: (){
                       Navigator.of(context).push(MaterialPageRoute(builder: (context)=>TakePhotosOfCurrentSitePage()));
                    },
                  )
                ],
              ),
            ),
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
}
// Working mode

class TakePhotosOfCurrentSitePage extends StatefulWidget {
  @override
  _TakePhotosOfCurrentSitePageState createState() => _TakePhotosOfCurrentSitePageState();
}

class _TakePhotosOfCurrentSitePageState extends State<TakePhotosOfCurrentSitePage> {

  List<File> assetList = List<File>();


  String _error = 'No Error Dectected';





  // Widget buildGridView() {
  //   return GridView.count(
  //     crossAxisCount: 3,      
  //     children: List.generate(assetList.length, (index) {
  //       Asset asset = assetList[index];        
  //       return ViewImages(
  //         index,         
  //         asset,          
  //         key: UniqueKey(),       
  //       );      
  //     }),
  //   );  
  // }


  // Future<void> loadAssets() async {
  //   // setState(() {
  //   //   assetList = List<Asset>();    
  //   // });
  //   // List<Asset> resultList = List<Asset>(); 
  //   var resultList;   
  //   String error = 'No Error Dectected';
  //   try {
  //      resultList = await MultiImagePicker.pickImages(
  //       maxImages: 300,        
  //       enableCamera: true,        
  //       // options: CupertinoOptions(takePhotoIcon: "chat"),      
  //     );    
  //   } on PlatformException catch (e) {
  //     error = e.message;    
  //   }
  //   if (!mounted) return;
  //   setState(() {
  //     assetList = resultList;  
      
  //     _error = error;    
  //   });  
  // }



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
              child: Text("Take a photo of the current\nsite conditions",style: TextStyle(fontSize:size.height/29),),
            ),
          ),
          Column(
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
                      image: AssetImage("assets/icons/Upload_Photos.png")
                    )
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height/30,),
              // SizedBox(height:30),
              CustomRoundedButton(
                text: "  Take\nPhotos",
                callback: ()async{
                  // loadAssets();
                  var image = await ImagePicker.pickImage(source: ImageSource.gallery);
                  if(image != null){
                    setState(() {
                    assetList.add(image);
                  });
                  }
                   
                },
              ),
              
              SizedBox(height: MediaQuery.of(context).size.height/30,),
              assetList.length>0 ?
              Container(
                padding: const EdgeInsets.all(2),
                alignment: Alignment.center,
                height: MediaQuery.of(context).size.height/8,
                child:ListView.builder(
                  itemCount: assetList.length,
                   scrollDirection: Axis.horizontal,
                   itemBuilder: (context, index){
                     var _asset = assetList[index];
                      //  _asset.requestOriginal();
                      //  _asset.getByteData();
                    return  Row(
                      children: <Widget>[
                        Container(
                          // color: Colors.red,
                          height:  MediaQuery.of(context).size.height/8,
                          width: MediaQuery.of(context).size.height/8,
                           decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                             image: DecorationImage(
                             image:FileImage(_asset),
                             fit: BoxFit.cover
                            //  AssetImage("assets/icons/Upload_Photos.png")
                            
                             )
                           ),
                         ),
                         SizedBox(width:10),
                        ],
                      );
                    },
                    
                  )
                
              )
              :Container()
            ],
          ),
         Positioned(
            bottom: 20,
            child: CustomBorderRoundedButton(
              text: "Next",
              callback:assetList.length>0 ?
               ()=> Navigator.of(context).push(MaterialPageRoute(builder: (context)=>VerifyPage()))
              :null
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
}


//  class ViewImages extends StatefulWidget {
//   final int _index;  final Asset _asset;
//   ViewImages(
//       this._index,      this._asset, {
//         Key key,      }) : super(key: key);
//   @override  State<StatefulWidget> createState() => AssetState(this._index, this._asset);}


//   class AssetState extends State<ViewImages> {
//   int _index = 0;  Asset _asset;  AssetState(this._index, this._asset);
//   @override  void initState() {
//     super.initState();    _loadImage();  }

//   void _loadImage() async {
//     await this._asset.requestThumbnail(300, 300, quality: 50);
//     if (this.mounted) {
//       setState(() {});    }
//   }

//   @override  Widget build(BuildContext context) {
//     if (null != this._asset.thumbData) {
//       return Image.memory(
//         this._asset.thumbData.buffer.asUint8List(),        fit: BoxFit.cover,        gaplessPlayback: true,      );    }

//     return Text(
//       '${this._index}',      style: Theme.of(context).textTheme.headline,    );  }
// }













//https://pluspng.com/img-png/google-maps-png-google-maps-icon-png-file-512x512-pixel-512.png

class VerifyPage extends StatefulWidget {
  @override
  _VerifyPageState createState() => _VerifyPageState();
}

class _VerifyPageState extends State<VerifyPage> {
  List<RadioModel> sampleData = new List<RadioModel>();
  dynamic selectedValue = '';


  

  @override
  void initState() {
    super.initState();
    sampleData.add(new RadioModel(false, 'Yes'));
    sampleData.add(new RadioModel(false, 'No'));
  }


  
  @override
  void dispose() {
   selectedValue = '';
    super.dispose();
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
              child: Text("Did you verify that\n[Line_Item_1] is correct?",style: TextStyle(fontSize:size.height/29),),
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
                        image: AssetImage("assets/icons/Line_Items.png")
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
              callback: selectedValue == sampleData[0].text ?()=> Navigator.of(context).push(MaterialPageRoute(builder: (context)=>TakePhotosOfItemsPage()))
              :selectedValue == sampleData[1].text ?()=> Navigator.of(context).push(MaterialPageRoute(builder: (context)=>CorrectServiceItem()))
              :null
              // (){
              //   if(selectedValue == sampleData[0].text ){
                 
              //    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>TakePhotosOfItemsPage()));
              //   }else if(selectedValue == sampleData[1].text){
              //     Navigator.of(context).push(MaterialPageRoute(builder: (context)=>CorrectServiceItem()));
              //   }
                
              // },
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
            selectedValue =  sampleData[index].text;
          });
      },
    );
  }

}

class CorrectServiceItem extends StatefulWidget {
  @override
  _CorrectServiceItemState createState() => _CorrectServiceItemState();
}

class _CorrectServiceItemState extends State<CorrectServiceItem> {
  List<RadioModel> sampleData = new List<RadioModel>();
  List<String> data = [
    'Garbase disposal',
    'Faucet',
    'Toilet',
    'Sink',
    'Water Closet',
    'Water Heater',
    'Drain',
    'Instant Hot Water Dispenser',
    'Leaks',
    'Sewer Ejector Pump',
    'Septic System',
    'Shower Base Pans/Encloser',
    'Sink-Non ParceLain',
    'Slab Leaks',
    'Stoppage',
    'Sump Pump',
    'Valves',
    'Water Heater-2nd Unit',
    'Water Heater-3nd Unit',
    'Water Heater(Gas or Elec)',
    'Water Softener',
    'Well Pumps',
    'Whirlpool Tub',
    'Hose Bibb',
    'Jetted Bathtub'
    'Pipe',
    'Pipe:In Slab',
    'Pipe:Under Home',
    'Pressure Regulator',
    'Shower/Tub',
    'Valve:Angle Stop',
    'Valve:Gate',
    'Main Shut Off',
    'Plumbing Sttopage',
    'Crculating Pump',
    'Sink',
    'Water Heater:Electric',
    'Water Heater:Natural Gas',
    'Water Heater:Propane',
    'Water Heater:Tankless',
    'Reverse Osmosis Filtrain System',
  ];
 
  dynamic selectedValue = '';
  @override
  void initState() {
    super.initState();
    data.sort();

    for(int i =0 ; i<data.length; i++ ){
      sampleData.add(new RadioModel(false, data[i]));
    }
  }
  @override
  Widget build(BuildContext context) {
     final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Positioned(
            top: 55,
            left: 20,
            child: Container(
              child: Text("What is the correct\nservice item?",style: TextStyle(fontSize:size.height/29),),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: MediaQuery.of(context).size.height/10,),
                Center(
                  child: Container(
                    alignment: Alignment.center,
                    height: MediaQuery.of(context).size.height/4,
                    width:MediaQuery.of(context).size.width/2,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/icons/Line_Items.png")
                      )
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height/15,),
                Container(
                  alignment: Alignment.topCenter,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height/3.6,
                   child: ListView.builder(
                     itemCount: sampleData.length,
                     itemBuilder: (context, index){
                       return Column(
                         mainAxisAlignment: MainAxisAlignment.start,
                         children: <Widget>[
                           InkWell(
                                child: Row(
                                  // crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(sampleData[index].text,style: TextStyle(fontSize:size.height/36)),
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
                              ),
                            Divider(color: Colors.grey,),
                          ],
                        );
                      }
                    ),
                 )
              ],
            ),
          ),
          Positioned(
            bottom: 20,
            child: CustomBorderRoundedButton(
              text: "Next",
              callback: selectedValue!= ''?
              (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>CompletedItemOrNot()));
              }
              :null
              // =>Navigator.of(context).push(MaterialPageRoute(builder: (context)=>CompletedItemOrNot()))
              // selectedValue != ''?
              // ()=> Navigator.pushAndRemoveUntil(
              //       context,
              //       MaterialPageRoute(builder: (BuildContext context) => VerifyPage()),
              //       ModalRoute.withName('/'),
              //     )
              //     :null
             
              
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
            selectedValue =  sampleData[index].text;
          });
      },
    );
  }
}



class TakePhotosOfItemsPage extends StatefulWidget {
  @override
  _TakePhotosOfItemsPageState createState() => _TakePhotosOfItemsPageState();
}

class _TakePhotosOfItemsPageState extends State<TakePhotosOfItemsPage> {

  List<File> assetList = List<File>();
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
              child: Text("Take a photo of\n[Line_Item_1]",style: TextStyle(fontSize:size.height/29),),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
               SizedBox(height: MediaQuery.of(context).size.height/10,),
              Center(
                child: Container(
                  alignment: Alignment.center,
                  height: MediaQuery.of(context).size.height/4,
                  width:MediaQuery.of(context).size.width/2,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/icons/Line_Item_Photos.png")
                    )
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height/30,),
              // SizedBox(height:30),
              CustomRoundedButton(
                text: "  Take\nPhotos",
                callback: ()async{
                  // var resultList = await MultiImagePicker.pickImages(
                  //   maxImages :  10 ,
                  //   enableCamera: true,
                  // );
                  var image = await ImagePicker.pickImage(source: ImageSource.gallery);
                  if(image != null){
                    setState(() {
                    assetList.add(image);
                  });
                  }

                },
              ),
              SizedBox(height: MediaQuery.of(context).size.height/30,),
              assetList.length>0?
              Container(
                padding: const EdgeInsets.all(2),
                alignment: Alignment.center,
                height: 90,
                // width: 50,
                // color: Colors.black,
                child:ListView.builder(
                  itemCount: assetList.length,
                   scrollDirection: Axis.horizontal,
                   itemBuilder: (context, index){
                     var _asset = assetList[index];
                    return  Row(
                      children: <Widget>[
                        Container(
                          // color: Colors.red,
                          height: 90,
                          width: 90,
                           decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                             image: DecorationImage(
                             image:FileImage(_asset),
                             fit: BoxFit.cover
                            
                            
                             )
                           ),
                         ),
                         SizedBox(width:10),
                        ],
                      );
                    },
                    
                  )
                
              )
              :Container()
            ],
          ),
         Positioned(
            bottom: 20,
            child: CustomBorderRoundedButton(
              text: "Next",
              callback: assetList.length>0 ?
              ()=> Navigator.of(context).push(MaterialPageRoute(builder: (context)=>CustomersCurrentUnitInfo()))
              :null
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
}




class CustomersCurrentUnitInfo extends StatefulWidget {
  @override
  _CustomersCurrentUnitInfoState createState() => _CustomersCurrentUnitInfoState();
}

class _CustomersCurrentUnitInfoState extends State<CustomersCurrentUnitInfo> {
  String makeString = '';
  String modelString = '';
  String serialString = '';
  String ageString = '';
  String hintString = '';


  Widget buildTextFieldContainer(String hint, String valueString){
    return Container(
      alignment: Alignment.center,
      height: MediaQuery.of(context).size.height/15,
      child: TextField(
        keyboardType: hint == "Age" ? TextInputType.number:TextInputType.text,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText:hint,
          contentPadding: const EdgeInsets.all(10)
          
        ),
        onChanged: (val){
          if(hint == 'Make*'){
           setState(() {
              makeString = val;
           });
          }
          setState(() {
            valueString = val;
          });
        },
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: <Widget>[
       
          Center(
            child: Container(
              // color: Colors.red,
              // height: MediaQuery.of(context).size.height/1,
              alignment: Alignment.center,
              padding: const EdgeInsets.only(left:20.0, right: 20.0,top:40),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                     child: Text("Enter the customer current\nunit information",style: TextStyle(fontSize:size.height/29),),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height/25,),
                    Center(
                      child: Container(
                        alignment: Alignment.center,
                        height: MediaQuery.of(context).size.height/4,
                        width:MediaQuery.of(context).size.width/2,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/icons/Current_Unit_Information.png")
                          )
                        ),
                      ),
                    ),
                   SizedBox(height: MediaQuery.of(context).size.height/20,),
                   buildTextFieldContainer("Make*", makeString),
                   SizedBox(height: MediaQuery.of(context).size.height/40,),
                   buildTextFieldContainer("Model",modelString),
                   SizedBox(height: MediaQuery.of(context).size.height/40,),
                   buildTextFieldContainer("Serial",serialString),
                    
                    SizedBox(height: MediaQuery.of(context).size.height/40,),
                    buildTextFieldContainer("Age",ageString),
                    SizedBox(height: MediaQuery.of(context).size.height/30,),
                    CustomBorderRoundedButton(
                      text: "Next",
                      callback:makeString !='' ?
                       ()=>Navigator.of(context).push(MaterialPageRoute(builder: (context)=>FindItemLocation()))
                        
                      :null
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height/180,),
                    
                  ],
                ),
              ),
            ),
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
}

class FindItemLocation extends StatefulWidget {
  @override
  _FindItemLocationState createState() => _FindItemLocationState();
}

class _FindItemLocationState extends State<FindItemLocation> {
  List<RadioModel> sampleData = new List<RadioModel>();
  List<String> data = [
   "Kitchen",
    "Owner's Bedroom",
    "Owner's Bathroom",
    'Bedroom',
    'Basement',
    'Garage',
    'Hall Bathroom',
    'Powder Bathroom',
    'Jack & jill Bathroom',
    'Living Room',
    'Family Room',
    'Dining Room',
    'Sun Room',
    'Outside',
    'Office',
    'Vestibule',
    'Deck',
    'Porch',
    'Pool House',
    'Shed',
    'Lobby',
    'Roof'
  ];

   dynamic selectedValue = '';
  @override
  void initState() {
    super.initState();
    data.sort();
    for(int i = 0 ; i<data.length; i++){
      sampleData.add(RadioModel(false, data[i]));
    }
    

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
              child: Text("Where is the [Line_Item_1]\nlocated in the home?",style: TextStyle(fontSize:size.height/30),),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left:20.0, right: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // Container(
                //   child: Text("Where is the [Line_Item_1]\nlocated in the home?",style: TextStyle(fontSize:25),),
                // ),
                 SizedBox(height: MediaQuery.of(context).size.height/10,),
                Center(
                  child: Container(
                    alignment: Alignment.center,
                    height: MediaQuery.of(context).size.height/4,
                    width:MediaQuery.of(context).size.width/2,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/icons/Line_Item_Location.png")
                      )
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height/18,),
                Container(
                  alignment: Alignment.topCenter,
                  height: MediaQuery.of(context).size.height/3.6,
                  // color: Colors.redAccent,
                   child: ListView.builder(
                     itemCount: sampleData.length,
                     itemBuilder: (context, index){
                       return Column(
                         children: <Widget>[
                           InkWell(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(sampleData[index].text,style: TextStyle(fontSize:size.height/36)),
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
                              ),
                            Divider(color: Colors.grey,),
                         ],
                       );
                     }
                    ),
                )
                // buildWidget(0,size.height/36),
                // Divider(color: Colors.grey,),
                // buildWidget(1,size.height/36),
                // Divider(color: Colors.grey,),
                // buildWidget(2,size.height/36),
                // Divider(color: Colors.grey,),
                // buildWidget(3,size.height/36),
              ],
            ),
          ),
          Positioned(
            bottom: 20,
            child: CustomBorderRoundedButton(
              text: "Next",
              callback: 
              //()=> Navigator.of(context).push(MaterialPageRoute(builder: (context)=>CompletedItemOrNot()))
             selectedValue!= '' ?()=> Navigator.of(context).push(MaterialPageRoute(builder: (context)=>CompletedItemOrNot())):null
            
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
   //  buildWidget(0,size.height/32),
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

class CompletedItemOrNot extends StatefulWidget {
  @override
  _CompletedItemOrNotState createState() => _CompletedItemOrNotState();
}

class _CompletedItemOrNotState extends State<CompletedItemOrNot> {
  List<RadioModel> sampleData = new List<RadioModel>();
  dynamic selectedValue = '';
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
          Padding(
            padding: const EdgeInsets.only(left:20.0, right: 20,top: 0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: MediaQuery.of(context).size.height/10,),
                  Container(
                    child: Text("Did you complete\n[Line_Item_1]?",style: TextStyle(fontSize:size.height/29),),
                  ),
                   SizedBox(height: MediaQuery.of(context).size.height/10,),
                  Center(
                    child: Container(
                      alignment: Alignment.center,
                      height: MediaQuery.of(context).size.height/4,
                      width:MediaQuery.of(context).size.width/2,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                         image: AssetImage("assets/icons/Line_Items.png")
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
              callback: selectedValue == sampleData[0].text? ()=> Navigator.of(context).push(MaterialPageRoute(builder: (context)=>WorkCompletedDescription()))
              :selectedValue == sampleData[1].text?()=> Navigator.of(context).push(MaterialPageRoute(builder: (context)=>NotCompletedItemPage()))
              :null
              // (){
              //   if(selectedValue == sampleData[0].text){
              //     Navigator.of(context).push(MaterialPageRoute(builder: (context)=>WorkCompletedDescription()));
              //   }else if(selectedValue == sampleData[1].text){
              //     Navigator.of(context).push(MaterialPageRoute(builder: (context)=>NotCompletedItemPage()));
              //   }
              // },
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

class NotCompletedItemPage extends StatefulWidget {
  @override
  _NotCompletedItemPageState createState() => _NotCompletedItemPageState();
}

class _NotCompletedItemPageState extends State<NotCompletedItemPage> {
  List<RadioModel> sampleData = new List<RadioModel>();
 dynamic  selectedValue = '';
  @override
  void initState() {
    super.initState();
    sampleData.add(new RadioModel(false, 'Part Required'));
    sampleData.add(new RadioModel(false, 'Reschedule Needed'));
    sampleData.add(new RadioModel(false, 'Authorization Required'));
     sampleData.add(new RadioModel(false, 'Custom Refusal'));
    sampleData.add(new RadioModel(false, 'Other'));
  }
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          // Positioned(
          //   top: 55,
          //   left: 20,
          //   child: Container(
          //     child: Text("Did you complete\n[Line_Item_1]?",style: TextStyle(fontSize:25),),
          //   ),
          // ),
          Padding(
            padding: const EdgeInsets.only(left:20.0, right: 20,),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: MediaQuery.of(context).size.height/10,),
                  Container(
                    //color: Colors.red,
                    width: size.width * 0.85,
                    // height: size.height * 0.40,
                    child: Text("Why didn't you complete\n[Line_Item_1]?",style: TextStyle(fontSize:size.height/29,),),
                  ),
                   SizedBox(height: MediaQuery.of(context).size.height/20,),
                  Center(
                    child: Container(
                      alignment: Alignment.center,
                      height: MediaQuery.of(context).size.height/4,
                      width:MediaQuery.of(context).size.width/2,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                         image: AssetImage("assets/icons/Line_Items.png")
                        )
                      ),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height/16,),
                  Container(
                  alignment: Alignment.topCenter,
                  height: MediaQuery.of(context).size.height/3.1,
                   child: ListView.builder(
                     itemCount: sampleData.length,
                     itemBuilder: (context, index){
                       return Column(
                         children: <Widget>[
                           InkWell(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(sampleData[index].text,style: TextStyle(fontSize:size.height/36)),
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
                              ),
                            Divider(color: Colors.grey,),
                         ],
                       );
                     }
                    ),
                )
                  
                //   buildWidget(0, size.height/35),
                //   Divider(color: Colors.grey,),
                //    buildWidget(1, size.height/35),
                //   Divider(color: Colors.grey,),

                //  buildWidget(2, size.height/35),
                  
                //   Divider(color: Colors.grey,),
                //   buildWidget(3, size.height/35),
                
                //   Divider(color: Colors.grey,),
                //   buildWidget(4, size.height/35),/
                
                
                ],
              ),
          ),
          Positioned(
            bottom: 10,
            child: CustomBorderRoundedButton(
              text: "Next",
              callback: selectedValue == sampleData[0].text?()=> Navigator.of(context).push(MaterialPageRoute(builder: (context)=>PartRequiredDescriptionForItemPage()))
              :selectedValue == sampleData[1].text ? ()=> Navigator.of(context).push(MaterialPageRoute(builder: (context)=>RescheduleNeededDescription()))
              :selectedValue == sampleData[2].text ? ()=>  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AuthorizationRequiredPage()))
              :selectedValue == sampleData[3].text ? ()=>  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>CustomerRefuseServicesDescription()))
              :selectedValue == sampleData[4].text ? ()=>   Navigator.of(context).push(MaterialPageRoute(builder: (context)=>UnableToCompleteItemDescription()))
              :null
              
            )
          ),
          Positioned(
            top: 20,
            right:0,
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
            selectedValue =   sampleData[index].text;
          });
      },
    );
  }
}

class PartRequiredDescriptionForItemPage extends StatefulWidget { //present 
  @override
  _PartRequiredDescriptionForItemPageState createState() => _PartRequiredDescriptionForItemPageState();
}

class _PartRequiredDescriptionForItemPageState extends State<PartRequiredDescriptionForItemPage> {
  String descriptionText = '';
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
         children: <Widget>[
        
          Container(
            // color: Colors.red,
            height: MediaQuery.of(context).size.height ,
            padding: const EdgeInsets.only(left:20.0, right: 20, top: 60),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    child: Text("What part is required\nto complete [Line_Item_1]?",style: TextStyle(fontSize:size.height/28,),),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height/18,),
                  Center(
                  child: Container(
                    //  padding: const EdgeInsets.only(top: 60),
                    alignment: Alignment.center,
                    height: MediaQuery.of(context).size.height/4,
                    width:MediaQuery.of(context).size.width/2,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/icons/Parts.png")
                      )
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height/16,),
                  Container(
                    alignment: Alignment.topLeft,
                    height: MediaQuery.of(context).size.height/3.5,
                    decoration:BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Colors.grey,width: 2)
                    ) ,
                    child: TextField(
                      maxLines: 5,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(8),
                        hintText: "Enter a desription of the part(s)\nrequired*",
                        hintStyle: TextStyle(fontSize: size.height/50),
                        border: InputBorder.none
                      ),
                      onChanged: (val){
                        setState(() {
                          descriptionText = val;
                        });
                      },
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height/20,),
                  CustomBorderRoundedButton(
                    text: "Next",
                    callback:descriptionText !=''? ()=>
                     Navigator.of(context).push(MaterialPageRoute(builder: (context)=>MakeModelAndSerialPage()))
                    :null
                  )
                ],
              ),
            ),
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
}

class MakeModelAndSerialPage extends StatefulWidget {
  @override
  _MakeModelAndSerialPageState createState() => _MakeModelAndSerialPageState();
}

class _MakeModelAndSerialPageState extends State<MakeModelAndSerialPage> {
  Widget buildTextFieldContainer(String hint){
    return Container(
      alignment: Alignment.center,
      height: MediaQuery.of(context).size.height/15,
      child: TextField(
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText:hint,
          contentPadding: const EdgeInsets.all(10)
          
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
   final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
         children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height ,
            padding: const EdgeInsets.only(left:20.0, right: 20, top: 60),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    child: Text("Enter the make, model and\nserial if applicable?",style: TextStyle(fontSize:size.height/28,),),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height/18,),
                  Center(
                    child: Container(
                      //  padding: const EdgeInsets.only(top: 60),
                      alignment: Alignment.center,
                      height: MediaQuery.of(context).size.height/4,
                      width:MediaQuery.of(context).size.width/2,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/icons/Parts.png")
                        )
                      ),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height/10,),
                  buildTextFieldContainer("Make"),
                  SizedBox(height: MediaQuery.of(context).size.height/30,),
                  buildTextFieldContainer("Model"),
                  SizedBox(height: MediaQuery.of(context).size.height/30,),
                  buildTextFieldContainer("Serial"),
                  SizedBox(height: MediaQuery.of(context).size.height/20,),
                  CustomBorderRoundedButton(
                    text: "Next",
                    callback: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>OrderNeedOrNot()));
                    },
                  )
                ],
              ),
            ),
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
}

//test mode

class OrderNeedOrNot extends StatefulWidget {
  @override
  _OrderNeedOrNotState createState() => _OrderNeedOrNotState();
}

class _OrderNeedOrNotState extends State<OrderNeedOrNot> {
 
  List<RadioModel> sampleData = new List<RadioModel>();
 dynamic selectedValue = '';
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
              child: Text("Does this part need to be\nordered?",style: TextStyle(fontSize:size.height/29),),
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
                        image: AssetImage("assets/icons/Parts.png")
                        //NetworkImage("https://pluspng.com/img-png/google-maps-png-google-maps-icon-png-file-512x512-pixel-512.png")
                      )
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height/10,),
                buildWidget(0, size.height/32),
                Divider(color: Colors.grey,),
                buildWidget(1, size.height/32)
                // CustomRadio()
              ],
            ),
          ),
          Positioned(
            bottom: 20,
            child: CustomBorderRoundedButton(
              text: "Next",
              callback: selectedValue !=''?()=> Navigator.of(context).push(MaterialPageRoute(builder: (context)=>RescheuleOrNot())):null
             
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

class RescheuleOrNot extends StatefulWidget {
  @override
  _RescheuleOrNotState createState() => _RescheuleOrNotState();
}

class _RescheuleOrNotState extends State<RescheuleOrNot> {
 List<RadioModel> sampleData = new List<RadioModel>();
  dynamic selectedValue = '';
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
            top: 55,
            left: 20,
            child: Container(
              child: Text("Will this cause a\nreschedule?",style: TextStyle(fontSize:size.height/28),),
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
                        image: AssetImage("assets/icons/Parts.png")
                      )
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height/10,),
                buildWidget(0, size.height/32),
                Divider(color: Colors.grey,),
                buildWidget(1, size.height/32)
                // CustomRadio()
              ],
            ),
          ),
          Positioned(
            bottom: 20,
            child: CustomBorderRoundedButton(
              text: "Next",
              callback: selectedValue =='Yes'?
              () =>Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AskCustomerToTakeServeyOrNot()))
              :selectedValue =='No'? ()=>Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ItemCompletedOrNotToday()))
              :null
              
              
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

class ItemCompletedOrNotToday extends StatefulWidget {
  @override
  _ItemCompletedOrNotTodayState createState() => _ItemCompletedOrNotTodayState();
}

class _ItemCompletedOrNotTodayState extends State<ItemCompletedOrNotToday> {
 List<RadioModel> sampleData = new List<RadioModel>();
 dynamic selectedValue = '';

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
              child: Text("[Line_Item_1] can be\ncompleted today?",style: TextStyle(fontSize:size.height/29),),
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
                        image: AssetImage("assets/icons/Parts.png")
                      )
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height/10,),
                buildWidget(0, size.height/32),
                Divider(color: Colors.grey,),
                buildWidget(1, size.height/32)
                // CustomRadio()
              ],
            ),
          ),
          Positioned(
            bottom: 20,
            child: CustomBorderRoundedButton(
              text: "Next",
              callback: selectedValue == 'Yes'?
              ()=>  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AskCustomerToTakeServeyOrNot()),)
              :selectedValue == 'No'? ()=> Navigator.pop(context)
              :null
              
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
            selectedValue =  sampleData[index].text;
          });
      },
    );
  }
}


class RescheduleNeededDescription extends StatefulWidget {
  @override
  _RescheduleNeededDescriptionState createState() => _RescheduleNeededDescriptionState();
}

class _RescheduleNeededDescriptionState extends State<RescheduleNeededDescription> {
  String descriptionText = '';
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
         children: <Widget>[
        
          Container(
            // color: Colors.red,
            height: MediaQuery.of(context).size.height ,
            padding: const EdgeInsets.only(left:20.0, right: 20, top: 60),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    child: Text("why is a reschedule needed?",style: TextStyle(fontSize:size.height/29,),),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height/18,),
                  Center(
                    child: Container(
                      //  padding: const EdgeInsets.only(top: 60),
                      alignment: Alignment.center,
                      height: MediaQuery.of(context).size.height/4,
                      width:MediaQuery.of(context).size.width/2,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/icons/Calendar.png")
                        )
                      ),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height/16,),
                  Container(
                    alignment: Alignment.topLeft,
                    height: MediaQuery.of(context).size.height/3.5,
                    decoration:BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Colors.grey,width: 2)
                    ) ,
                    child: TextField(
                      maxLines: 5,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(8),
                        hintText: "Enter a desription explaining why\na reschedule is needed",
                        hintStyle: TextStyle(fontSize: size.height/50),
                        border: InputBorder.none
                      ),
                      onChanged: (val){
                        setState(() {
                          descriptionText = val;
                        });
                      },
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height/10,),
                  CustomBorderRoundedButton(
                    text: "Next",
                    callback: descriptionText != '' ?
                    ()=>
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (BuildContext context) => AskCustomerToTakeServeyOrNot()),
                      
                      )
                    :null
                  )
                ],
              ),
            ),
          ),
          // Positioned(
          //   bottom: 20,
          //   child: CustomBorderRoundedButton(
          //     text: "Next",
          //     callback: (){},
          //   )
          // ),
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
}


class AuthorizationRequiredPage extends StatefulWidget {
  @override
  _AuthorizationRequiredPageState createState() => _AuthorizationRequiredPageState();
}

class _AuthorizationRequiredPageState extends State<AuthorizationRequiredPage> {
 List<RadioModel> sampleData = new List<RadioModel>();
 dynamic selectedValue = '';

  @override
  void initState() {
    super.initState();
    sampleData.add(new RadioModel(false, 'Required access'));
    sampleData.add(new RadioModel(false, 'Equiment needed'));
    sampleData.add(new RadioModel(false, 'Additional work required'));
    sampleData.add(new RadioModel(false, 'Non-covered charges possible'));
  }
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: <Widget>[
         
          Padding(
            padding: const EdgeInsets.only(left:20.0, right: 20,),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: MediaQuery.of(context).size.height/10,),
                  Container(
                    
                    width: size.width * 0.85,
                    child: Text("Why are authorizations\nrequired?",style: TextStyle(fontSize:size.height/29,),),
                  ),
                   SizedBox(height: MediaQuery.of(context).size.height/20,),
                  Center(
                    child: Container(
                      alignment: Alignment.center,
                      height: MediaQuery.of(context).size.height/4,
                      width:MediaQuery.of(context).size.width/2,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                         image: AssetImage("assets/icons/Authorizations.png")
                        )
                      ),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height/16,),
                 Container(
                   
                    alignment: Alignment.topCenter,
                    height: MediaQuery.of(context).size.height/3.1,
                    child: ListView.builder(
                     itemCount: sampleData.length,
                     itemBuilder: (context, index){
                       return Column(
                         children: <Widget>[
                           InkWell(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(sampleData[index].text,style: TextStyle(fontSize:size.height/36)),
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
                            ),
                            Divider(color: Colors.grey,),
                         ],
                       );
                     }
                    ),
                  )
                ],
              ),
          ),
          Positioned(
            bottom: 10,
            child: CustomBorderRoundedButton(
              text: "Next",
              callback: selectedValue != ''?()=>Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AuthorizationRequiredDescriptionPage()))
              :null
              
            )
          ),
          Positioned(
            top: 20,
            right:0,
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


class AuthorizationRequiredDescriptionPage extends StatefulWidget {
  @override
  _AuthorizationRequiredDescriptionPageState createState() => _AuthorizationRequiredDescriptionPageState();
}

class _AuthorizationRequiredDescriptionPageState extends State<AuthorizationRequiredDescriptionPage> {
  String descriptionText = '';
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
         children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height ,
            padding: const EdgeInsets.only(left:30.0, right: 30, top: 60),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    child: Text("Why are authorization\nrequired?",style: TextStyle(fontSize:size.height/28,),),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height/18,),
                  Center(
                    child: Container(
                      //  padding: const EdgeInsets.only(top: 60),
                      alignment: Alignment.center,
                      height: MediaQuery.of(context).size.height/4,
                      width:MediaQuery.of(context).size.width/2,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/icons/Authorizations.png")
                        )
                      ),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height/16,),
                  Container(
                    alignment: Alignment.topLeft,
                    height: MediaQuery.of(context).size.height/3.5,
                    decoration:BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Colors.grey,width: 2)
                    ) ,
                    child: TextField(
                      maxLines: 5,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(8),
                        hintText: "Enter a description explaining why\nauthorization are required",
                        hintStyle: TextStyle(fontSize: size.height/50),
                        border: InputBorder.none
                      ),
                      onChanged: (val){
                        setState(() {
                          descriptionText = val;
                        
                        });
                      },
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height/20,),
                  CustomBorderRoundedButton(
                    text: "Next",
                    callback:descriptionText != ''? ()=>
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (BuildContext context) => AskCustomerToTakeServeyOrNot()),
                     
                    ) 
                    :null
                  )
                ],
              ),
            ),
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
}

class CustomerRefuseServicesDescription extends StatefulWidget {
  @override
  _CustomerRefuseServicesDescriptionState createState() => _CustomerRefuseServicesDescriptionState();
}

class _CustomerRefuseServicesDescriptionState extends State<CustomerRefuseServicesDescription> {
  String descriptionText = '';
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
         children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height ,
            padding: const EdgeInsets.only(left:30.0, right: 30, top: 60),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    child: Text("Why did the customer\nrefuse services?",style: TextStyle(fontSize:size.height/29,),),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height/18,),
                  Center(
                    child: Container(
                      alignment: Alignment.center,
                      height: MediaQuery.of(context).size.height/4,
                      width:MediaQuery.of(context).size.width/2,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/icons/Customer_Refusal.png")
                        )
                      ),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height/11,),
                  Container(
                    alignment: Alignment.topLeft,
                    height: MediaQuery.of(context).size.height/3.6,
                    decoration:BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Colors.grey,width: 2)
                    ) ,
                    child: TextField(
                      maxLines: 5,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(8),
                        hintText: "Enter a desription explaining why\nthe customer refused services",
                         hintStyle: TextStyle(fontSize: size.height/50),
                        border: InputBorder.none
                      ),
                      onChanged: (val){
                        setState(() {
                          descriptionText = val;
                        });
                      },
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height/20,),
                  CustomBorderRoundedButton(
                    text: "Next",
                    callback: descriptionText != ''?
                     ()=> Navigator.push(
                        context,
                        MaterialPageRoute(builder: (BuildContext context) => AskCustomerToTakeServeyOrNot()),
                      )
                     :null
                    
                  )
                ],
              ),
            ),
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
}


class UnableToCompleteItemDescription extends StatefulWidget {
  @override
  _UnableToCompleteItemDescriptionState createState() => _UnableToCompleteItemDescriptionState();
}

class _UnableToCompleteItemDescriptionState extends State<UnableToCompleteItemDescription> {
  String descriptionText = '';
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
         children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height ,
            padding: const EdgeInsets.only(left:30.0, right: 30, top: 60),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    child: Text("Why were you unable to\ncomplete [Line_Item_1]?",style: TextStyle(fontSize:size.height/29,),),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height/18,),
                  Center(
                    child: Container(
                      alignment: Alignment.center,
                      height: MediaQuery.of(context).size.height/4,
                      width:MediaQuery.of(context).size.width/2,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/icons/Question_Mark.png")
                        )
                      ),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height/16,),
                  Container(
                    alignment: Alignment.topLeft,
                    height: MediaQuery.of(context).size.height/3.5,
                    decoration:BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Colors.grey,width: 2)
                    ) ,
                    child: TextField(
                      maxLines: 5,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(8),
                        hintText: "Enter a desription explaining why\nyou were to able to complete the\nline item",
                         hintStyle: TextStyle(fontSize: size.height/50),
                        border: InputBorder.none
                      ),
                      onChanged: (val){
                        setState(() {
                          descriptionText = val;
                        });
                      },
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height/20,),
                  CustomBorderRoundedButton(
                    text: "Next",
                    callback: descriptionText != ''?
                     ()=>Navigator.push(
                        context,
                        MaterialPageRoute(builder: (BuildContext context) => AskCustomerToTakeServeyOrNot()),
                      )
                    :null
                  )
                ],
              ),
            ),
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
}



class WorkCompletedDescription extends StatefulWidget {
  @override
  _WorkCompletedDescriptionState createState() => _WorkCompletedDescriptionState();
}

class _WorkCompletedDescriptionState extends State<WorkCompletedDescription> {
  String descriptionText = '';
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
         children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height ,
            padding: const EdgeInsets.only(left:30.0, right: 30, top: 60),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    child: Text("Provide a description of\nthe work completed?",style: TextStyle(fontSize:size.height/29,),),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height/18,),
                  Center(
                    child: Container(
                      alignment: Alignment.center,
                      height: MediaQuery.of(context).size.height/4,
                      width:MediaQuery.of(context).size.width/2,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/icons/Line_Items.png")
                        )
                      ),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height/16,),
                  Container(
                    alignment: Alignment.topLeft,
                    height: MediaQuery.of(context).size.height/3.5,
                    decoration:BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Colors.grey,width: 2)
                    ) ,
                    child: TextField(
                      maxLines: 5,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(8),
                        hintText: "Enter a desription of the work\ncompleted",
                         hintStyle: TextStyle(fontSize: size.height/50),
                        border: InputBorder.none
                      ),
                      onChanged: (val){
                        setState(() {
                          descriptionText = val;
                        });
                      },
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height/20,),
                  CustomBorderRoundedButton(
                    text: "Next",
                    callback:descriptionText != ''?
                    ()=>Navigator.of(context).push(MaterialPageRoute(builder: (context)=>PartsRequiredToCompleteOrNot()))
                    :null
                  )
                ],
              ),
            ),
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
}










class PartsRequiredToCompleteOrNot extends StatefulWidget {
  @override
  _PartsRequiredToCompleteOrNotState createState() => _PartsRequiredToCompleteOrNotState();
}

class _PartsRequiredToCompleteOrNotState extends State<PartsRequiredToCompleteOrNot> {
 
  List<RadioModel> sampleData = new List<RadioModel>();
  dynamic selectedValue = '';
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
              child: Text("Were parts required to\ncomplete [Line_Item_1]?",style: TextStyle(fontSize:size.height/29),),
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
                        image: AssetImage("assets/icons/Parts.png")
                      )
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height/10,),
                buildWidget(0, size.height/34),
                Divider(color: Colors.grey,),
                buildWidget(1, size.height/34)
                // CustomRadio()
              ],
            ),
          ),
          Positioned(
            bottom: 20,
            child: CustomBorderRoundedButton(
              text: "Next",
              callback:selectedValue == sampleData[0].text?()=>Navigator.of(context).push(MaterialPageRoute(builder: (context)=>PartsWereRequiredToCompleteForItem()))
              :selectedValue == sampleData[1].text ? ()=>Navigator.of(context).push(MaterialPageRoute(builder: (context)=>PartsNotRequiredToCompleteDescription()))
              :null
             
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

class PartsNotRequiredToCompleteDescription extends StatefulWidget {
  @override
  _PartsNotRequiredToCompleteDescriptionState createState() => _PartsNotRequiredToCompleteDescriptionState();
}

class _PartsNotRequiredToCompleteDescriptionState extends State<PartsNotRequiredToCompleteDescription> {
  String descriptionText = '';
 @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
         children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height ,
            padding: const EdgeInsets.only(left:30.0, right: 30, top: 60),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    child: Text("Why were parts not required\nto complete [Line_Item_1]?",style: TextStyle(fontSize:size.height/32,),),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height/18,),
                  Center(
                    child: Container(
                      alignment: Alignment.center,
                      height: MediaQuery.of(context).size.height/4,
                      width:MediaQuery.of(context).size.width/2,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/icons/Parts.png")
                        )
                      ),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height/16,),
                  Container(
                    alignment: Alignment.topLeft,
                    height: MediaQuery.of(context).size.height/3.5,
                    decoration:BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Colors.grey,width: 2)
                    ) ,
                    child: TextField(
                      maxLines: 5,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(8),
                        hintText: "Enter a description explaining why\nparts were not required",
                         hintStyle: TextStyle(fontSize: size.height/50),
                        border: InputBorder.none
                      ),
                      onChanged: (val){
                        setState(() {
                          descriptionText= val;
                        });
                      },
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height/20,),
                  CustomBorderRoundedButton(
                    text: "Next",
                    callback: descriptionText != ''?
                    ()=>
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (BuildContext context) => AskCustomerToTakeServeyOrNot()),
                      
                      )
                      // Navigator.pop(context);
                    :null
                  )
                ],
              ),
            ),
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
}


class PartsWereRequiredToCompleteForItem extends StatefulWidget {
  @override
  _PartsWereRequiredToCompleteForItemState createState() => _PartsWereRequiredToCompleteForItemState();
}

class _PartsWereRequiredToCompleteForItemState extends State<PartsWereRequiredToCompleteForItem> {
  String descriptionText = '';
   @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
         children: <Widget>[
        
          Container(
            // color: Colors.red,
            height: MediaQuery.of(context).size.height ,
            padding: const EdgeInsets.only(left:30.0, right: 30, top: 60),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    child: Text("What parts were required\nto complete [Line_Item_1]?",style: TextStyle(fontSize:size.height/31,),),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height/18,),
                  Center(
                  child: Container(
                    //  padding: const EdgeInsets.only(top: 60),
                    alignment: Alignment.center,
                    height: MediaQuery.of(context).size.height/4,
                    width:MediaQuery.of(context).size.width/2,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/icons/Parts.png")
                      )
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height/16,),
                  Container(
                    alignment: Alignment.topLeft,
                    height: MediaQuery.of(context).size.height/3.5,
                    decoration:BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Colors.grey,width: 2)
                    ) ,
                    child: TextField(
                      maxLines: 5,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(8),
                        hintText: "Enter a desription of the part(s)\nrequired*",
                         hintStyle: TextStyle(fontSize: size.height/50),
                        border: InputBorder.none
                      ),
                      onChanged: (val){
                        setState(() {
                          descriptionText = val;
                        });
                      },
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height/20,),
                  CustomBorderRoundedButton(
                    text: "Next",
                    callback: descriptionText != ''?
                    ()=> Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AskCustomerToTakeServeyOrNot()))
                    
                    :null
                  )
                ],
              ),
            ),
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
}


class AdditionalUpgradeItemToAddOrNot extends StatefulWidget {
  @override
  _AdditionalUpgradeItemToAddOrNotState createState() => _AdditionalUpgradeItemToAddOrNotState();
}

class _AdditionalUpgradeItemToAddOrNotState extends State<AdditionalUpgradeItemToAddOrNot> {
 
  List<RadioModel> sampleData = new List<RadioModel>();
  dynamic selectedvalue = '';
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
            top: 55,
            left: 20,
            child: Container(
              child: Text("Did you identify any\nadditional upgrade items\nthat need to be added?",style: TextStyle(fontSize:size.height/29),),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: MediaQuery.of(context).size.height/10,),
               
                Center(
                  child: Container(
                    alignment: Alignment.center,
                    height: MediaQuery.of(context).size.height/4,
                    width:MediaQuery.of(context).size.width/2,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/icons/Upgrade.png")
                      )
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height/10,),
                buildWidget(0, size.height/34),
                Divider(color: Colors.grey,),
                buildWidget(1, size.height/34) //need change new
                // CustomRadio()
              ],
            ),
          ),
          Positioned(
            bottom: 20,
            child: CustomBorderRoundedButton(
              text: "Next",
              callback: selectedvalue == 'Yes'?
              ()=>Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AdditionalItemsIdentifyDescription()))
              : selectedvalue == 'No'?
              ()=>Navigator.of(context).push(MaterialPageRoute(builder: (context)=>CustomerReviewAndSignOff()))
              :null
              
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
            selectedvalue = sampleData[index].text;
          });
      },
    );
  }
}



class AdditionalItemsIdentifyDescription extends StatefulWidget {
  @override
  _AdditionalItemsIdentifyDescriptionState createState() => _AdditionalItemsIdentifyDescriptionState();
}

class _AdditionalItemsIdentifyDescriptionState extends State<AdditionalItemsIdentifyDescription> {
  String descriptionText = '';
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
         children: <Widget>[
          Container(
            // color: Colors.red,
            height: MediaQuery.of(context).size.height ,
            padding: const EdgeInsets.only(left:30.0, right: 30, top: 60),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    child: Text("What additional line items\nwere identified?",style: TextStyle(fontSize:size.height/31,),),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height/18,),
                  Center(
                  child: Container(
                    //  padding: const EdgeInsets.only(top: 60),
                    alignment: Alignment.center,
                    height: MediaQuery.of(context).size.height/4,
                    width:MediaQuery.of(context).size.width/2,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/icons/Upgrade.png")
                      )
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height/16,),
                  Container(
                    alignment: Alignment.topLeft,
                    height: MediaQuery.of(context).size.height/3.5,
                    decoration:BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Colors.grey,width: 2)
                    ) ,
                    child: TextField(
                      maxLines: 5,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(8),
                        hintText: "Enter a desription of the additional\nupgrade items that were identified",
                         hintStyle: TextStyle(fontSize: size.height/50),
                        border: InputBorder.none
                      ),
                      onChanged: (val){
                        setState(() {
                          descriptionText = val;
                        });
                      },
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height/20,),
                  CustomBorderRoundedButton(
                    text: "Next",
                    callback: descriptionText != ''?
                    ()=> Navigator.of(context).push(MaterialPageRoute(builder: (context)=>CustomerReviewAndSignOff()))
                    :null
                  )
                ],
              ),
            ),
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
}

class CustomerReviewAndSignOff extends StatefulWidget {
  @override
  _CustomerReviewAndSignOffState createState() => _CustomerReviewAndSignOffState();
}



class _CustomerReviewAndSignOffState extends State<CustomerReviewAndSignOff> {

  @override
  Widget build(BuildContext context) {
    
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top:50.0),
            child: Container(
               height: MediaQuery.of(context).size.height/1,
              //  color: Colors.red,
              // alignment: Alignment.center,
              padding: const EdgeInsets.only(left:20.0, right: 20.0,top: 10),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      child: Text("Customer review and\nsign off",style: TextStyle(fontSize:size.height/29,),),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height/25,),
                    Center(
                      child: Container(
                        alignment: Alignment.center,
                        height: MediaQuery.of(context).size.height/4,
                        width:MediaQuery.of(context).size.width/2,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/icons/Customer_Agreement.png")
                          )
                        ),
                      ),
                    ),
                    customExpandableList(),
                    SizedBox(height: MediaQuery.of(context).size.height/30,),
                   
                  ],
                ),
              ),
            ),
          ),
           Positioned(
            bottom: 10,
            // right: 10,
            child: CustomBorderRoundedButton(
              text: "SIGN",
              callback: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>SignaturePage()));
               
              },
            ),
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


  Widget customExpandableList(){
    return Container(
      height:MediaQuery.of(context).size.height/2.5,
      child: new ListView.builder(
          itemCount: expandableModel.length,
          itemBuilder: (context, i) {
            return Container(
              //  height:MediaQuery.of(context).size.height/14,
              child: Card(
                margin: EdgeInsets.all(6),
                elevation: 5,
                child: Container(
                  // height:MediaQuery.of(context).size.height/8,
                  child: new ExpansionTile(
                    leading: CircleAvatar(
                      radius: MediaQuery.of(context).size.height/50,
                      child: Icon(Icons.check,color: Colors.white,),
                      backgroundColor: Colors.green,
                    ),
                    title: new Text(expandableModel[i].title, 
                    // style: new TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
                    ),
                    children: <Widget>[
                      Container(
                        // height:MediaQuery.of(context).size.height/18,
                        child: new Column(
                          children: _buildExpandableContent(expandableModel[i]),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
    );
  }
  _buildExpandableContent(ExpandableModel expandableModel) {
    List<Widget> columnContent = [];
    for (String content in expandableModel.contents)
      columnContent.add(
        Padding(
          padding: const EdgeInsets.only(left:40.0),
          child: new ListTile(
            title: new Text(content, 
            // style: new TextStyle(fontSize: 18.0),
            ),
            // leading: new Icon(expandableModel.icon),
          ),
        ),
       
      );
      
    return columnContent;
  }
}
class ExpandableModel {
  final String title;
  List<String> contents = [];
  ExpandableModel(this.title, this.contents,);
}

List<ExpandableModel> expandableModel = [
  new ExpandableModel(
    'Service Fee Collected',
    ['\$75.00 - Credit Card', ],
    
  ),
  new ExpandableModel(
    '[Line_Item_1]',
    ['Item_1', 'Item_2', 'Item_3'],
   
  ),
  new ExpandableModel(
    '[Line_Item_2]',
    ['Item_1', 'Item_2', 'Item_3'],
   
  ),
];










