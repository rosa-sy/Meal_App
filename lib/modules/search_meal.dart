class SearchMeal {
  final String idMeal; 
  final String strMeal;
  final String strMealThumb;
  final String strCategory;
  final String strArea;

  SearchMeal({
    required this.idMeal,
    required this.strMeal,
    required this.strMealThumb,
    required this.strCategory,
    required this.strArea,
  });

  factory SearchMeal.fromJson(Map<String, dynamic> json) {
    return SearchMeal(
      idMeal: json['idMeal'],
      strMeal: json['strMeal'],
      strMealThumb: json['strMealThumb'],
      strCategory: json['strCategory'],
      strArea: json['strArea'],
    );
  }
}