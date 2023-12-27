import 'package:woocommerce_api/woocommerce_api.dart';

class WooCommerceAPIHandler {
  final WooCommerceAPI wooCommerceAPI;

  WooCommerceAPIHandler()
      : wooCommerceAPI = WooCommerceAPI(
          url: 'http://143.1.1.253/ecommerce',
          consumerKey: 'ck_af2edc467cb27d9a8234c621db2d20a9aed98aab',
          consumerSecret: 'cs_bc506ee8513fbaed38ca161bcb7d601e1189935a',
        );
}
