import 'dart:io';
import 'package:app_movie/app_container.dart';
import 'package:app_movie/common/common.dart';
import 'package:app_movie/common/style/color.dart';
import 'package:app_movie/common/style/fonts.dart';
import 'package:app_movie/screens/profile/widgets/profile_pic.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileDetailScreen extends StatefulWidget {
  static const routerName = 'profile-screen';

  @override
  _ProfileDetailScreenState createState() => _ProfileDetailScreenState();
}

class _ProfileDetailScreenState extends State<ProfileDetailScreen> {
  String _url;

  @override
  Widget build(BuildContext context) {

    return AppContainer(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColor.white,
        title: Text('My Profile'),
        centerTitle: true,
      ),
      child: Container(
        width: double.infinity,
        child: Column(
          children: [
            ProfilePic(onPressed: () async{
                _buildDialogImage(context);
            }, url: _url,),
            Expanded(child: Container()),
            MaterialButton(
              minWidth: MediaQuery.of(context).size.width*0.6,
              elevation: 0,
              onPressed: () {},
              padding: EdgeInsets.all(10.0),
              child: Text('Edit', style: TextStyle(color: AppColor.white, fontWeight: AppFontWeight.medium, fontSize: AppFontSize.medium),),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              color: Colors.black,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickerImage({ImageSource imageSource}) async {
    await ImagePicker.pickImage(source: imageSource)
        .then((value) => uploadImage(File(value.path)))
        .catchError((error) => print('Error Image =====> $error'));
  }

  Future<void> uploadImage(File file) async {
    Common.showLoading(context);
    StorageReference storageReference =  FirebaseStorage.instance.ref().child('image_users').child(file.path);
    StorageUploadTask uploadTask =  storageReference.putFile(file);
    StorageTaskSnapshot taskSnapshot  = await uploadTask.onComplete;
    taskSnapshot.ref
        .getDownloadURL()
        .then((url) {
          setState(() {
            _url = url;
          });
    })
        .catchError((error) => print('Error ==========> $error'));
    Common.hideLoading(context);
  }

  Future<void> _buildDialogImage(BuildContext context) {
    return showDialog<void>(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: Center(child: Text('Choose type')),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SelectImagePicker(
                  title: 'Gallery',
                  onPressed: () {
                    Navigator.pop(ctx);
                    _pickerImage(imageSource: ImageSource.gallery);
                  },
                ),
                SelectImagePicker(
                  title: 'Camera',
                  onPressed: () {
                    Navigator.pop(ctx);
                    _pickerImage(imageSource: ImageSource.camera);
                  },
                )
              ],
            ),
            contentTextStyle: TextStyle(color: AppColor.black),
            contentPadding: EdgeInsets.all(0.0),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Cancel', style: TextStyle(color: AppColor.red),),
                style: TextButton.styleFrom(
                  padding: EdgeInsets.all(16.0)
                ),
              ),
            ],
          );
        });
  }

}

class SelectImagePicker extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;

  const SelectImagePicker({Key key, this.onPressed, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => onPressed.call(),
      child: Text(title,style: TextStyle(color: AppColor.black, fontSize: AppFontSize.label, fontWeight: AppFontWeight.normal,),),
      style: TextButton.styleFrom(padding: EdgeInsets.symmetric(horizontal: 24.0), primary: AppColor.white,),
    );
  }
}

