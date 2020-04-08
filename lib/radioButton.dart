// import 'package:etteo_demo/model/home_access_model/expandable_model/expandable_model.dart';
// import 'package:flutter/material.dart';


// class CustomRadio extends StatefulWidget {
//   @override
//   createState() {
//     return new CustomRadioState();
//   }
// }

// class CustomRadioState extends State<CustomRadio> {
//   List<RadioModel> sampleData = new List<RadioModel>();

//   @override
//   void initState() {
//     super.initState();
//     sampleData.add(new RadioModel(false, 'Customer refused to pay'));
//     sampleData.add(new RadioModel(false, 'service fee already collected'));
//     sampleData.add(new RadioModel(false, 'Service not required'));
//     sampleData.add(new RadioModel(false, 'Other'));
//   }
//   @override
//   Widget build(BuildContext context) {
//      final size = MediaQuery.of(context).size;
//     return new Scaffold(
//       appBar: new AppBar(
//         title: new Text("ListItem"),
//       ),
//       body: new ListView.builder(
//         itemCount: sampleData.length,
//         itemBuilder: (BuildContext context, int index) {
//           return new InkWell(
//             //highlightColor: Colors.red,
//             splashColor: Colors.blueAccent,
//             onTap: () {
//               setState(() {
//                 sampleData.forEach((element) => element.isSelected = false);
//                 sampleData[index].isSelected = true;
//               });
//             },
//             // child: new RadioItem(sampleData[index]),
//           );
//         },
//       ),
//     );
//   }
//   //  buildWidget(0,size.height/32),
//   Widget buildWidget(int index, double size){
//     return InkWell(
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: <Widget>[
//           Text(sampleData[index].text,style: TextStyle(fontSize:size)),
//           Icon(Icons.check,
//           color:sampleData[index].isSelected ? Colors.blue : Colors.white,         
//           ),
//         ],
//       ),
//       onTap: (){
//         setState(() {
//             sampleData.forEach((element) => element.isSelected = false);
//             sampleData[index].isSelected = true;
//           });
//       },
//     );
//   }
  
// }






// class RadioItem extends StatefulWidget {
 
//   @override
//   _RadioItemState createState() => _RadioItemState();
// }

// class _RadioItemState extends State<RadioItem> {
//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     return Scaffold(
//       body: customExpandableList(),
//     );
//   }

//   Widget customExpandableList(){
//     return Container(
//       height:MediaQuery.of(context).size.height/3,
//       color: Colors.red,
//       child: new ListView.builder(
//           itemCount: expandableModel.length,
//           itemBuilder: (context, i) {
//             return Card(
//               elevation: 5,
//               child: new ExpansionTile(
//                 leading: CircleAvatar(
//                   radius: MediaQuery.of(context).size.height/50,
//                   child: Icon(Icons.check,color: Colors.white,),
//                   backgroundColor: Colors.green,
//                 ),
//                 title: new Text(expandableModel[i].title, style: new TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),),
//                 children: <Widget>[
//                   new Column(
//                     children: _buildExpandableContent(expandableModel[i]),
//                   ),
//                 ],
//               ),
//             );
//           },
//         ),
//     );
//   }
//   _buildExpandableContent(ExpandableModel expandableModel) {
//     List<Widget> columnContent = [];
//     for (String content in expandableModel.contents)
//       columnContent.add(
//         new ListTile(
//           title: new Text(content, style: new TextStyle(fontSize: 18.0),),
//           // leading: new Icon(expandableModel.icon),
//         ),
//       );
//     return columnContent;
//   }
// }

// class RadioModel {
//   bool isSelected;
//   final String text;

//   RadioModel(this.isSelected,this.text);
// }