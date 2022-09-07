import 'package:flutter/material.dart';
import 'package:flutter_app_sale_06072022/common/bases/base_widget.dart';
import 'package:flutter_app_sale_06072022/data/repositories/product_repository.dart';
import 'package:flutter_app_sale_06072022/presentation/features/home/home_bloc.dart';
import 'package:flutter_app_sale_06072022/presentation/features/home/home_event.dart';
import 'package:provider/provider.dart';

import '../../../data/datasources/remote/api_request.dart';
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
        title: const Text("Home"),
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
    return Container();
  }

  // Widget _buildItemFood() {
  //   if (product == null) return Container();
  //   return Container(
  //     height: 135,
  //     child: Card(
  //       elevation: 5,
  //       shadowColor: Colors.blueGrey,
  //       child: Container(
  //         padding: EdgeInsets.only(top: 5, bottom: 5),
  //         child: Row(
  //           children: [
  //             ClipRRect(
  //               borderRadius: BorderRadius.circular(5),
  //               child: Image.network(ApiConstant.BASE_URL + product.img,
  //                   width: 150, height: 120, fit: BoxFit.fill),
  //             ),
  //             Expanded(
  //               child: Padding(
  //                 padding: const EdgeInsets.only(left: 5),
  //                 child: Column(
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                   children: [
  //                     Padding(
  //                       padding: const EdgeInsets.only(top: 5),
  //                       child: Text(product.name.toString(),
  //                           maxLines: 1,
  //                           overflow: TextOverflow.ellipsis,
  //                           style: TextStyle(fontSize: 16)),
  //                     ),
  //                     Text(
  //                         "Giá : " +
  //                             NumberFormat("#,###", "en_US")
  //                                 .format(product.price) +
  //                             " đ",
  //                         style: TextStyle(fontSize: 12)),
  //                     Row(
  //                         children:[
  //                           ElevatedButton(
  //                             onPressed: () {
  //
  //                             },
  //                             style: ButtonStyle(
  //                                 backgroundColor:
  //                                 MaterialStateProperty.resolveWith((states) {
  //                                   if (states.contains(MaterialState.pressed)) {
  //                                     return Color.fromARGB(200, 240, 102, 61);
  //                                   } else {
  //                                     return Color.fromARGB(230, 240, 102, 61);
  //                                   }
  //                                 }),
  //                                 shape: MaterialStateProperty.all(
  //                                     RoundedRectangleBorder(
  //                                         borderRadius: BorderRadius.all(
  //                                             Radius.circular(10))))),
  //                             child:
  //                             Text("Thêm vào giỏ", style: TextStyle(fontSize: 14)),
  //                           ),
  //                           Padding(
  //                             padding: EdgeInsets.only(left: 5),
  //                             child: ElevatedButton(
  //                               onPressed: () {
  //                                 Navigator.pushNamed(
  //                                     context,
  //                                     "/product-detail",
  //                                     arguments:{"product": product}
  //                                 );
  //                               },
  //                               style: ButtonStyle(
  //                                   backgroundColor:
  //                                   MaterialStateProperty.resolveWith((states) {
  //                                     if (states.contains(MaterialState.pressed)) {
  //                                       return Color.fromARGB(200, 11, 22, 142);
  //                                     } else {
  //                                       return Color.fromARGB(230, 11, 22, 142);
  //                                     }
  //                                   }),
  //                                   shape: MaterialStateProperty.all(
  //                                       RoundedRectangleBorder(
  //                                           borderRadius: BorderRadius.all(
  //                                               Radius.circular(10))))),
  //                               child:
  //                               Text("Chi tiết", style: TextStyle(fontSize: 14)),
  //                             ),
  //                           ),
  //                         ]
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }
}

