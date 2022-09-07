import 'package:flutter/material.dart';

class NewsDetails extends StatefulWidget {
  final newsData;
  const NewsDetails({Key? key, @required this.newsData}) : super(key: key);
  @override
  _NewsDetailsState createState() => _NewsDetailsState();
}

class _NewsDetailsState extends State<NewsDetails> {

  var newsData;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    newsData = widget.newsData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text(
          "News Details",
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500
          ),
        ),

      ),
      body: SingleChildScrollView(
        child: newsData != null
       ?  Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 8),
              child: Text(
                "${newsData['title']}",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF404E63),
                ),
              ),
            ),

            Container(
              margin: EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
              child: Image.network(
                "${newsData['urlToImage']}",
                height: 250,
                fit: BoxFit.cover,
                errorBuilder: (context, error, trace) {
                  return Container(
                    child: Image.asset("assets/ic_user.png",height: 250, ),
                  );
                },
                loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) return child;
                     return Center(
                       child: CircularProgressIndicator(
                         value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                          : null,
                        ),
                     );
                  },
              ),
            ),

            newsData['author'] == null
            ? Container()
            : Container(
              margin: EdgeInsets.only(left: 16, right: 16, top: 0, bottom: 8),
              alignment: Alignment.center,
              child: Text(
                "${newsData['author']}",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF404E63),
                ),
              ),
            ),

            Container(
              margin: EdgeInsets.only(left: 16, right: 16, top: 0, bottom: 8),
              child: Text(
                "${newsData['description']}",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF404E63),
                  height: 1.5
                ),
              ),
            ),
          ],
        )
        : Center(
          child: Text("No news details available!!"),
        ),
      ),
    );
  }
}
