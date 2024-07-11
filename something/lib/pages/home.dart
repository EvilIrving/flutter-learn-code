import 'package:flutter/material.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';
// import 'package:provider/provider.dart';
import '../data/BannerData.dart';
// import '../model/home.dart';
import '../route/routes.dart';
import '../api/homeApi.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  // ignore: no_logic_in_create_state
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<BannerListData>? bannerList;

  @override
  void initState() {
    super.initState();
    // 异步请求数
    getBannerData();
  }

  void getBannerData() async {
    bannerList = await HomeApi.getBanner();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home pages'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // ChangeNotifierProvider(
              //   create: (_) => BannerModel(),
              //   child: Consumer<BannerModel>(
              //     builder: (context, bannerModel, child) {
              //       return buildSwiperViewWidget(bannerModel.bannerList);
              //     },
              //   ),
              // ),
              buildSwiperViewWidget(bannerList),
              buildListViewWidget()
            ],
          ),
        ),
      ),
    );
  }

  /// 轮播图
  Widget buildSwiperViewWidget(List<BannerListData>? bannerList) {
    return Container(
      height: 200,
      width: double.infinity,
      color: Colors.amber,
      child: Swiper(
        itemCount: bannerList?.length ?? 0,
        itemBuilder: (context, index) {
          return Center(
            child: Image.network(bannerList?[index].imagePath ?? '',
                fit: BoxFit.fill),
          );
        },
        autoplay: true,
        pagination: const SwiperPagination(),
        control: const SwiperControl(),
      ),
    );
  }

  /// 列表
  Widget buildListViewWidget() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return buildCustomCard(context, "User $index", "2024-07-11 1$index:00",
            "Category $index", "Title $index");
      },
      itemCount: 20,
    );
  }

  /// 自定义卡片
  Widget buildCustomCard(BuildContext context, String username, String time,
      String category, String title) {
    return GestureDetector(
        onTap: () {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //       builder: (context) => ArticlePage(title: title,)), // 在点击时导航到 article.dart 页面
          // );

          Navigator.pushNamed(
            context,
            Routes.article, // 使用路由清单中定义的 article 路由
            arguments: {
              "name": title,
              "content": "content of some article $title "
            }, // 传递参数给 ArticlePage 页面
          );
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 3,
                blurRadius: 10,
                offset: const Offset(0, 2), // changes the shadow direction
              ),
            ],
          ),
          margin: const EdgeInsets.all(8.0),
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  ClipRRect(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(20.0)),
                      child: Image.asset('assets/user.png',
                          width: 40, height: 40, fit: BoxFit.cover)),
                  // const CircleAvatar(
                  //   backgroundImage: AssetImage('assets/user.png'),
                  //   radius: 20.0,
                  // ),

                  const SizedBox(width: 8.0),
                  Text(
                    username,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  // const Expanded(child: SizedBox()),
                  Text(
                    time,
                    style: const TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(width: 8.0),
                  GestureDetector(
                    onTap: () {
                      // 点击事件处理
                      print("object");
                    },
                    child: const Text(
                      '置顶',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8.0),
              Text(
                title,
                style: const TextStyle(
                    fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8.0),
              Row(
                children: [
                  Text(
                    category,
                    style: const TextStyle(color: Colors.grey),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      // 点击事件处理
                    },
                    child: const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
