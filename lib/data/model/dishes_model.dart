class DishesModel {
  DishesModel({
    this.restaurantId,
    this.restaurantName,
    this.restaurantImage,
    this.tableId,
    this.tableName,
    this.branchName,
    this.nexturl,
    this.tableMenuList,
  });

  DishesModel.fromJson(dynamic json) {
    json = json[0];
    // print("mmmmmmm" + json.toString());
    restaurantId = json['restaurant_id'];
    restaurantName = json['restaurant_name'];
    restaurantImage = json['restaurant_image'];
    tableId = json['table_id'];
    tableName = json['table_name'];
    branchName = json['branch_name'];
    nexturl = json['nexturl'];
    if (json['table_menu_list'] != null) {
      tableMenuList = [];
      json['table_menu_list'].forEach((v) {
        tableMenuList.add(TableMenuList.fromJson(v));
      });
    }
  }
  String restaurantId;
  String restaurantName;
  String restaurantImage;
  String tableId;
  String tableName;
  String branchName;
  String nexturl;
  List<TableMenuList> tableMenuList;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['restaurant_id'] = restaurantId;
    map['restaurant_name'] = restaurantName;
    map['restaurant_image'] = restaurantImage;
    map['table_id'] = tableId;
    map['table_name'] = tableName;
    map['branch_name'] = branchName;
    map['nexturl'] = nexturl;
    if (tableMenuList != null) {
      map['table_menu_list'] = tableMenuList.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class TableMenuList {
  TableMenuList({
    this.menuCategory,
    this.menuCategoryId,
    this.menuCategoryImage,
    this.nexturl,
    this.categoryDishes,
  });

  TableMenuList.fromJson(dynamic json) {
    menuCategory = json['menu_category'];
    menuCategoryId = json['menu_category_id'];
    menuCategoryImage = json['menu_category_image'];
    nexturl = json['nexturl'];
    if (json['category_dishes'] != null) {
      categoryDishes = [];
      json['category_dishes'].forEach((v) {
        categoryDishes.add(CategoryDishes.fromJson(v));
      });
    }
  }
  String menuCategory;
  String menuCategoryId;
  String menuCategoryImage;
  String nexturl;
  List<CategoryDishes> categoryDishes;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['menu_category'] = menuCategory;
    map['menu_category_id'] = menuCategoryId;
    map['menu_category_image'] = menuCategoryImage;
    map['nexturl'] = nexturl;
    if (categoryDishes != null) {
      map['category_dishes'] = categoryDishes.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class CategoryDishes {
  CategoryDishes({
    this.dishId,
    this.dishName,
    this.dishPrice,
    this.dishImage,
    this.dishCurrency,
    this.dishCalories,
    this.dishDescription,
    this.dishAvailability,
    this.dishType,
    this.nexturl,
    this.addonCat,
  });

  CategoryDishes.fromJson(dynamic json) {
    dishId = json['dish_id'];
    dishName = json['dish_name'];
    dishPrice = json['dish_price'];
    dishImage = json['dish_image'];
    dishCurrency = json['dish_currency'];
    dishCalories = json['dish_calories'];
    dishDescription = json['dish_description'];
    dishAvailability = json['dish_Availability'];
    dishType = json['dish_Type'];
    nexturl = json['nexturl'];
    if (json['addonCat'] != null) {
      addonCat = [];
      json['addonCat'].forEach((v) {
        addonCat.add(AddonCat.fromJson(v));
      });
    }
  }
  String dishId;
  String dishName;
  double dishPrice;
  String dishImage;
  String dishCurrency;
  double dishCalories;
  String dishDescription;
  bool dishAvailability;
  int dishType;
  String nexturl;
  int quantity = 0;
  List<AddonCat> addonCat;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['dish_id'] = dishId;
    map['dish_name'] = dishName;
    map['dish_price'] = dishPrice;
    map['dish_image'] = dishImage;
    map['dish_currency'] = dishCurrency;
    map['dish_calories'] = dishCalories;
    map['dish_description'] = dishDescription;
    map['dish_Availability'] = dishAvailability;
    map['dish_Type'] = dishType;
    map['nexturl'] = nexturl;
    if (addonCat != null) {
      map['addonCat'] = addonCat.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class AddonCat {
  AddonCat({
    this.addonCategory,
    this.addonCategoryId,
    this.addonSelection,
    this.nexturl,
    this.addons,
  });

  AddonCat.fromJson(dynamic json) {
    addonCategory = json['addon_category'];
    addonCategoryId = json['addon_category_id'];
    addonSelection = json['addon_selection'];
    nexturl = json['nexturl'];
    if (json['addons'] != null) {
      addons = [];
      json['addons'].forEach((v) {
        addons.add(Addons.fromJson(v));
      });
    }
  }
  String addonCategory;
  String addonCategoryId;
  int addonSelection;
  String nexturl;
  List<Addons> addons;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['addon_category'] = addonCategory;
    map['addon_category_id'] = addonCategoryId;
    map['addon_selection'] = addonSelection;
    map['nexturl'] = nexturl;
    if (addons != null) {
      map['addons'] = addons.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Addons {
  Addons({
    this.dishId,
    this.dishName,
    this.dishPrice,
    this.dishImage,
    this.dishCurrency,
    this.dishCalories,
    this.dishDescription,
    this.dishAvailability,
    this.dishType,
  });

  Addons.fromJson(dynamic json) {
    dishId = json['dish_id'];
    dishName = json['dish_name'];
    dishPrice = json['dish_price'];
    dishImage = json['dish_image'];
    dishCurrency = json['dish_currency'];
    dishCalories = json['dish_calories'];
    dishDescription = json['dish_description'];
    dishAvailability = json['dish_Availability'];
    dishType = json['dish_Type'];
  }
  String dishId;
  String dishName;
  double dishPrice;
  String dishImage;
  String dishCurrency;
  double dishCalories;
  String dishDescription;
  bool dishAvailability;
  int dishType;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['dish_id'] = dishId;
    map['dish_name'] = dishName;
    map['dish_price'] = dishPrice;
    map['dish_image'] = dishImage;
    map['dish_currency'] = dishCurrency;
    map['dish_calories'] = dishCalories;
    map['dish_description'] = dishDescription;
    map['dish_Availability'] = dishAvailability;
    map['dish_Type'] = dishType;
    return map;
  }
}
