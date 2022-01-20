import 'package:extra_pos/core/routing/binding/home_binding.dart';
import 'package:extra_pos/core/routing/binding/requisition/create_requisition_binding.dart';
import 'package:extra_pos/core/routing/binding/requisition/list_requisition_binding.dart';
import 'package:extra_pos/core/routing/binding/requisition/requisition_home_binding.dart';
import 'package:extra_pos/modules/app_config/presentation/app_url_config/app_url_config_page.dart';
import 'package:extra_pos/modules/auth/presentation/login/login_page.dart';
import 'package:extra_pos/modules/home/presentation/home_page.dart';
import 'package:extra_pos/modules/po_receipts/presentation/create_po_receipt/create_po_receipt_page.dart';
import 'package:extra_pos/modules/po_receipts/presentation/crud_po_receipt_line/crud_po_receipt_line_page.dart';
import 'package:extra_pos/modules/po_receipts/presentation/edit_po_receipt/edit_po_receipt_page.dart';
import 'package:extra_pos/modules/po_receipts/presentation/index/po_receipts_home_page.dart';
import 'package:extra_pos/modules/po_receipts/presentation/list_po_receipt/list_po_receipt_page.dart';
import 'package:extra_pos/modules/po_receipts/presentation/review_po_receipt/review_po_receipt_page.dart';
import 'package:extra_pos/modules/requisition/presentation/create_requisition/create_requisition_page.dart';
import 'package:extra_pos/modules/requisition/presentation/crud_requisition_line/crud_requisition_line_page.dart';
import 'package:extra_pos/modules/requisition/presentation/index/requisition_home_page.dart';
import 'package:extra_pos/modules/requisition/presentation/list_requisition/list_requisition_page.dart';
import 'package:extra_pos/modules/requisition/presentation/review_requisition/review_requisition_page.dart';
import 'package:extra_pos/modules/splash/presentation/splash_screen.dart';
import 'package:get/get.dart';
import 'binding/login_binding.dart';
import 'binding/requisition/crud_line_binding.dart';

abstract class Routes {
  static const initial = '/splash';
  static const login = '/login';
  static const appUrlConfig = '/app-url-config';
  static const home = '/home';
  static const requisitionHome = '/requisition/home';
  static const createRequisition = '/requisition/create';
  static const crudRequisitionItem = '/requisition/part/crud';
  static const listRequisition = '/requisitions/view';
  static const requisitionReview = '/requisitions/review';
  static const poReceiptHome = '/po-receipt/home';
  static const listPoReceipts = '/po-receipts/list';
  static const createPOReceipt = '/po-receipts/create';
  static const crudPoReceiptLineItem = '/po-receipt/line/crud';
  static const requisitionPOReceipt = '/po-receipt/review';
  static const editPOReceipt = '/po-receipt/edit';
}

class AppPages {
  static final pages = [
    GetPage(name: Routes.initial, page: () => SplashScreen()),
    GetPage(
        name: Routes.login, page: () => LoginPage(), binding: LoginBinding()),
    GetPage(name: Routes.appUrlConfig, page: () => AppUrlConfigPage()),
    GetPage(name: Routes.home, page: () => HomePage(), binding: HomeBinding()),
    GetPage(
        name: Routes.requisitionHome,
        page: () => RequisitionHomePage(),
        binding: RequisitionHomeBinding()),
    GetPage(
        name: Routes.createRequisition,
        page: () => CreateRequisitionPage(),
        binding: CreateRequisitionBinding()),
    GetPage(
        name: Routes.crudRequisitionItem,
        page: () => CrudRequisitionLinePage(),
        binding: CreatePartBinding()),
    GetPage(
        name: Routes.listRequisition,
        page: () => ListRequisitionPage(),
        binding: ListRequisitionBinding()),
    GetPage(
        name: Routes.requisitionReview, page: () => RequisitionReviewPage()),
    GetPage(name: Routes.poReceiptHome, page: () => POReceiptsHomePage()),
    GetPage(name: Routes.createPOReceipt, page: () => CreatePOReceiptPage()),
    GetPage(name: Routes.listPoReceipts, page: () => ListPOReceiptPage()),
    GetPage(
        name: Routes.crudPoReceiptLineItem,
        page: () => CrudPOReceiptLinePage()),
    GetPage(
        name: Routes.requisitionPOReceipt, page: () => POReceiptReviewPage()),
    GetPage(name: Routes.editPOReceipt, page: () => EditPOReceiptPage())
  ];
}
