import 'package:codephile/resources/helper_functions.dart';
import 'package:codephile/services/institute_list.dart';
import 'package:flutter/cupertino.dart';
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';
import 'progress_tab_bar.dart';
import 'signup2.dart';
import 'package:codephile/resources/colors.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  String _name, _institute, _email;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  final _formKey = new GlobalKey<FormState>();
  bool isNextButtonTapped = false;
  List<String> _instituteList = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    isNextButtonTapped = false;
    showConnectivityStatus();
    getInstituteList().then((instituteList) {
      setState(() {
        if (instituteList.length != 0) {
          _instituteList = instituteList;
        } else {
          _instituteList = [
            'Indian Institute of Technology Roorkee',
            'Indian Institute of Technology Delhi',
            'Indian Institute of Technology Mandi',
            'Indian Institute of Technology Indore',
            'Indian Institute of Technology Bombay'
          ];
        }
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      resizeToAvoidBottomInset: false,
      key: _scaffoldKey,
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      ProgressTabBar(1),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  0.0, 20.0, 0.0, 20.0),
                              child: Text('What\'s your name?',
                                  style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold)),
                            ),
                            _showNameInput(),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  0.0, 20.0, 0.0, 20.0),
                              child: Text('What\'s your email?',
                                  style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold)),
                            ),
                            _showEmailInput(),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                              child: Text('What is the name of your Institute?',
                                  style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold)),
                            ),
                            _showInstituteInput(),
                          ],
                        ),
                      ),
                    ],
                  ),
                  _showNextButton(),
                ],
              ),
            ),
    );
  }

  Widget _showNameInput() {
    return new TextFormField(
      maxLines: 1,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: 'Enter full name',
        border: OutlineInputBorder(),
        labelStyle: TextStyle(fontFamily: 'Montserrat', color: Colors.grey),
      ),
      validator: (value) => value.isEmpty ? 'Name can\'t be empty' : null,
      onSaved: (value) => _name = value,
    );
  }

  Widget _showEmailInput() {
    return new TextFormField(
      maxLines: 1,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: 'Enter email ID',
        border: OutlineInputBorder(),
        labelStyle: TextStyle(fontFamily: 'Montserrat', color: Colors.grey),
      ),
      validator: (value) => value.isEmpty
          ? 'Email can\'t be empty'
          : RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                  .hasMatch(value)
              ? null
              : "Enter a valid email address!",
      onSaved: (value) => _email = value,
    );
  }

  Widget _showInstituteInput() {
    return Container(
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.all(Radius.circular(4.0)),
      ),
      child: SearchableDropdown<String>(
        underline: const SizedBox(height: 0.0),
        items: _instituteList
            .map((value) => DropdownMenuItem<String>(
                  value: value,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Text(
                      value,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ))
            .toList(),
        onChanged: (String institute) {
          setState(() {
            _institute = institute;
          });
        },
        hint: SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
              child: Text(
                "Select Institute",
                style: TextStyle(color: Colors.grey),
              ),
            )),
      ),
    );
  }

  Widget _showNextButton() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextButton(
        style: TextButton.styleFrom(
            primary: isNextButtonTapped ? Colors.grey[500] : codephileMain
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.85,
            child: Text(
              'NEXT',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16.0,
                color: isNextButtonTapped ? Colors.grey[700] : Colors.white,
              ),
            ),
          ),
        ),
        onPressed: _validateAndSubmit,
      ),
    );
  }

  bool _validateAndSave() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  void _validateAndSubmit() {
    if (_validateAndSave()) {
      setState(() {
        isNextButtonTapped = true;
      });

      if (isNextButtonTapped) {
        setState(() {
          isNextButtonTapped = false;
          Navigator.push(
              context,
              new MaterialPageRoute(
                  builder: (context) => new SignUpPage2(
                        name: _name,
                        email: _email,
                        institute: (_institute == null) ? "" : _institute,
                      )));
        });
      }
    }
  }
}
