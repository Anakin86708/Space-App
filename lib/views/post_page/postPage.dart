import 'package:flutter/material.dart';
import 'package:space_app/model/postData.dart';
import 'package:space_app/theme/appColors.dart';
import 'package:space_app/theme/themeData.dart';
import 'package:space_app/views/interfacePage.dart';

class PostPage extends StatefulWidget implements InterfacePage {
  Icon _pageIcon = Icon(Icons.stroller);
  String _pageName = 'Post Page';
  final PostData data;

  PostPage(this.data);

  @override
  State<StatefulWidget> createState() {
    return PostPageState();
  }

  @override
  Icon get pageIcon => _pageIcon;

  @override
  String get pageName => _pageName;
}

class PostPageState extends State<PostPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.data.title),
      ),
      body: post(),
    );
  }

  Widget post() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            children: [
              banner(),
              Container(
                child: Align(
                  child: Padding(
                    padding: const EdgeInsets.all(13.0),
                    child: Icon(
                      Icons.star,
                      size: 35,
                    ),
                  ),
                  alignment: Alignment.topRight,
                ),
              ),
            ],
          ),
          SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _generateTitle(),
                  SizedBox(height: 20),
                  _generateContentText()
                ],
              ),
            ),
          ),
          SizedBox(height: 20),
          generateElevatedButton(),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  Text _generateTitle() {
    return Text(
      widget.data.title,
      style: AppTheme.postStyle["titleStyle"],
    );
  }

  Text _generateContentText() {
    return Text(
      '''Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur eu sodales nulla, in dignissim lorem. Donec non ex quis nunc suscipit imperdiet nec sed nisi. Nunc placerat erat a eros efficitur, et volutpat lacus scelerisque. Etiam tempor leo ut pretium scelerisque. Aenean dapibus est at velit elementum, non finibus magna auctor. Donec rutrum lectus eget nunc fringilla mattis. Donec nec posuere metus, ac mattis lectus. Aenean vel urna est. Aliquam venenatis et metus efficitur sodales. Cras pretium volutpat orci ut elementum. Sed mollis in lacus in rhoncus. Donec id rutrum lectus, ut faucibus erat. Nullam et ullamcorper ipsum. Quisque luctus libero eget elit consequat imperdiet. Sed mollis tempor tellus vestibulum sollicitudin. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos.

Aliquam imperdiet odio lectus, ac rutrum sapien dapibus ut. Praesent vitae nunc nunc. Vestibulum vitae congue felis. Cras nibh turpis, rhoncus suscipit vulputate a, tristique quis purus. Suspendisse luctus malesuada neque nec rutrum. Proin lacinia dui et molestie facilisis. Donec at tellus lacus. Nam accumsan nulla et eleifend eleifend. Mauris ultrices nulla rutrum consequat mollis. Cras id leo id eros aliquam blandit. Proin mattis arcu nec urna cursus volutpat. Donec varius ex sit amet fermentum posuere. Praesent eget posuere tellus.''',
      style: AppTheme.postStyle["contentStyle"],
      textAlign: AppTheme.postStyle["contentJustify"],
    );
  }

  Image generateImage() {
    return Image.network(
      "https://ohlaladani.com.br/wp-content/uploads/wallpaper-OHLALADANI_MOBILE_WALLPAPERS_CALMA-2.jpg",
      fit: BoxFit
          .cover, // fills the image as much as it can within its container.
    );
  }

  Widget banner() {
    return Container(
      constraints: BoxConstraints.expand(
        height: 200.0,
      ),
      child: generateImage(),
    );
  }

  generateElevatedButton() {
    return ElevatedButton(
      child: Text("Mais Informações"),
      style: ElevatedButton.styleFrom(
          primary: AppColors.accent,
          onPrimary: Colors.black,
          elevation: 3,
          enableFeedback: true),
      onPressed: () {
        showModalBottomSheet(
            context: context,
            builder: (context) {
              return Container(
                child: bottomNavigationMenu(),
                height: 150,
              );
            });
      },
    );
  }

  Column bottomNavigationMenu() {
    return Column(
      children: [
        ListTile(
          title: Text("Opção 01"),
          leading: Icon(Icons.ac_unit),
          onTap: () => Navigator.pop(context),
        ),
        ListTile(
          title: Text("Opção 02"),
          leading: Icon(Icons.ac_unit),
          onTap: () => Navigator.pop(context),
        )
      ],
    );
  }
}
