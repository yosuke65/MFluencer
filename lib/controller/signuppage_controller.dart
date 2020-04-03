
import 'package:finalproject/view/frontpage.dart';
import '../view/signuppage.dart';
import '../controller/myfirebase.dart';
import '../view/mydialog.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';

class SignUpPageController {
  SignUpPageState state;
  

  SignUpPageController(this.state);

  Future getImage() async {
    var _image = await ImagePicker.pickImage(source: ImageSource.gallery);
    state.stateChanged((){
      state.image = _image;
      state.uploadImage = true;
      print('Image Path $state.image');
    });
  }

  String validateEmail(String value) {
    if (value == null || !value.contains('.') || !value.contains('@')) {
      return 'Enter a valid Email address';
    }
    return null;
  }

  void saveEmail(String value) {
    state.user.email = value;
  }

  String validatePassword(String value) {
    if (value == null) {
      return 'Enter a Password';
    }
    return null;
  }

  void savePassword(String value) {
    state.user.password = value;
  }

  String validateDisplayName(String value) {
    if (value == null || value.length < 3) {
      return 'Enter at least 3 characters';
    }
    return null;
  }

  void saveDisplayName(String value) {
    state.user.displayName = value;
  }

  //   String validateImageURL(String value) {
  //   if (value == null || value.length < 3) {
  //     return 'Enter at least 3 characters';
  //   }
  //   return null;
  // }

  // void saveImageURL(String value) {
  //   state.user.imageURL = value;
  // }

      String validateDescription(String value) {
    if (value == null || value.length < 5) {
      return 'Enter description (min 5 chars)';
    }
    return null;
  }

  void saveDescription(String value) {
    state.user.description = value;
  }

  void radioValueHandler(int value) {
    state.stateChanged(() {
      state.radioValue = value;
    });
    switch (state.radioValue) {
      case 0:
        state.stateChanged(() {
          //print('Influencer');
          state.user.userType = 'Influencer';
        });
        break;
      case 1:
        state.stateChanged(() {
          //print('Brand');
          state.user.userType = 'Brand';
        });
        break;
    }
  }

  void createAccount() async {
    print(state.uploadImage.toString());
    if(state.uploadImage){
    String filename = basename(state.image.path);
    StorageReference firebaseStorageRef = FirebaseStorage.instance.ref().child(filename);
    StorageUploadTask uploadTask = firebaseStorageRef.putFile(state.image);
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    //state.user.imageURL = filename;
    print('File Uploaded********************************************************************'); 
    print('Filename: ' + filename);   
    // firebaseStorageRef.getDownloadURL().then((fileURL) {      
    //    state.user.imageURL = fileURL;    
    //  });
    state.user.imageURL = filename; 
    }else{
      state.user.imageURL = 'https://dongthinh.org/wp-content/uploads/2015/11/avatar.jpg';
    }
    if (!state.formKey.currentState.validate()) {
      print('return');
      return;
    }

    MyDialog.showProgressBar(state.context);
    state.formKey.currentState.save();

    try {
      state.user.uid = await MyFireBase.createAccount(
        email: state.user.email,
        password: state.user.password,
      );
    } catch (e) {
      MyDialog.popProgressBar(state.context);
      MyDialog.info(
        context: state.context,
        title: 'Account creation failed',
        message: e.message != null ? e.message : e.toString(),
        action: () => Navigator.pop(state.context),
      );

      return;
    }

    try {
      state.user.isNewMatch = false;
      state.user.isNewLiked = false;
      MyFireBase.createProfile(state.user);
      // print(state.user.displayName);
      // print(state.user.email);
      print('UID: ' + state.user.uid);
      print('isNewMatch: ' + state.user.isNewMatch.toString());
      print('isNewLiked: ' + state.user.isNewLiked.toString());

    } catch (e) {
      state.user.displayName = null;
      // state.user.zip = null;
    }

    MyDialog.popProgressBar(state.context);

    MyDialog.info(
      context: state.context,
      title: 'Account created Successfully',
      message: 'Your account is created with ${state.user.email}',
      action: () => Navigator.push(
        state.context,
        MaterialPageRoute(builder: (context) => FrontPage()),
      ),
    );
}
}