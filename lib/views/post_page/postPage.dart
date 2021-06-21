import 'package:flutter/material.dart';
import 'package:space_app/model/postData.dart';
import 'package:space_app/theme/appColors.dart';
import 'package:space_app/theme/themeData.dart';
import 'package:space_app/views/interfacePage.dart';
import 'package:url_launcher/url_launcher.dart';

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
      widget.data.content,
      style: AppTheme.postStyle["contentStyle"],
      textAlign: AppTheme.postStyle["contentJustify"],
    );
  }

  Image generateImage() {
    return Image.network(
      widget.data.imageUrl,
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
      child: Text("More info"),
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
    var validNamesForMenu = widget.data.data.getMenuItemIconList();
    List<Widget> itensMenu = [];
    validNamesForMenu.forEach((key, item) {
      itensMenu.add(ListTile(
        title: Text(item['name']),
        leading: item['icon'],
        onTap: () {
          Navigator.pop(context);
          _launchURL(item['value']);
        },
      ));
    });
    return Column(
      children: itensMenu,
    );
  }

  _launchURL(url) async {
      await launch(url);
  }
}
