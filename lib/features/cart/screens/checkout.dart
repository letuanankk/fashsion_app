import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_shop_app/common/widgets/button/basic_app_button.dart';
import 'package:my_shop_app/features/cart/controller/cart_controller.dart';
import '/../../common/helper/cart/cart.dart';
import '/../../data/order/models/order_registration_req.dart';
import 'order_placed.dart';
import 'package:flutter/material.dart';
import '../../../common/helper/navigator/app_navigator.dart';
import '../../../common/widgets/appbar/app_bar.dart';
import '../../../data/order/entities/product_ordered.dart';

class CheckOutPage extends ConsumerWidget {
  final List<ProductOrderedEntity> products;
  CheckOutPage({required this.products, super.key});

  final TextEditingController _addressCon = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: const BasicAppbar(title: Text('Checkout')),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Builder(
            builder: (context) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _addressField(context),
                  BasicAppButton(
                    content: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '\$${CartHelper.calculateCartSubtotal(products)}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const Text(
                            'Place Order',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        ref
                            .read(cartControllerProvider)
                            .orderRegistration(
                              OrderRegistrationReq(
                                products: products,
                                createdDate: DateTime.now().toString(),
                                itemCount: products.length,
                                totalPrice: CartHelper.calculateCartSubtotal(
                                  products,
                                ),
                                shippingAddress: _addressCon.text,
                                code: '',
                                orderStatus: [],
                              ),
                            );
                        AppNavigator.push(context, const OrderPlacedPage());
                      }
                    },
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _addressField(BuildContext context) {
    return TextFormField(
      controller: _addressCon,
      minLines: 2,
      maxLines: 4,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your address';
        }
        return null;
      },
      decoration: const InputDecoration(hintText: 'Shipping Address'),
    );
  }
}
