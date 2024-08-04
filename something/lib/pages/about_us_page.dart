import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:something/route/router_util.dart';

class AboutUsPage extends StatefulWidget {
  const AboutUsPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _AboutUsState();
  }
}

class _AboutUsState extends State<AboutUsPage> {
  String? _version;
  @override
  void initState() {
    super.initState();
    getVersion();
  }

  Future<void> getVersion() async {
    var info = await PackageInfo.fromPlatform();
    setState(() {
      print('信息;$info');
      _version = info.version;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('关于我们'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const Icon(
              Icons.info_outlined,
              size: 40,
              color: Colors.amber,
            ),
            Text('v$_version'),
            _content(),
          ],
        ),
      ),
    );
  }

  Widget _content() {
    final htmlContent = r'''<![CDATA[
        <h2>网站内容</h2>
        <p>本网站每天新增20~30篇优质文章，并加入到现有分类中，力求整理出一份优质而又详尽的知识体系，闲暇时间不妨上来学习下知识；除此以外，并为大家提供平时开发过程中常用的工具以及常用的网址导航。</p>
        <p>当然这只是我们目前的功能，未来我们将提供更多更加便捷的功能…</p>
        <p>如果您有任何好的建议：</p>
            <br/>关于网站排版
            <br/>关于新增常用网址以及工具
            <br/>未来你希望增加的功能等
        <p>可以在 <a href="https://github.com/hongyangAndroid/wanandroid" target="_blank">https://github.com/hongyangAndroid/xueandroid</a> 项目中以issue的形式提出，我将及时跟进。</p>
        <p>如果您希望长期关注本站，可以加入我们的QQ群：<b>591683946</b></p>
        <h2>源码位置</h2>
        <p>本软件开源，如果你发现任何错误，不要犹豫，马上点击<a href="https://github.com/wangzailfm/wanandroidclient" target="_blank">GitHub</a>，在上面发起<b>issue</b>或者提交<b>pull request</b>。</p>
    ]]>''';

    return Html(
      data: htmlContent,
      onLinkTap: (url, attributes, element) => {
        // RouterUtils.push(context, WebViewPage())
        print(url)
      },
    );
  }
}
