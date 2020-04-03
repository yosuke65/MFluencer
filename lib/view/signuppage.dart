import 'dart:io';
import 'package:flutter/material.dart';
import '../controller/signuppage_controller.dart';
import '../model/user.dart';

class SignUpPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SignUpPageState();
  }
}

class SignUpPageState extends State<SignUpPage> {
  SignUpPageController controller;
  BuildContext context;
  var formKey = GlobalKey<FormState>();
  User user = User();
  int radioValue = -1;
  File image;
  bool uploadImage = false;
  //String uploadedFileURL;

  SignUpPageState() {
    controller = SignUpPageController(this);
  }

  void stateChanged(Function fn) {
    setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Account'),
      ),
      body: Form(
        key: formKey,
        child: ListView(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                top: 30,
              ),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 30.0),
                child: CircleAvatar(
                  radius: 100,
                  backgroundColor: Color(0xff476cfb),
                  child: ClipOval(
                    child: SizedBox(
                      width: 180,
                      height: 180,
                      child: (image != null)
                          ? Image.file(image, fit: BoxFit.fill)
                          : Image.network(
                              'https://dongthinh.org/wp-content/uploads/2015/11/avatar.jpg',
                              fit: BoxFit.fill,
                            ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: 60,
                ),
                child: IconButton(
                  icon: Icon(
                    Icons.camera,
                  ),
                  iconSize: 30,
                  onPressed: () {
                    controller.getImage();
                  },
                ),
              ),
            ]),

            TextFormField(
              initialValue: user.email,
              autocorrect: false,
              decoration: InputDecoration(
                hintText: 'Email (as login name)',
                labelText: 'Email',
              ),
              validator: controller.validateEmail,
              onSaved: controller.saveEmail,
            ),
            TextFormField(
              initialValue: user.password,
              autocorrect: false,
              decoration: InputDecoration(
                hintText: 'Password',
                labelText: 'Password',
              ),
              validator: controller.validatePassword,
              onSaved: controller.savePassword,
            ),
            TextFormField(
              initialValue: user.displayName,
              autocorrect: false,
              decoration: InputDecoration(
                hintText: 'Name',
                labelText: 'Name',
              ),
              validator: controller.validateDisplayName,
              onSaved: controller.saveDisplayName,
            ),
            // TextFormField(
            //   initialValue: user.imageURL,
            //   autocorrect: false,
            //   decoration: InputDecoration(
            //     hintText: 'Image URL',
            //     labelText: 'Image URL',
            //   ),
            //   validator: controller.validateImageURL,
            //   onSaved: controller.saveImageURL,
            // ),
            //             TextFormField(
            //   initialValue: '${user.zip}',
            //   autocorrect: false,
            //   decoration: InputDecoration(
            //     hintText: 'Zip Code',
            //     labelText: 'Zip Code',
            //   ),
            //   validator: controller.validateZip,
            //   onSaved: controller.saveZip,
            // ),
            Row(
              //mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Influencer'),
                Radio(
                  value: 0,
                  groupValue: radioValue,
                  onChanged: controller.radioValueHandler,
                ),
                Text('Brand'),
                Radio(
                  value: 1,
                  groupValue: radioValue,
                  onChanged: controller.radioValueHandler,
                ),
              ],
            ),
            TextFormField(
              initialValue: user.description,
              autocorrect: false,
              maxLines: 5,
              decoration: InputDecoration(
                labelText: 'Description: ',
              ),
              validator: controller.validateDescription,
              onSaved: controller.saveDescription,
            ),
            // Text('Selected Image'),
            // image != null
            //     ? Image.asset(
            //         image.path,
            //         height: 150,
            //       )
            //     : Container(height: 150),
            // image == null
            //     ? RaisedButton(
            //         child: Text('Choose File'),
            //         onPressed: controller.chooseFile,
            //         color: Colors.cyan,
            //       )
            //     : Container(),
            // image != null
            //     ? RaisedButton(
            //         child: Text('Upload File'),
            //         onPressed: controller.uploadFile,
            //         color: Colors.cyan,
            //       )
            //     : Container(),
            // //  image != null
            // //      ? RaisedButton(
            // //          child: Text('Clear Selection'),
            // //          onPressed: clearSelection,
            // //        )
            // //      : Container(),
            // Text('Uploaded Image'),
            // uploadedFileURL != null
            //     ? Image.network(
            //         uploadedFileURL,
            //         height: 150,
            //       )
            //     : Container(),
            RaisedButton(
              color: Colors.blue,
              child: Text('Create Account',style: TextStyle(color: Colors.white),),
              onPressed: controller.createAccount,
            ),
          ],
        ),
      ),
    );
  }
}
