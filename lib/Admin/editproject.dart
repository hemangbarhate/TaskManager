import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../constant/ApI.dart';
import 'homepage.dart';
import 'model/projectnamemodel.dart';
import 'model/session.dart';

TextEditingController projectcontroller = TextEditingController();

class EditProject extends StatefulWidget {
  const EditProject({Key? key, required this.project}) : super(key: key);
  final ProjectName project;
  @override
  State<EditProject> createState() => _EditProjectState();
}

class _EditProjectState extends State<EditProject> {
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
      imageFile = File(pickedFile!.path);
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
          "Edit Project",
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
          child: Column(
            children: [
              const SizedBox(
                height: 25,
              ),
              TextFormField(
                style: TextStyle(color: Colors.black),
                controller: projectcontroller
                  ..text = widget.project.projectName!,
                decoration: const InputDecoration(
                  icon: Icon(
                    Icons.add_card_outlined,
                    color: Colors.black,
                  ),
                  hintText: 'Enter Project Type',
                  hintStyle: TextStyle(color: Colors.black),
                  labelText: 'ProjectName',
                  labelStyle: TextStyle(color: Colors.black),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)),
                ),
                validator: (value) {
                  if (value != null && value.length < 4) {
                    return 'This field cant be less than 4';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 16,
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
                height: 16,
              ),
              SizedBox(
                height: 50,
                child: ElevatedButton(
                  onPressed: () async {
                    final isValidForm = _formKey.currentState!.validate();
                    var imagePath = '';
                    if (isValidForm) {
                      Session _session = Session();
                      if (load == false) {
                        imagePath = '';
                      } else {
                        imagePath = pickedImage!.path;
                      }
                      var response = await _session.uploadProjectData(
                          projectcontroller.text.toString(),
                          imagePath,
                          '$ip/admin/editProject/${widget.project.projectId}');
                      // var response = await _session.editData(
                      //     'project',
                      //     'emailcontroller.text.toString()',
                      //     projectcontroller.text.toString(),
                      //     'passwordcontroller.text.toString()',
                      //     'mobilecontroller.text.toString()',
                      //     'organizationcontroller.text.toString()',
                      //     'nodeptId',
                      //     pickedImage!.path,
                      //     '$ip//admin/editProject/${widget.project.projectId}');
                      log('this ${response.toString()}');
                      if (response == null) {
                        return;
                      } else {
                        if (response['success'] == false) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(response['error'])));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(response['data'])));
                        }
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => const HomePage()));
                      }
                    }
                  },
                  child: Text('Edit Project'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
