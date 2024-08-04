import 'package:flutter/material.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:provider/provider.dart';
import 'package:something/data/articles_data.dart';
import 'package:something/data/banner_data.dart';
import '../model/home_model.dart';
import '../route/routes.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  final BannerModel _bannerModel = BannerModel();
  final ArticleModel _articleModel = ArticleModel();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      initArticleModel();
    });
  }

  Future<void> initArticleModel() async {
    await _bannerModel.getBannerData();
    await _articleModel.initArticleModel(false);
  }

  void refresh() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home pages'),
      ),
      body: SafeArea(
        child: SmartRefresher(
          enablePullDown: true,
          enablePullUp: true,
          header: const WaterDropHeader(),
          footer: const ClassicFooter(),
          onLoading: () async {
            // 下拉加载
            await ArticleModel().initArticleModel(true);
            _refreshController.loadComplete();
          },
          onRefresh: () async {
            // 上拉刷新
            await BannerModel().getBannerData();
            await ArticleModel().initArticleModel(false);
            _refreshController.refreshCompleted();
          },
          controller: _refreshController,
          child: SingleChildScrollView(
            child: Column(
              children: [
                ChangeNotifierProvider(
                  create: (_) => BannerModel(),
                  child: Consumer<BannerModel>(
                    builder: (context, bannerModel, child) {
                      return buildSwiperViewWidget(bannerModel.bannerList);
                    },
                  ),
                ),

                Container(
                  child: Text("TODO: 登录, 校验, cookies, webview, 登录名字,收藏页面, 版本更新 "),
                ),
                // buildListViewWidget()
                ChangeNotifierProvider(
                  create: (_) => ArticleModel(),
                  child: Consumer<ArticleModel>(
                    builder: (context, articleModel, child) {
                      return buildListViewWidget(articleModel.articleList);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// 轮播图
  Widget buildSwiperViewWidget(List<BannerItemData?>? bannerList) {
    return Container(
      height: 200,
      width: double.infinity,
      color: Colors.amber,
      child: Swiper(
        itemCount: bannerList?.length ?? 0,
        itemBuilder: (context, index) {
          return Center(
            child: Image.network(bannerList?[index]?.imagePath ?? '',
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
  Widget buildListViewWidget([List<ArticleItem>? articleList]) {
    return articleList?.isEmpty ?? false
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              String name = '';
              if (articleList?[index].author?.isNotEmpty == true) {
                name = articleList?[index].author ?? '';
              } else {
                name = '匿名用户';
              }

              // String name = articleList?[index].author?.isNotEmpty ? articleList?[index].author ?? '' : '匿名用户';

              return buildCustomCard(context, name, articleList?[index], index);
            },
            itemCount: 20,
          );
  }

  /// 自定义卡片
  Widget buildCustomCard(
      BuildContext context, String username, ArticleItem? item, int index) {
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
              "name": item?.title,
              "url": "content of some article ${item?.title} "
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
                  // ClipRRect(
                  //     borderRadius:
                  //         const BorderRadius.all(Radius.circular(20.0)),
                  //     child: Image.asset('assets/user.png',
                  //         width: 40, height: 40, fit: BoxFit.cover)),
                  const CircleAvatar(
                    backgroundImage: AssetImage('assets/user.png'),
                    radius: 20.0,
                  ),

                  const SizedBox(width: 8.0),
                  Text(
                    username,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  // const Expanded(child: SizedBox()),
                  Text(
                    item?.niceDate ?? '',
                    style: const TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(width: 8.0),

                  item?.type == 0
                      ? const Text(
                          '置顶',
                          style: TextStyle(color: Colors.blue),
                        )
                      : const SizedBox(),
                ],
              ),
              const SizedBox(height: 8.0),
              Text(
                item?.title ?? '',
                style: const TextStyle(
                    fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8.0),
              Row(
                children: [
                  Text(
                    item?.author ?? item?.shareUser ?? '',
                    style: const TextStyle(color: Colors.grey),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () async { 
                      // 点击事件处理
                      if (item?.collect == true) {
                        await _articleModel.setCollect('${item?.id}', index);
                      } else {
                        await _articleModel.cancelCollect('${item?.id}', index);
                      }
                    },
                    child: Icon(
                      Icons.star,
                      color: item?.collect ?? false
                          ? Colors.black38
                          : Colors.amber,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
