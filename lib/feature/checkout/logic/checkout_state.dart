part of 'checkout_cubit.dart';

class CheckoutState extends Equatable {
  const CheckoutState({
    this.status = GlobalState.initial,
    this.errorMessage = '',
    this.addressData = const [],
    this.bankData = const [],
    this.recommendationsPaymentData = const [],
    this.selectedAddress,
    this.selectedPayment,
    this.listProduct = const [],
    this.totalItemPrice = 0,
  });

  final GlobalState status;
  final String errorMessage;
  final List<MemberAddressResponseData> addressData;
  final List<SelectedPayment> bankData;
  final List<SelectedPayment> recommendationsPaymentData;
  final MemberAddressResponseData? selectedAddress;
  final SelectedPayment? selectedPayment;
  final List<ProductsResponseData> listProduct;
  final double totalItemPrice;

  CheckoutState copyWith({
    GlobalState? status,
    String? errorMessage,
    List<MemberAddressResponseData>? addressData,
    List<SelectedPayment>? bankData,
    List<SelectedPayment>? recommendationsPaymentData,
    MemberAddressResponseData? selectedAddress,
    SelectedPayment? selectedPayment,
    List<ProductsResponseData>? listProduct,
    double? totalItemPrice,
  }) {
    return CheckoutState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      addressData: addressData ?? this.addressData,
      bankData: bankData ?? this.bankData,
      recommendationsPaymentData:
          recommendationsPaymentData ?? this.recommendationsPaymentData,
      selectedAddress: selectedAddress ?? this.selectedAddress,
      selectedPayment: selectedPayment ?? this.selectedPayment,
      listProduct: listProduct ?? this.listProduct,
      totalItemPrice: totalItemPrice ?? this.totalItemPrice,
    );
  }

  @override
  List<Object?> get props => [
        status,
        errorMessage,
        addressData,
        bankData,
        recommendationsPaymentData,
        selectedAddress,
        selectedPayment,
        listProduct,
        totalItemPrice,
      ];
}
