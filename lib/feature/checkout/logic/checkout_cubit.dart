import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:minamitra_pembudidaya_mobile/core/exceptions/app_exceptions.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/bank/bank_service.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/delivery_address/delivery_address_service.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/transaction/transaction_service.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_assets.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_global_state.dart';
import 'package:minamitra_pembudidaya_mobile/feature/address_member/repositories/member_address_response.dart';
import 'package:minamitra_pembudidaya_mobile/feature/checkout/repositories/checkout_body.dart';
import 'package:minamitra_pembudidaya_mobile/feature/checkout/repositories/selected_payment.dart';
import 'package:minamitra_pembudidaya_mobile/feature/products/repositories/products_response.dart';

part 'checkout_state.dart';

class CheckoutCubit extends Cubit<CheckoutState> {
  CheckoutCubit(
    this.deliveryAddressService,
    this.bankService,
    this.transactionService,
  ) : super(const CheckoutState());

  final DeliveryAddressService deliveryAddressService;
  final BankService bankService;
  final TransactionService transactionService;

  Future<void> init(ProductsResponseData initData) async {
    emit(state.copyWith(status: GlobalState.loading));
    try {
      final devliveryAddressData = await deliveryAddressService.getAddresses();
      final banks = await bankService.getBanks();
      final List<SelectedPayment> recommedationPayment = [
        const SelectedPayment(
          id: '0',
          imageAsset: AppAssets.cashSquareIcon,
          name: 'Tunai',
          paymentMethod: 'Tunai',
          description: 'Bayar menggunakan uang tunai',
        ),
      ];
      final List<SelectedPayment> bankData = banks.data.data
              ?.map((element) => element.convertToSelectedPayment())
              .toList() ??
          [];
      MemberAddressResponseData? findPrimaryAddress =
          devliveryAddressData.data.data?.firstWhere(
        (element) => element.isPrimaryBool == true,
        orElse: () => MemberAddressResponseData(),
      );
      onAddedProduct(initData);
      emit(
        state.copyWith(
          status: GlobalState.loaded,
          addressData: devliveryAddressData.data.data ?? [],
          bankData: bankData,
          recommendationsPaymentData: recommedationPayment,
          selectedAddress:
              (findPrimaryAddress?.id == null) ? null : findPrimaryAddress,
        ),
      );
    } on AppException catch (e) {
      emit(
        state.copyWith(
          status: GlobalState.error,
          errorMessage: e.message,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: GlobalState.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  void onChangeSelectedAddress(
    MemberAddressResponseData address,
  ) {
    emit(state.copyWith(selectedAddress: address));
  }

  void onChangeSelectedPayment(
    SelectedPayment payment,
  ) {
    emit(state.copyWith(selectedPayment: payment));
  }

  void onAddedProduct(ProductsResponseData data) async {
    List<ProductsResponseData> listProduct = state.listProduct;
    listProduct = [...listProduct, data];
    emit(state.copyWith(listProduct: listProduct));
    recalculatedTotal();
  }

  void onIncreamentItem(int index) {
    emit(state.copyWith(status: GlobalState.onUpdating));
    final List<ProductsResponseData> listProduct = state.listProduct;
    listProduct[index] = listProduct[index].copyWith(
      quantity: (listProduct[index].quantity ?? 0) + 1,
    );
    recalculatedTotal();
    emit(state.copyWith(listProduct: listProduct, status: GlobalState.loaded));
  }

  void onDecreamentItem(int index) {
    emit(state.copyWith(status: GlobalState.onUpdating));
    final List<ProductsResponseData> listProduct = state.listProduct;
    listProduct[index] = listProduct[index].copyWith(
      quantity: (listProduct[index].quantity ?? 0) - 1,
    );
    recalculatedTotal();
    emit(state.copyWith(listProduct: listProduct, status: GlobalState.loaded));
  }

  void onRemoveItem(int index) {
    emit(state.copyWith(status: GlobalState.onUpdating));
    final List<ProductsResponseData> listProduct = state.listProduct;
    listProduct.removeAt(index);
    recalculatedTotal();
    emit(state.copyWith(listProduct: listProduct, status: GlobalState.loaded));
  }

  void recalculatedTotal() {
    emit(state.copyWith(status: GlobalState.onUpdating));
    final List<ProductsResponseData> listProduct = state.listProduct;
    final total = listProduct.fold(
      0.0,
      (previousValue, element) =>
          previousValue +
          (double.parse(element.sellPrice ?? '0') * (element.quantity ?? 0)),
    );
    emit(state.copyWith(totalItemPrice: total, status: GlobalState.loaded));
  }

  Future<void> processCheckout() async {
    emit(state.copyWith(status: GlobalState.showDialogLoading));
    try {
      final CheckoutBody body = CheckoutBody(
        deliveryAddressId: int.parse(state.selectedAddress?.id ?? '0'),
        totalItemPrice: state.totalItemPrice,
        serviceCostJsonArray: [],
        totalServiceCost: 0,
        discountJsonArray: [],
        totalDiscount: 0,
        grandTotal: state.totalItemPrice,
        paymentMethod: state.selectedPayment?.paymentMethod,
        paymentTransferBankId: int.parse(state.selectedPayment?.id ?? '0'),
        itemsJsonArray: state.listProduct
            .map(
              (e) => ItemsJsonArray(
                id: 0,
                itemId: int.parse(e.id ?? '0'),
                itemName: e.name,
                qty: e.quantity,
                sellPrice: int.parse(e.sellPrice ?? '0'),
              ),
            )
            .toList(),
      );
      await transactionService.checkout(body: body);
      emit(state.copyWith(status: GlobalState.hideDialogLoading));
      emit(state.copyWith(status: GlobalState.successSubmit));
    } on AppException catch (e) {
      emit(state.copyWith(status: GlobalState.hideDialogLoading));
      emit(
        state.copyWith(
          status: GlobalState.error,
          errorMessage: e.message,
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: GlobalState.hideDialogLoading));
      emit(
        state.copyWith(
          status: GlobalState.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
