import 'package:flutter/material.dart';
import 'package:flutter_app_sale_06072022/common/bases/base_widget.dart';
import 'package:flutter_app_sale_06072022/data/model/product.dart';
import 'package:flutter_app_sale_06072022/data/repositories/product_repository.dart';
import 'package:flutter_app_sale_06072022/presentation/features/home/home_bloc.dart';
import 'package:flutter_app_sale_06072022/presentation/features/home/home_event.dart';
import 'package:flutter_app_sale_06072022/presentation/features/item/item_page.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../common/constants/api_constant.dart';
import '../../../common/constants/variable_constant.dart';
import '../../../common/utils/extension.dart';
import '../../../data/datasources/remote/api_request.dart';
import '../profile/profile.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return PageContainer(
      appBar: AppBar(
        title: const Text("Foods near you"),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.account_circle_rounded),
            tooltip: 'My Profile',
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ProfilePage()));
            },
          ),
        ],
      ),
      providers: [
        Provider(create: (context) => ApiRequest()),
        ProxyProvider<ApiRequest, ProductRepository>(
          update: (context, request, repository) {
            repository?.updateRequest(request);
            return repository ?? ProductRepository()
              ..updateRequest(request);
          },
        ),
        ProxyProvider<ProductRepository, HomeBloc>(
          update: (context, repository, bloc) {
            bloc?.updateProductRepository(repository);
            return bloc ?? HomeBloc()
              ..updateProductRepository(repository);
          },
        ),
      ],
      child: HomeContainer(),
    );
  }
}

class HomeContainer extends StatefulWidget {
  const HomeContainer({Key? key}) : super(key: key);

  @override
  State<HomeContainer> createState() => _HomeContainerState();
}

class _HomeContainerState extends State<HomeContainer> {
  late HomeBloc _homeBloc;

  @override
  void initState() {
    super.initState();
    _homeBloc = context.read<HomeBloc>();
    _homeBloc.eventSink.add(GetListProductEvent());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
      child: Stack(
        children: [
          StreamBuilder<List<Product>>(
              initialData: const [],
              stream: _homeBloc.listProductController.stream,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Container(
                    child: Center(child: Text("Data error")),
                  );
                }
                if (snapshot.hasData && snapshot.data == []) {
                  return Container();
                }
                return ListView.builder(
                    itemCount: snapshot.data?.length ?? 0,
                    itemBuilder: (context, index) {
                      return _buildItemFood(snapshot.data?[index]);
                    });
              })
        ],
      ),
    ));
  }

  Widget _buildItemFood(Product? product) {
    if (product == null) return Container();
    return SizedBox(
      height: 135,
      child: Card(
        elevation: 5,
        shadowColor: Color.fromARGB(255, 181, 194, 200),
        child: Container(
          padding: const EdgeInsets.only(top: 8, bottom: 8, left: 8),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(ApiConstant.BASE_URL + product.img,
                    width: 150, height: 120, fit: BoxFit.fill),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Text(product.name.toString(),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontSize: 16)),
                      ),
                      Text(
                          "Giá : ${NumberFormat("#,###", "en_US").format(product.price)} đ",
                          style: const TextStyle(fontSize: 12)),
                      Row(children: [
                        ElevatedButton(
                          onPressed: () {},
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.resolveWith((states) {
                                if (states.contains(MaterialState.pressed)) {
                                  return const Color.fromARGB(
                                      200, 240, 102, 61);
                                } else {
                                  return const Color.fromARGB(
                                      230, 240, 102, 61);
                                }
                              }),
                              shape: MaterialStateProperty.all(
                                  const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(4))))),
                          child: const Text("Thêm vào giỏ",
                              style: TextStyle(fontSize: 14)),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ItemDetails()));
                            },
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.resolveWith((states) {
                                  if (states.contains(MaterialState.pressed)) {
                                    return Color.fromARGB(255, 188, 188, 188);
                                  } else {
                                    return Color.fromARGB(230, 255, 255, 255);
                                  }
                                }),
                                shape: MaterialStateProperty.all(
                                    const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(4))))),
                            child: Text("Chi tiết",
                                style: const TextStyle(
                                    fontSize: 14, color: Colors.black)),
                          ),
                        ),
                      ]),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
