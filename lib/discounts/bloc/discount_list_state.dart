part of 'discount_list_bloc.dart';

enum DiscountListRequestStatus { initial, loading, success, failure }

class DiscountListState extends Equatable {
  const DiscountListState({
    this.status = DiscountListRequestStatus.initial,
    this.discounts = const {},
    this.errorMessage = '',
  });

  final DiscountListRequestStatus status;
  final Map<String, List<Discount>> discounts;
  final String errorMessage;

  DiscountListState copyWith({
    DiscountListRequestStatus? status,
    Map<String, List<Discount>>? discounts,
    String? errorMessage,
  }) {
    return DiscountListState(
      status: status ?? this.status,
      discounts: discounts ?? this.discounts,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object> get props => [status, discounts, errorMessage];
}
