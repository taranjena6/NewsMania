import 'package:NewsMania/Models/article_model.dart';
import 'package:NewsMania/Models/category_model.dart';
import 'package:NewsMania/helper/data.dart';
import 'package:NewsMania/helper/news.dart';
import 'package:NewsMania/views/category_news.dart';
import 'package:flutter/material.dart';
import 'article_views.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<CategoryModel> categories = List<CategoryModel>();
  List<ArticleModel> articles = List<ArticleModel>();
  bool loading = true;
  @override
  void initState() {
    super.initState();
    categories = getCategories();
    getNews();
  }

  getNews() async {
    News news = News();
    await news.getNews();
    articles = news.news;
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("News"),
              Text(
                "Mania",
                style: TextStyle(color: Colors.blue),
              )
            ],
          ),
          elevation: 0.0,
        ),
        body: loading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: [
                      //categories
                      Container(
                        //padding: EdgeInsets.symmetric(horizontal: 16.0),
                        height: 70.0,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: categories.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return CategoryTile(
                                image: categories[index].image,
                                categoryName: categories[index].categoryName,
                              );
                            }),
                      ),

                      //blogs
                      Container(
                        margin: EdgeInsets.only(top: 16.0),
                        child: ListView.builder(
                            itemCount: articles.length,
                            shrinkWrap: true,
                            physics: ClampingScrollPhysics(),
                            itemBuilder: (context, index) {
                              return BlogTile(
                                imageUrl: articles[index].urlToImage,
                                title: articles[index].title,
                                url: articles[index].url,
                              );
                            }),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}

class CategoryTile extends StatelessWidget {
  final String image;
  final String categoryName;
  CategoryTile({this.image, this.categoryName});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return CategoryNews(
            category: categoryName.toLowerCase(),
          );
        }));
      },
      child: Container(
        margin: EdgeInsets.only(right: 16.0),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(6.0),
              child: Image.asset(
                image,
                width: 120.0,
                height: 60.0,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6.0),
                color: Colors.black26,
              ),
              width: 120.0,
              height: 60.0,
              child: Text(categoryName,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w500,
                  )),
            )
          ],
        ),
      ),
    );
  }
}

class BlogTile extends StatelessWidget {
  final String imageUrl, title, url;
  BlogTile({@required this.imageUrl, @required this.title, @required this.url});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return ArticleView(
            blogUrl: url,
          );
        }));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 24.0),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(6.0),
                bottomLeft: Radius.circular(6.0))),
        child: Column(
          children: [
            ClipRRect(
              child: Image.network(
                imageUrl,
                height: 200.0,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(6.0),
            ),
            SizedBox(height: 7.0),
            Text(
              title,
              maxLines: 2,
              style: TextStyle(
                  color: Colors.black87,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}
