import 'package:flutter/material.dart';
import 'package:space_app/model/postData.dart';
import 'package:space_app/theme/themeData.dart';
import 'package:space_app/views/post_page/postPage.dart';

class PostCard extends StatefulWidget {
  static const _paddingValue = 16.0;
  static const cardPadding = const EdgeInsets.all(_paddingValue);
  PostData data;

  PostCard(this.data);

  @override
  _PostCardState createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(context,
          MaterialPageRoute(builder: (context) => PostPage(widget.data))),
      child: Card(
        color: AppTheme.theme.cardColor,
        elevation: 2,
        child: ConstrainedBox(
          constraints: BoxConstraints(minWidth: double.infinity),
          child: Padding(
            padding: PostCard.cardPadding,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(child: Row(children: _buildTitle(context)), width: MediaQuery.of(context).size.width - (2*PostCard._paddingValue),),
                SizedBox(height: 5),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: _buildContent(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildTitle(BuildContext context) {
    return [
      SizedBox(
          child: Text(
            widget.data.title,
            style: AppTheme.cardStyle['titleStyle'],
            overflow: TextOverflow.clip,
            softWrap: true,
          ),
          width: MediaQuery.of(context).size.width - (2*PostCard._paddingValue) - 128),
      Spacer(),
      _buildStarButton(context),
    ];
  }

  IconButton _buildStarButton(BuildContext context) {
    Icon starIcon = widget.data.isFavorited
        ? Icon(Icons.star, color: AppTheme.cardStyle['starColor'])
        : Icon(Icons.star_border);
    return IconButton(
      icon: starIcon,
      onPressed: () {
        setState(() {
          widget.data.isFavorited = !widget.data.isFavorited;
        });
        if (!widget.data.isFavorited)
          ScaffoldMessenger.of(context).showSnackBar(_buildSnackBar());
      },
    );
  }

  SnackBar _buildSnackBar() {
    return SnackBar(
      content: Text('Item removido dos favoritos'),
      elevation: 2,
      duration: Duration(seconds: 5),
      action: SnackBarAction(
        label: 'Desfazer',
        onPressed: () {
          setState(() {
            widget.data.isFavorited = !widget.data.isFavorited;
          });
        },
      ),
    );
  }

  List<Widget> _buildContent() {
    return [
      Expanded(
        child: Text(
          widget.data.content,
          style: AppTheme.cardStyle['textStyle'],
          maxLines: 5,
        ),
        flex: 5,
      ),
      Spacer(flex: 1),
      Expanded(
        child: widget.data.buildImage(),
        flex: 3,
      )
    ];
  }
}
