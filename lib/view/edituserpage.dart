import 'dart:io';
import 'package:flutter/material.dart';
import '../controller/edituserpage_controller.dart';
import '../model/user.dart';

class EditUserPage extends StatefulWidget {
  final user;
  EditUserPage(this.user);
  @override
  State<StatefulWidget> createState() {
    return EditUserPageState(user);
  }
}

class EditUserPageState extends State<EditUserPage> {
  EditUserPageController controller;
  BuildContext context;
  var formKey = GlobalKey<FormState>();
  User user;
  int radioValue = -1;
  File image;
  bool uploadImage = false;
  //String uploadedFileURL;

  EditUserPageState(this.user) {
    controller = EditUserPageController(this);
  }

  void stateChanged(Function fn) {
    setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Page'),
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
                              user.imageURL,
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
                labelText: 'Email',
              ),
              validator: controller.validateEmail,
              onSaved: controller.saveEmail,
            ),
            TextFormField(
              initialValue: user.password,
              autocorrect: false,
              decoration: InputDecoration(
                labelText: 'Password',
              ),
              validator: controller.validatePassword,
              onSaved: controller.savePassword,
            ),
            TextFormField(
              initialValue: user.displayName,
              autocorrect: false,
              decoration: InputDecoration(
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
              child: Text('Save',style: TextStyle(color: Colors.white),),
              onPressed: controller.save,
            ),
          ],
        ),
      ),
    );
  }
}
