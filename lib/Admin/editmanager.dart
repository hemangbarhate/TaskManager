import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../constant/ApI.dart';
import 'homepage.dart';
import 'model/managermodel.dart';
import 'package:email_validator/email_validator.dart';
import 'package:intership/Admin/model/session.dart';

TextEditingController emailcontroller = TextEditingController();
TextEditingController namecontroller = TextEditingController();
TextEditingController passwordcontroller = TextEditingController();
TextEditingController mobilecontroller = TextEditingController();

class EditManager extends StatefulWidget {
  const EditManager({Key? key , required this.manager}) : super(key: key);
  final Operator manager;
  @override
  State<EditManager> createState() => _EditManagerState();
}

class _EditManagerState extends State<EditManager> {

  TextEditingController emailcontroller = TextEditingController();
  TextEditingController namecontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController mobilecontroller = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  PickedFile? pickedImage;
  late File imageFile;
  bool load = false;

  Future chooseImage() async {
    print('bbaaaaaaaaaaaa');
    final pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
    );
    setState(() {
      print('aaaaaaaaaaaaaa');
      pickedImage = pickedFile;
      imageFile = File(pickedImage!.path);
      load = true;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[200],
        shadowColor: Colors.white,
        title: Container(
            child: const Text(
              "Edit Manager",
              style: TextStyle(
                  fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),
            )),
        elevation: 0.0,
        leading: Builder(builder: (BuildContext context) {
          return Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                }),
          );
        }),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: _formKey,
          child: ListView(
            children: [
              const SizedBox(
                height: 25,
              ),
              TextFormField(
                style: TextStyle(color: Colors.black),
                controller: emailcontroller..text = widget.manager.email,
                decoration: const InputDecoration(
                  icon: Icon(
                    Icons.email_outlined,
                    color: Colors.black,
                  ),
                  hintText: 'Enter Manager Email',
                  hintStyle: TextStyle(color: Colors.black),
                  labelText: 'Email',
                  labelStyle: TextStyle(color: Colors.black),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)),
                ),
                validator: (email) =>
                email != null && !EmailValidator.validate(email)
                    ? 'Enter a valid email'
                    : null,
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                style: TextStyle(color: Colors.black),
                controller: namecontroller..text = widget.manager.name,
                // initialValue: widget.manager.name,
                decoration: const InputDecoration(
                  icon: Icon(
                    Icons.person,
                    color: Colors.black,
                  ),
                  hintText: 'Enter Manager name',
                  hintStyle: TextStyle(color: Colors.black),
                  labelText: 'Manager Name',
                  labelStyle: TextStyle(color: Colors.black),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)),
                ),
                validator: (value) {
                  if (value != null && value.length < 4) {
                    return 'Enter min. 4 characters';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  chooseImage();
                },
                child: Container(
                  child: load == true
                      ? Container(
                    height: 200,
                    width: 200,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                          image: FileImage(imageFile),
                        ),
                        borderRadius: BorderRadius.circular(20)),
                    padding: const EdgeInsets.all(15.0),
                  )
                      : Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      children: [
                        Container(
                          child: Image.asset(
                            'assets/images/choose.png',
                            height: 130.0,
                            width: 130.0,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Text('Choose Image'),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                style: TextStyle(color: Colors.black),
                controller: passwordcontroller..text='Click to change',
                decoration: const InputDecoration(
                  icon: Icon(
                    Icons.password,
                    color: Colors.black,
                  ),
                  hintText: 'Enter Password',
                  hintStyle: TextStyle(color: Colors.black),
                  labelText: 'Password',
                  labelStyle: TextStyle(color: Colors.black),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)),
                ),
                // validator: (value) {
                //   if (value != null && value.length < 6) {
                //     return 'Enter min. 6 characters';
                //   }
                //   return null;
                // },
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                style: TextStyle(color: Colors.black),
                controller: mobilecontroller..text = widget.manager.mobile,
                // initialValue: widget.manager.mobile,
                decoration: const InputDecoration(
                  icon: Icon(
                    Icons.phone,
                    color: Colors.black,
                  ),
                  hintText: 'Enter a phone number',
                  hintStyle: TextStyle(color: Colors.black),
                  labelText: 'Phone',
                  labelStyle: TextStyle(color: Colors.black),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)),
                ),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value != null && value.length != 10) {
                    return 'Enter 10 digits';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 12,
              ),
              SizedBox(
                  height: 50,
                  child: ElevatedButton(
                      onPressed: () async {
                        final isValidForm = _formKey.currentState!.validate();
                        var imagePath = '';
                        if (isValidForm) {
                          Session _session = Session();
                          if(load == false){
                            imagePath = '';
                          }
                          else{
                            imagePath = pickedImage!.path;
                          }
                          var response = await _session.editData(
                              'manager',
                              emailcontroller.text.toString(),
                              namecontroller.text.toString(),
                              passwordcontroller.text.toString(),
                              mobilecontroller.text.toString(),
                              'noorganization',
                              'nodeptId',
                              imagePath,
                              '$ip/admin/editManager/${widget.manager.managerId}');
                          log('this ${response.toString()}');
                          if (response == null) {
                            return;
                          } else {
                            if(response['success']==false){
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(content: Text(response['error'])));
                            }
                            else{
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(content: Text(response['data'])));
                            }
                            Navigator.of(context).pushReplacement(MaterialPageRoute(
                                builder: (context) => const HomePage()));
                          }
                        }
                      },
                      child: Text('Edit Manager'))),
            ],
          ),
        ),
      ),
    );
  }
}
