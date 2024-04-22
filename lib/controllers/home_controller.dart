
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import '../models/random_user_res_list.dart';
import '../service/http_service.dart';

class HomeController extends GetxController{
  ScrollController scrollController=ScrollController();
  bool isLoading = true;

  List<RandomUser> userList = [];
  int currentPage = 1;

  initScrollListener(){
    scrollController.addListener(() {
      if(scrollController.position.maxScrollExtent<= scrollController.offset){
        loadRandomUserList();
      }
    });
  }

  loadRandomUserList() async{
    isLoading = true;

    update();

    var response = await Network.GET(Network.API_RANDOM_USER_LIST, Network.paramsRandomUserList(currentPage));
    var randomUserListRes = Network.parseRandomUserList(response!);
    currentPage=randomUserListRes.info.page+1;

    userList.addAll(randomUserListRes.results);
    isLoading = false;

    update();
  }

}