import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class CategoriesRevenueModel extends Equatable{
  
  final List<CategoryRevenueModel> categories;
  final DateTimeRange range; 
  final double totalRevenue ; 

  const CategoriesRevenueModel({required this.categories  , required this.totalRevenue ,required this.range}); 
  @override
  List<Object?> get props => [categories , range , totalRevenue]; 

  factory CategoriesRevenueModel.fromJson(Map<String , dynamic>data){
    DateTime start = DateTime.parse(data["startDate"]); 
    DateTime end = DateTime.parse(data["endDate"]); 

    
    
    List<CategoryRevenueModel> result =[];

    for(final record in data['categories']){
      result.add(CategoryRevenueModel.formJson(record));
    } 
    return CategoriesRevenueModel(
      categories: result,
      range: DateTimeRange(start: start, end: end), 
      totalRevenue: data['totalRevenue'],
    );
  }


}

class CategoryRevenueModel extends Equatable{

  final String name ; 
  final double revenue;
  final int id;

  const CategoryRevenueModel({required this.name, required this.revenue, required this.id}); 

  @override
  List<Object?> get props => [name , revenue, id]; 

  
  factory CategoryRevenueModel.formJson(Map<String , dynamic> data){
    return CategoryRevenueModel(
      id: data['id'],
      name: data['name'], 
      revenue: data['revenue'], 
    ); 

  }


}




