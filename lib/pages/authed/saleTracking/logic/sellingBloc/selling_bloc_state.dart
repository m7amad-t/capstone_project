part of 'selling_bloc_bloc.dart';

sealed class SellingBlocState extends Equatable {
  const SellingBlocState();
  
  @override
  List<Object> get props => [];
}

final class LoadingProductSellingRecords extends SellingBlocState {
}

final class FailedToLoadSellignRecords extends SellingBlocState {
}


final class GotSellingProductsRecords extends SellingBlocState {

  final List<InvoiceModel> records ;
  final bool isEnd ; 
  final DateTime? start;
  final DateTime? end;
  const GotSellingProductsRecords({required this.records , required this.isEnd , this.end , this.start, }); 

  @override
  List<Object> get props => [records , isEnd , start ?? [] , end?? []];

}
