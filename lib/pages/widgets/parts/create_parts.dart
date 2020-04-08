

import 'package:etteo_demo/bloc/parts_bloc.dart';
import 'package:etteo_demo/bloc/parts_event.dart';
import 'package:etteo_demo/bloc/parts_state.dart';
import 'package:etteo_demo/helpers/screen_aware_size.dart';
import 'package:etteo_demo/indicator.dart';
import 'package:etteo_demo/model/parts/parts_model.dart';
import 'package:etteo_demo/model/parts/parts_status_model.dart';
import 'package:etteo_demo/model/parts/parts_type_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';




class CreateParts extends StatefulWidget {
  final String orderId;
  CreateParts({@required this.orderId});

  @override
  _CreatePartsState createState() => _CreatePartsState();
}

class _CreatePartsState extends State<CreateParts>
    with AutomaticKeepAliveClientMixin {
  //please check all the comments below
  //this bloc is for displaying and adding parts data
  PartsBloc _partsBloc;
  PartsModel newPartsModel;
  var formKey = GlobalKey<FormState>();

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    _partsBloc = BlocProvider.of<PartsBloc>(context);
    _partsBloc..dispatch(PartsFetchDropdownValues());
    newPartsModel = PartsModel.fromJson(Map());
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _partsBloc = BlocProvider.of<PartsBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              topAppbar(context),
              BlocBuilder(
                  bloc: _partsBloc,
                  builder: (context, state) {
                    if (state is PartsDropdownValuesFetching) {
                      return showSpinnerInExpanded();
                    }

                    if (state is PartsDropdownValuesFetched) {
                      return Container(
                        margin: EdgeInsets.all(screenAwareSize(5, 10, context)),
                        child: Card(
                          elevation: 5,
                          child: Form(
                            key: formKey,
                            child: Padding(
                              padding: EdgeInsets.all(10),
                              child: Column(
                                children: <Widget>[
                                  SizedBox(
                                    height: screenAwareSize(15, 30, context),
                                  ),
                                  titleText('Make', context),
                                  textField('Make', context),
                                  titleText('Model', context),
                                  textField('Model', context),
                                  titleText('Serial Number', context),
                                  textField('Serial Number', context),
                                  titleText('Unit Type', context),
                                  selectPartTypeDropdown(
                                      _partsBloc.partsType, 'Unit Type'),
                                  titleText('Location', context),
                                  textField('Location', context),
                                  titleText('Unit Status', context),
                                  selectPartStatusDropdown(
                                      _partsBloc.partsStatus, 'Unit Status'),
                                  titleText('Description', context),
                                  descriptionField(),
                                  buttons(context)
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }
                    return Container();
                  }),
            ],
          ),
        ));
  }

  //SelectDropdown dropdown
  selectPartTypeDropdown(List<PartsTypeModel> dropdownList, type) {
    return Padding(
      padding: EdgeInsets.only(
          left: screenAwareSize(8, 16, context),
          right: screenAwareSize(8, 16, context),
          top: screenAwareSize(4, 8, context),
          bottom: screenAwareSize(8, 16, context)),
      child: FormField<String>(
        validator: (value) {
          if (value == null) {
            return "Select " + type;
          } else {
            return null;
          }
        },
        onSaved: (value) {
          //save data into model here
          print(value);
//       model.unitType = value;
        },
        builder: (
          FormFieldState<String> state,
        ) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Container(
                width: double.infinity,
                padding: EdgeInsets.all(8),
                decoration: new BoxDecoration(
                    border: new Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(4)),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      flex: 9,
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<PartsTypeModel>(
                            hint: Text('Select One'),
                            isDense: true,
                            value: _partsBloc.selectedPartTypeModel,
                            items: dropdownList.map((PartsTypeModel item) {
                              return DropdownMenuItem<PartsTypeModel>(
                                child: Text(item.unitTypeDescription),
                                value: item,
                              );
                            }).toList(),
                            onChanged: (value) {
                              state.didChange(value.unitTypeId.toString());
                              newPartsModel.unitTypeId = value.unitTypeId;
                              newPartsModel.unitType =
                                  value.unitTypeDescription;
                              // setState(() {
                              _partsBloc.selectedPartTypeModel = value;
                              // }
                              // );
                            }),
                      ),
                    )
                  ],
                ),
              ),
              state.hasError
                  ? SizedBox(height: 5.0)
                  : Container(
                      height: 0,
                    ),
              state.hasError
                  ? Text(
                      state.errorText,
                      style:
                          TextStyle(color: Colors.red.shade700, fontSize: 12.0),
                    )
                  : Container(),
            ],
          );
        },
      ),
    );
  }

  selectPartStatusDropdown(List<PartsStatusModel> dropdownList, type) {
    return Padding(
      padding: EdgeInsets.only(
          left: screenAwareSize(8, 16, context),
          right: screenAwareSize(8, 16, context),
          top: screenAwareSize(4, 8, context),
          bottom: screenAwareSize(8, 16, context)),
      child: FormField<String>(
        validator: (value) {
          if (value == null) {
            return "Select " + type;
          } else {
            return null;
          }
        },
        onSaved: (value) {
          //save data into model here
          print(value);
//       model.unitType = value;
        },
        builder: (
          FormFieldState<String> state,
        ) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Container(
                width: double.infinity,
                padding: EdgeInsets.all(8),
                decoration: new BoxDecoration(
                    border: new Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(4)),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      flex: 9,
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<PartsStatusModel>(
                            hint: Text('Select One'),
                            isDense: true,
                            value: _partsBloc.selectedPartStatusModel,
                            items: dropdownList.map((PartsStatusModel item) {
                              return DropdownMenuItem<PartsStatusModel>(
                                child: Text(item.unitStatusDescription),
                                value: item,
                              );
                            }).toList(),
                            onChanged: (value) {
                              state.didChange(value.unitStatusId.toString());
                              // setState(() {
                              newPartsModel.unitStatusId = value.unitStatusId;
                              newPartsModel.unitStatus =
                                  value.unitStatusDescription;
                              _partsBloc.selectedPartStatusModel = value;
                              // }
                              // );
                            }),
                      ),
                    )
                  ],
                ),
              ),
              state.hasError
                  ? SizedBox(height: 5.0)
                  : Container(
                      height: 0,
                    ),
              state.hasError
                  ? Text(
                      state.errorText,
                      style:
                          TextStyle(color: Colors.red.shade700, fontSize: 12.0),
                    )
                  : Container(),
            ],
          );
        },
      ),
    );
  }

  Padding descriptionField() {
    return Padding(
      padding: EdgeInsets.only(
          left: screenAwareSize(8, 16, context),
          right: screenAwareSize(8, 16, context),
          top: screenAwareSize(4, 8, context)),
      child: TextFormField(
          maxLines: 10,
          minLines: 6,
          decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(screenAwareSize(3, 6, context)),
                gapPadding: 0,
              ),
              hintText: 'Enter Description'),
          onSaved: (value) {
            newPartsModel.unitDescription = value;
            //store your value here
//            model.description = value
          },
          validator: (value) {
            if (value.isEmpty) {
              return 'Description can\'t be empty';
            } else {
              return null;
            }
          }),
    );
  }

  Padding buttons(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: RaisedButton(
              color: Colors.white,
              elevation: 5,
              shape: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue, width: 1)),
              child: Text(
                'CANCEL',
                style: TextStyle(
                    fontFamily: 'Roboto',
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                    fontSize: screenAwareSize(13, 26, context)),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          SizedBox(
            width: screenAwareSize(10, 20, context),
          ),
          Expanded(
            flex: 2,
            child: RaisedButton(
              color: Colors.blue,
              elevation: 5,
              child: Text(
                'ADD UNIT',
                style: TextStyle(
                    fontFamily: 'Roboto',
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: screenAwareSize(13, 26, context)),
              ),
              onPressed: () {
                if (formKey.currentState.validate()) {
                  formKey.currentState.save();

                  _partsBloc.dispatch(AddNewParts(
                      part: newPartsModel, orderId: widget.orderId));
                  Navigator.pop(context);
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Align titleText(String text, BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: EdgeInsets.only(left: screenAwareSize(8.0, 16.0, context)),
        child: Text(
          text,
          style: TextStyle(
              fontFamily: 'Roboto',
              fontSize: screenAwareSize(15, 30, context),
              fontWeight: FontWeight.bold),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }

  Padding textField(String title, BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(screenAwareSize(6.0, 12.0, context)),
      child: TextFormField(
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(screenAwareSize(3, 6, context)),
            gapPadding: 0,
          ),
          hintText: 'Enter ' + title,
          contentPadding: EdgeInsets.all(
            screenAwareSize(10, 20, context),
          ),
        ),
        onSaved: (value) {
          // store your value here
          if (title == 'Model') {
            newPartsModel.model = value;
          } else if (title == 'Make') {
            newPartsModel.make = value;
          } else if (title == 'Serial Number') {
            newPartsModel.serialNumber = value;
          } else if (title == 'Location') {
            newPartsModel.unitLocation = value;
          }
        },
      ),
    );
  }

  Padding headerText(String text, BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: screenAwareSize(8, 16, context)),
      child: Text(
        text,
        style: TextStyle(
            fontFamily: 'Roboto',
            fontSize: screenAwareSize(20, 40, context),
            fontWeight: FontWeight.bold,
            color: Colors.white),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Stack topAppbar(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomLeft,
      children: <Widget>[
        SizedBox(
          height: screenAwareSize(90, 180, context),
          width: MediaQuery.of(context).size.width,
        ),
        Container(
          color: Color.fromARGB(200, 12, 49, 110),
          height: screenAwareSize(90, 180, context),
          width: MediaQuery.of(context).size.width,
        ),
        Row(
          children: <Widget>[
            IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: screenAwareSize(25, 50, context),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            headerText("Add Unit", context),
          ],
        )
      ],
    );
  }
}
