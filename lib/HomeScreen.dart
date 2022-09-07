import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:newsapiintileotecno/news_details.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoading = false;

  List newsList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getNewsApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text(
            "News App",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500
          ),
        ),

      ),

      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 16,),
                ListView.builder(
                    itemCount:newsList != null ? newsList.length : 0,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index){
                      return GestureDetector(
                        onTap: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => NewsDetails(
                                newsData: newsList[index],
                              )
                            )
                          );
                        },
                        child: Container(
                          margin: EdgeInsets.only(left: 8,right: 8,bottom: 8),
                          padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 16),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.white
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(left: 0, top: 4),
                                    child: Image.network(
                                      "${newsList[index]['urlToImage']}",
                                      width: 60,
                                      height: 60,
                                      fit: BoxFit.cover,
                                      errorBuilder: (context, error, trace) {
                                        return Container(
                                          child: Image.asset("assets/ic_user.png",height: 60, width: 60,),
                                        );
                                      },
                                        loadingBuilder: (BuildContext context, Widget child,
                                            ImageChunkEvent? loadingProgress) {
                                          if (loadingProgress == null) return child;
                                          return Center(
                                            child: CircularProgressIndicator(
                                              value: loadingProgress.expectedTotalBytes != null
                                                  ? loadingProgress.cumulativeBytesLoaded /
                                                  loadingProgress.expectedTotalBytes!
                                                  : null,
                                            ),
                                          );
                                        },
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      margin: EdgeInsets.only(left: 8),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,

                                        children: [
                                          Container(
                                            child: Text(
                                              "${newsList[index]['title']}",
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                                color: Color(0xFF404E63),
                                              ),
                                            ),
                                          ),

                                          Container(
                                            margin: EdgeInsets.only(top: 8),
                                            child: Text(
                                              "${newsList[index]['description']}",
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                                color: Color(0xFF404E63),
                                              ),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ) ,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 6,),

                            ],
                          ),
                        ),
                      );
                    }
                ),

              ],
            ),
          ),

          Visibility(
            visible: isLoading,
            child: Center(
              child: Container(
                height: 50,
                width: 50,
                child: CircularProgressIndicator(
                  color: Colors.blueAccent,
                  strokeWidth: 5,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void setLoadingStatus(status) {
    setState(() {
      isLoading = status;
    });
  }

  void getNewsApi() async {
    setLoadingStatus(true);
    Map<String, String> headers = {
      "Accept":"application/json",
      "Content-Type":"application/json",
    };

    var url = "https://newsapi.org/v2/everything?q=tesla&from=2022-09-04&sortBy=publishedAt&apiKey=733641028db34bfba2c6b7a771a1857e";
    log("Url ==== $url");
    var response = await http.get(Uri.parse(url), headers: headers);
    setLoadingStatus(false);

    if(response.statusCode == 200) {
      var resultData = json.decode(response.body);

      setState(() {
        newsList = resultData['articles'];
      });
    }
  }
}
