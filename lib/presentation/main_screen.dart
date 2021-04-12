import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tm_pass/models/video_data.dart';
import 'package:tm_pass/presentation/video_screen.dart';
import 'package:tm_pass/workers/networking.dart';

class MasterScreen extends StatefulWidget {
  @override
  _MasterScreenState createState() => _MasterScreenState();
}

class _MasterScreenState extends State<MasterScreen> {
  final TextEditingController textEditingController =
      TextEditingController(text: '');
  final RestApiManager restApiManager = RestApiManager();

  final ImagePicker picker = ImagePicker();

  Future<String> uploadImage() async {
    PickedFile file = await picker.getVideo(source: ImageSource.gallery);
    VData data = await restApiManager.uploadVideoByCode(
        textEditingController.text, file.path);
    return data?.video;
  }

  void openVideoScreen(BuildContext context, String url) {
    final snackBar = SnackBar(content: Text('Ошибка'));

    if (url != null && url.isNotEmpty)
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => VideoScreen(url: url)));
    else
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        TextField(
          controller: textEditingController,
        ),
        TextButton(
            onPressed: () {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text('Загрузка')));
              return restApiManager
                  .getVideoByCode(textEditingController.text)
                  .then((value) {
                if (value != null && value?.video != null)
                  openVideoScreen(context, value.video);
                else {
                  if (textEditingController.text != '')
                    uploadImage()
                        .then((value) => openVideoScreen(context, value));
                }
              });
            },
            child: Text('Отправить'))
      ],
    ));
  }
}
