import 'package:beautiful_life/app_theme.dart';
import 'package:beautiful_life/find_fun/components/home_things_card_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'homelist.dart';
import 'components/floating_action_menu.dart';
import 'components/bottom_action_bar.dart';
import 'package:http/http.dart' as http;
import 'api_client.dart';
import 'find_fun/models/funnythings_model.dart';
import 'home_list_card_view.dart';
import 'components/error_placeholder.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  late Future<List<FunnyThingsModel>> _todosFuture;

  List<HomeList> homeList = HomeList.homeList;
  List<FunnyThingsModel> funnyThingsModel = [];
  AnimationController? animationController;
  bool multiple = true;
  late PageController pageController;

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    pageController = PageController(
      viewportFraction: 0.85,
      initialPage: homeList.length * 1000,
    );
    getData();
    super.initState();
  }

  Future<bool> getData() async {
    _todosFuture = ApiClient.getTodos()
    .then((todos) => todos.map((todo) => FunnyThingsModel.fromJson(todo)).toList())
    .then((processedTodos) {
      print('获取到的Todos数据: $processedTodos');
      funnyThingsModel = processedTodos;
      return processedTodos;
    })
    .catchError((error) {
      print('获取Todos时发生错误: $error');
      return <FunnyThingsModel>[];  // 发生错误时返回空列表
    });
    return true;
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isLightMode = brightness == Brightness.light;
    return Scaffold(
      backgroundColor:
          isLightMode == true ? AppTheme.white : AppTheme.nearlyBlack,
      bottomNavigationBar: BottomActionBar(
        items: homeList.map((item) => FloatingActionMenuItem(
          icon: SvgPicture.asset(
            'assets/lifeicons/icon_suijiyige.svg',
            color: isLightMode ? const Color.fromARGB(255, 7, 241, 241) : AppTheme.white,
            height: 24,
          ),
          label: '分享',
          color: Colors.grey.withAlpha(00),
          onPressed: () {
            print('分享');
            getData();
          },
          )
        ).toList(),
        bgColor: isLightMode ? Colors.white : AppTheme.nearlyBlack,
      ),
      body: FutureBuilder<bool>(
        future: getData(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.hasError) {
            return ErrorPlaceholder(
              type: ErrorType.network,
              onRetry: () => getData().then((_) => setState(() {})),
            );
          } else if (!snapshot.hasData) {
            return const ErrorPlaceholder(type: ErrorType.noData);
          } else {
            return Padding(
              padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  appBar(),
                  Expanded(
                    child: FutureBuilder<bool>(
                      future: getData(),
                      builder:
                          (BuildContext context, AsyncSnapshot<bool> snapshot) {
                        if (!snapshot.hasData) {
                          return const SizedBox();
                        } else {
                          return AnimatedSwitcher(
                            duration: Duration(milliseconds: 500),
                            child: multiple
                                ? GridView(
                                    padding: const EdgeInsets.only(top: 0, left: 12, right: 12),
                                    physics: const BouncingScrollPhysics(),
                                    scrollDirection: Axis.vertical,
                                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      mainAxisSpacing: 12.0,
                                      crossAxisSpacing: 12.0,
                                      childAspectRatio: MediaQuery.of(context).size.width / MediaQuery.of(context).size.height,
                                    ),
                                    children: List<Widget>.generate(
                                      homeList.length,
                                      (int index) {
                                        final int count = homeList.length;
                                        final Animation<double> animation =
                                            Tween<double>(begin: 0.0, end: 1.0).animate(
                                          CurvedAnimation(
                                            parent: animationController!,
                                            curve: Interval((1 / count) * index, 1.0,
                                                curve: Curves.fastOutSlowIn),
                                          ),
                                        );
                                        animationController?.forward();
                                        return Padding(
                                          padding: EdgeInsets.symmetric(horizontal: multiple ? 0 : MediaQuery.of(context).size.width * 0.05),
                                          child: HomeListView(
                                            animation: animation,
                                            animationController: animationController,
                                            listData: homeList[index],
                                            callBack: () {
                                              Navigator.push<dynamic>(
                                              context,
                                              MaterialPageRoute<dynamic>(
                                                builder: (BuildContext context) =>
                                                homeList[index].navigateScreen!,
                                              ),
                                              );
                                            },
                                          ),
                                        );
                                      },
                                    ),
                                  )
                                : PageView.builder(
                                    controller: pageController,
                                    itemCount: 100000,
                                    itemBuilder: (context, index) {
                                      final screenWidth = MediaQuery.of(context).size.width;
                                      final itemIndex = index % homeList.length;
                                      return AnimatedBuilder(
                                        animation: animationController!,
                                        builder: (BuildContext context, Widget? child) {
                                          return Padding(
                                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                                            child: HomeThingsCardView(
                                              animation: animationController!,
                                              animationController: animationController,
                                              data: funnyThingsModel[itemIndex],
                                              callBack: () {
                                                Navigator.push<dynamic>(
                                                  context,
                                                  MaterialPageRoute<dynamic>(
                                                    builder: (BuildContext context) =>
                                                      homeList[itemIndex].navigateScreen!,
                                                  ),
                                                );
                                              },
                                            )
                                            
      
                                            // HomeListView(
                                            //   animation: Tween<double>(begin: 0.0, end: 1.0)
                                            //     .animate(animationController!),
                                            //   animationController: animationController,
                                            //   listData: homeList[itemIndex],
                                            //   callBack: () {
                                            //     Navigator.push<dynamic>(
                                            //      context,
                                            //      MaterialPageRoute<dynamic>(
                                            //         builder: (BuildContext context) =>
                                            //           homeList[itemIndex].navigateScreen!,
                                            //       ),
                                            //     );
                                            //   },
                                            // )
                                          );
                                        },
                                      );
                                    },
                                  ),
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  Widget appBar() {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isLightMode = brightness == Brightness.light;
    return SizedBox(
      height: AppBar().preferredSize.height,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 8, left: 8),
            child: Container(
              width: AppBar().preferredSize.height - 8,
              height: AppBar().preferredSize.height - 8,
            ),
          ),
          Expanded(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  '美丽时光',
                  style: TextStyle(
                    fontSize: 22,
                    color: isLightMode ? AppTheme.darkText : AppTheme.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8, right: 8),
            child: Container(
              width: AppBar().preferredSize.height - 8,
              height: AppBar().preferredSize.height - 8,
              color: isLightMode ? Colors.white : AppTheme.nearlyBlack,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius:
                      BorderRadius.circular(AppBar().preferredSize.height),
                  child: Icon(
                    multiple ? Icons.dashboard : Icons.view_agenda,
                    color: isLightMode ? AppTheme.dark_grey : AppTheme.white,
                  ),
                  onTap: () {
                    setState(() {
                      multiple = !multiple;
                    });
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}