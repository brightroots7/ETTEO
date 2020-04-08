
import 'package:etteo_demo/bloc/general_information_bloc.dart';
import 'package:etteo_demo/bloc/general_information_event.dart';
import 'package:etteo_demo/bloc/general_information_state.dart';
import 'package:etteo_demo/helpers/screen_aware_size.dart';
import 'package:etteo_demo/model/order_detail/order_finance_model.dart';
import 'package:etteo_demo/model/order_detail/payment_mode_model.dart';
import 'package:etteo_demo/pages/widgets/documents/documents.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ServiceFee extends StatefulWidget {
  final OrderFinanceModel finance;
  final String orderId;
  const ServiceFee({@required this.finance, this.orderId});

  @override
  _ServiceFeeState createState() => _ServiceFeeState();
}

class _ServiceFeeState extends State<ServiceFee> {
  bool enableServiceFeeBtn = true;
  OrderFinanceModel newFinance;
  GeneralInformationBloc _generalInformationBloc;
  TextEditingController _amountController = TextEditingController();
  var formKey = new GlobalKey<FormState>();

  @override
  void initState() {
    _generalInformationBloc = BlocProvider.of<GeneralInformationBloc>(context);
    _generalInformationBloc.dispatch(FetchDropDownValues());
    newFinance = widget.finance.isServiceFeeCollected == null
        ? OrderFinanceModel.fromJson({})
        : widget.finance;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
        bloc: _generalInformationBloc,
        builder: (BuildContext context, GeneralInformationState state) {
          if (state is DropdownValuesFetched) {
            _generalInformationBloc.setPaymentMode(newFinance.paymentModeId);

            if (newFinance.amountCollected != null)
              _amountController.text = newFinance.amountCollected.toString();

            return Form(
              key: formKey,
              child: Card(
                margin: EdgeInsets.only(top: 5, left: 5, right: 5),
                elevation: 4,
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      titleText('Was the service fee collected?', context),
                      Column(
                        children: <Widget>[
                          InkWell(
                            child: ListTile(
                              title: const Text('Yes'),
                              trailing: newFinance.isServiceFeeCollected !=
                                          null &&
                                      newFinance.isServiceFeeCollected
                                  // newFinance.isServiceFeeCollected?.toLowerCase() ==
                                  //         'true'
                                  ? Icon(
                                      Icons.check,
                                      color: Colors.green,
                                    )
                                  : null,
                            ),
                            onTap: () => {
                              setState(() {
                                // newFinance.isServiceFeeCollected = 'true';
                                newFinance.isServiceFeeCollected = true;
                                print('${newFinance.isServiceFeeCollected}');
                              })
                            },
                          ),
                          InkWell(
                            child: ListTile(
                              title: const Text('No'),
                              trailing: newFinance.isServiceFeeCollected !=
                                          null &&
                                      !newFinance.isServiceFeeCollected
                                  // newFinance.isServiceFeeCollected?.toLowerCase() ==
                                  //         'false'
                                  ? Icon(
                                      Icons.check,
                                      color: Colors.green,
                                    )
                                  : null,
                            ),
                            onTap: () => {
                              setState(() {
                                newFinance.isServiceFeeCollected = false;
                                // newFinance.isServiceFeeCollected = 'false';
                                print('${newFinance.isServiceFeeCollected}');
                              })
                            },
                          ),
                        ],
                      ),
                      titleText('Amount Collected', context),
                      Padding(
                          padding: EdgeInsets.all(8),
                          child: TextFormField(
                              enabled: newFinance.isServiceFeeCollected,
                              maxLines: 1,
                              minLines: 1,
                              controller: _amountController,
                              keyboardType: TextInputType.numberWithOptions(
                                  decimal: true),
                              decoration: InputDecoration(
                                  prefixIcon: Icon(FontAwesomeIcons.dollarSign),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                        screenAwareSize(3, 6, context)),
                                    gapPadding: 0,
                                  ),
                                  hintText: '0.0'),
                              onSaved: (value) {
                                //store your value here
                                // newFinance.amountCollected =
                                //     double.parse(_amountController.text);
                                // (value as num).toDouble();
                              },
                              validator: (value) {
                                if (newFinance != null &&
                                    newFinance.isServiceFeeCollected != null &&
                                    newFinance.isServiceFeeCollected &&
                                    value.isEmpty) {
                                  return 'Amount cannot be empty';
                                } else {
                                  return null;
                                }
                              })),
                      titleText('Method of collection', context),

                      Padding(
                        padding: EdgeInsets.only(
                            left: screenAwareSize(8, 16, context),
                            right: screenAwareSize(8, 16, context),
                            top: screenAwareSize(4, 8, context),
                            bottom: screenAwareSize(8, 16, context)),
                        child: FormField<String>(
                          enabled: newFinance.isServiceFeeCollected,
                          validator: (value) {
                            if (value == null &&
                                newFinance != null &&
                                newFinance.isServiceFeeCollected != null &&
                                newFinance.isServiceFeeCollected) {
                              return "Select Payment mode";
                            } else {
                              return null;
                            }
                          },
                          onSaved: (value) {
                            //save data into model here
                            print(value);
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
                                      border:
                                          new Border.all(color: Colors.grey),
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
                                          child: DropdownButton<
                                                  PaymentModeModel>(
                                              hint: Text(
                                                  'Select Method of Collection'),
                                              disabledHint: Text(
                                                  'Select Method of Collection'),
                                              isDense: true,
                                              value: _generalInformationBloc
                                                  .selectedPaymentMode,
                                              items: newFinance != null &&
                                                      newFinance
                                                              ?.isServiceFeeCollected !=
                                                          null &&
                                                      newFinance
                                                          .isServiceFeeCollected
                                                  ? _generalInformationBloc
                                                      .paymentModes
                                                      .map((PaymentModeModel
                                                          item) {
                                                      return DropdownMenuItem<
                                                          PaymentModeModel>(
                                                        child: Text(
                                                            item.paymentMode),
                                                        value: item,
                                                      );
                                                    }).toList()
                                                  : [],
                                              onChanged: (value) {
                                                state.didChange(value
                                                    .paymentModeId
                                                    .toString());
                                                _generalInformationBloc
                                                    .setPaymentMode(
                                                        value.paymentModeId);

                                                newFinance.paymentModeId =
                                                    value.paymentModeId;
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
                                        style: TextStyle(
                                            color: Colors.red.shade700,
                                            fontSize: 12.0),
                                      )
                                    : Container(),
                              ],
                            );
                          },
                        ),
                      ),
                      //   }
                      //   return Container();
                      // }),
                      Row(
                        children: <Widget>[
                          Flexible(
                              child: Text(
                            "* If Credit Card or Electronic Check, input in Converge Mobile after adding Service Fee here",
                            style: TextStyle(color: Colors.red),
                          )),
                        ],
                      ),
                      widget.finance.isServiceFeeCollected == null
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                  RaisedButton(
                                      color: Colors.blue,
                                      elevation: 5,
                                      disabledColor: Colors.grey,
                                      child: Text(
                                        'Add Service Fee',
                                        style: TextStyle(
                                            fontFamily: 'Roboto',
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: screenAwareSize(
                                                13, 26, context)),
                                      ),
                                      onPressed: newFinance
                                                  .isServiceFeeCollected !=
                                              null
                                          ? () {
                                              if (formKey.currentState
                                                  .validate()) {
                                                formKey.currentState.save();

                                                if (!enableServiceFeeBtn) {
                                                  return null;
                                                }

                                                if (newFinance
                                                    .isServiceFeeCollected) {
                                                  newFinance.amountCollected =
                                                      double.parse(
                                                          _amountController
                                                              .text);
                                                }

                                                _generalInformationBloc
                                                    .dispatch(AddServiceFee(
                                                        orderId: widget.orderId,
                                                        finance: newFinance));
                                                setState(() {
                                                  enableServiceFeeBtn = false;
                                                });
                                              }
                                            }
                                          : () {})
                                ])
                          : Container(),
                      SizedBox(
                        height: screenAwareSize(15, 30, context),
                      )
                    ],
                  ),
                ),
              ),
            );
          }
          return Container();
        });
  }
}
