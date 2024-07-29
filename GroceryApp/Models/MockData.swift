////
////  MockData.swift
////  GroceryApp
////
////  Created by Oğuzhan Bolat on 29.07.2024.
////
//
//import Foundation

//// Dairy and Eggs
//let dairyAndEggsProducts: [GroceryProducts] = [
//    GroceryProducts(
//        name: "Whole Milk",
//        title: "1L, Priceg",
//        imageName: "milk",
//        price: "$1.99",
//        details: "Whole milk provides a good source of calcium and vitamin D.",
//        nutrition: [
//            NutritionInfo(label: "Calories:", value: "61 kcal"),
//            NutritionInfo(label: "Carbohydrates:", value: "5 g"),
//            NutritionInfo(label: "Protein:", value: "3.2 g"),
//            NutritionInfo(label: "Fat:", value: "3.3 g"),
//            NutritionInfo(label: "Fiber:", value: "0 g"),
//            NutritionInfo(label: "Sugar:", value: "5 g")
//        ]
//    ),
//    GroceryProducts(
//        name: "Cheddar Cheese",
//        title: "200g, Priceg",
//        imageName: "cheddar",
//        price: "$4.49",
//        details: "Cheddar cheese is rich in protein and calcium, and has a sharp flavor.",
//        nutrition: [
//            NutritionInfo(label: "Calories:", value: "402 kcal"),
//            NutritionInfo(label: "Carbohydrates:", value: "1.3 g"),
//            NutritionInfo(label: "Protein:", value: "24.9 g"),
//            NutritionInfo(label: "Fat:", value: "33.3 g"),
//            NutritionInfo(label: "Fiber:", value: "0 g"),
//            NutritionInfo(label: "Sugar:", value: "0.5 g")
//        ]
//    ),
//    GroceryProducts(
//        name: "Greek Yogurt",
//        title: "500g, Priceg",
//        imageName: "greek_yogurt",
//        price: "$3.99",
//        details: "Greek yogurt is rich in protein and probiotics, which are beneficial for digestion.",
//        nutrition: [
//            NutritionInfo(label: "Calories:", value: "59 kcal"),
//            NutritionInfo(label: "Carbohydrates:", value: "3.6 g"),
//            NutritionInfo(label: "Protein:", value: "10.3 g"),
//            NutritionInfo(label: "Fat:", value: "0.4 g"),
//            NutritionInfo(label: "Fiber:", value: "0 g"),
//            NutritionInfo(label: "Sugar:", value: "3.6 g")
//        ]
//    ),
//    GroceryProducts(
//        name: "Eggs",
//        title: "12 pcs, Priceg",
//        imageName: "eggs",
//        price: "$2.99",
//        details: "Eggs are a versatile source of high-quality protein and essential nutrients.",
//        nutrition: [
//            NutritionInfo(label: "Calories:", value: "155 kcal"),
//            NutritionInfo(label: "Carbohydrates:", value: "1.1 g"),
//            NutritionInfo(label: "Protein:", value: "13 g"),
//            NutritionInfo(label: "Fat:", value: "11 g"),
//            NutritionInfo(label: "Fiber:", value: "0 g"),
//            NutritionInfo(label: "Sugar:", value: "1.1 g")
//        ]
//    ),
//    GroceryProducts(
//        name: "Butter",
//        title: "250g, Priceg",
//        imageName: "butter",
//        price: "$3.29",
//        details: "Butter is used in cooking and baking and adds a rich, creamy flavor.",
//        nutrition: [
//            NutritionInfo(label: "Calories:", value: "717 kcal"),
//            NutritionInfo(label: "Carbohydrates:", value: "0.1 g"),
//            NutritionInfo(label: "Protein:", value: "0.9 g"),
//            NutritionInfo(label: "Fat:", value: "81 g"),
//            NutritionInfo(label: "Fiber:", value: "0 g"),
//            NutritionInfo(label: "Sugar:", value: "0.1 g")
//        ]
//    ),
//    GroceryProducts(
//        name: "Cottage Cheese",
//        title: "400g, Priceg",
//        imageName: "cottage_cheese",
//        price: "$2.79",
//        details: "Cottage cheese is a low-fat cheese with a mild flavor, high in protein and calcium.",
//        nutrition: [
//            NutritionInfo(label: "Calories:", value: "98 kcal"),
//            NutritionInfo(label: "Carbohydrates:", value: "3.4 g"),
//            NutritionInfo(label: "Protein:", value: "11.1 g"),
//            NutritionInfo(label: "Fat:", value: "4.3 g"),
//            NutritionInfo(label: "Fiber:", value: "0 g"),
//            NutritionInfo(label: "Sugar:", value: "3.4 g")
//        ]
//    )
//]
//
//// Meat and Fish
//let meatAndFishProducts: [GroceryProducts] = [
//    GroceryProducts(
//        name: "Chicken Breast",
//        title: "1kg, Priceg",
//        imageName: "chicken_breast",
//        price: "$8.99",
//        details: "Chicken breast is a lean source of protein with minimal fat.",
//        nutrition: [
//            NutritionInfo(label: "Calories:", value: "165 kcal"),
//            NutritionInfo(label: "Carbohydrates:", value: "0 g"),
//            NutritionInfo(label: "Protein:", value: "31 g"),
//            NutritionInfo(label: "Fat:", value: "3.6 g"),
//            NutritionInfo(label: "Fiber:", value: "0 g"),
//            NutritionInfo(label: "Sugar:", value: "0 g")
//        ]
//    ),
//    GroceryProducts(
//        name: "Salmon Fillet",
//        title: "1kg, Priceg",
//        imageName: "salmon_fillet",
//        price: "$14.99",
//        details: "Salmon is rich in omega-3 fatty acids and provides a high amount of protein.",
//        nutrition: [
//            NutritionInfo(label: "Calories:", value: "206 kcal"),
//            NutritionInfo(label: "Carbohydrates:", value: "0 g"),
//            NutritionInfo(label: "Protein:", value: "22 g"),
//            NutritionInfo(label: "Fat:", value: "13 g"),
//            NutritionInfo(label: "Fiber:", value: "0 g"),
//            NutritionInfo(label: "Sugar:", value: "0 g")
//        ]
//    ),
//    GroceryProducts(
//        name: "Ground Beef",
//        title: "500g, Priceg",
//        imageName: "ground_beef",
//        price: "$5.99",
//        details: "Ground beef is a versatile ingredient used in many recipes, rich in iron and protein.",
//        nutrition: [
//            NutritionInfo(label: "Calories:", value: "250 kcal"),
//            NutritionInfo(label: "Carbohydrates:", value: "0 g"),
//            NutritionInfo(label: "Protein:", value: "26 g"),
//            NutritionInfo(label: "Fat:", value: "20 g"),
//            NutritionInfo(label: "Fiber:", value: "0 g"),
//            NutritionInfo(label: "Sugar:", value: "0 g")
//        ]
//    ),
//    GroceryProducts(
//        name: "Pork Chops",
//        title: "1kg, Priceg",
//        imageName: "pork_chops",
//        price: "$9.49",
//        details: "Pork chops are a flavorful cut of meat, high in protein and nutrients.",
//        nutrition: [
//            NutritionInfo(label: "Calories:", value: "231 kcal"),
//            NutritionInfo(label: "Carbohydrates:", value: "0 g"),
//            NutritionInfo(label: "Protein:", value: "24 g"),
//            NutritionInfo(label: "Fat:", value: "15 g"),
//            NutritionInfo(label: "Fiber:", value: "0 g"),
//            NutritionInfo(label: "Sugar:", value: "0 g")
//        ]
//    ),
//    GroceryProducts(
//        name: "Shrimp",
//        title: "500g, Priceg",
//        imageName: "shrimp",
//        price: "$12.99",
//        details: "Shrimp is low in calories but high in protein, vitamins, and minerals.",
//        nutrition: [
//            NutritionInfo(label: "Calories:", value: "99 kcal"),
//            NutritionInfo(label: "Carbohydrates:", value: "0.2 g"),
//            NutritionInfo(label: "Protein:", value: "24 g"),
//            NutritionInfo(label: "Fat:", value: "0.3 g"),
//            NutritionInfo(label: "Fiber:", value: "0 g"),
//            NutritionInfo(label: "Sugar:", value: "0 g")
//        ]
//    )
//]
//
//// Cooking Oil
//let cookingOilProducts: [GroceryProducts] = [
//    GroceryProducts(
//        name: "Olive Oil",
//        title: "500ml, Priceg",
//        imageName: "olive_oil",
//        price: "$6.49",
//        details: "Olive oil is rich in monounsaturated fats and antioxidants.",
//        nutrition: [
//            NutritionInfo(label: "Calories:", value: "884 kcal"),
//            NutritionInfo(label: "Carbohydrates:", value: "0 g"),
//            NutritionInfo(label: "Protein:", value: "0 g"),
//            NutritionInfo(label: "Fat:", value: "100 g"),
//            NutritionInfo(label: "Fiber:", value: "0 g"),
//            NutritionInfo(label: "Sugar:", value: "0 g")
//        ]
//    ),
//    GroceryProducts(
//        name: "Canola Oil",
//        title: "1L, Priceg",
//        imageName: "canola_oil",
//        price: "$4.29",
//        details: "Canola oil is known for its mild flavor and high smoke point.",
//        nutrition: [
//            NutritionInfo(label: "Calories:", value: "884 kcal"),
//            NutritionInfo(label: "Carbohydrates:", value: "0 g"),
//            NutritionInfo(label: "Protein:", value: "0 g"),
//            NutritionInfo(label: "Fat:", value: "100 g"),
//            NutritionInfo(label: "Fiber:", value: "0 g"),
//            NutritionInfo(label: "Sugar:", value: "0 g")
//        ]
//    ),
//    GroceryProducts(
//        name: "Sunflower Oil",
//        title: "1L, Priceg",
//        imageName: "sunflower_oil",
//        price: "$4.99",
//        details: "Sunflower oil is high in vitamin E and low in saturated fats.",
//        nutrition: [
//            NutritionInfo(label: "Calories:", value: "884 kcal"),
//            NutritionInfo(label: "Carbohydrates:", value: "0 g"),
//            NutritionInfo(label: "Protein:", value: "0 g"),
//            NutritionInfo(label: "Fat:", value: "100 g"),
//            NutritionInfo(label: "Fiber:", value: "0 g"),
//            NutritionInfo(label: "Sugar:", value: "0 g")
//        ]
//    ),
//    GroceryProducts(
//        name: "Coconut Oil",
//        title: "500ml, Priceg",
//        imageName: "coconut_oil",
//        price: "$5.99",
//        details: "Coconut oil is used for cooking and baking, and is known for its unique flavor and health benefits.",
//        nutrition: [
//            NutritionInfo(label: "Calories:", value: "862 kcal"),
//            NutritionInfo(label: "Carbohydrates:", value: "0 g"),
//            NutritionInfo(label: "Protein:", value: "0 g"),
//            NutritionInfo(label: "Fat:", value: "100 g"),
//            NutritionInfo(label: "Fiber:", value: "0 g"),
//            NutritionInfo(label: "Sugar:", value: "0 g")
//        ]
//    ),
//    GroceryProducts(
//        name: "Avocado Oil",
//        title: "250ml, Priceg",
//        imageName: "avocado_oil",
//        price: "$7.99",
//        details: "Avocado oil has a high smoke point and is rich in monounsaturated fats.",
//        nutrition: [
//            NutritionInfo(label: "Calories:", value: "884 kcal"),
//            NutritionInfo(label: "Carbohydrates:", value: "0 g"),
//            NutritionInfo(label: "Protein:", value: "0 g"),
//            NutritionInfo(label: "Fat:", value: "100 g"),
//            NutritionInfo(label: "Fiber:", value: "0 g"),
//            NutritionInfo(label: "Sugar:", value: "0 g")
//        ]
//    )
//]
//
//// Bakery and Snacks
//let bakeryAndSnacksProducts: [GroceryProducts] = [
//    GroceryProducts(
//        name: "Whole Wheat Bread",
//        title: "500g, Priceg",
//        imageName: "whole_wheat_bread",
//        price: "$2.79",
//        details: "Whole wheat bread is a good source of fiber and essential nutrients.",
//        nutrition: [
//            NutritionInfo(label: "Calories:", value: "247 kcal"),
//            NutritionInfo(label: "Carbohydrates:", value: "41 g"),
//            NutritionInfo(label: "Protein:", value: "11 g"),
//            NutritionInfo(label: "Fat:", value: "4 g"),
//            NutritionInfo(label: "Fiber:", value: "7 g"),
//            NutritionInfo(label: "Sugar:", value: "5 g")
//        ]
//    ),
//    GroceryProducts(
//        name: "Oatmeal Cookies",
//        title: "250g, Priceg",
//        imageName: "oatmeal_cookies",
//        price: "$3.49",
//        details: "Oatmeal cookies are a tasty treat and provide a good source of fiber.",
//        nutrition: [
//            NutritionInfo(label: "Calories:", value: "460 kcal"),
//            NutritionInfo(label: "Carbohydrates:", value: "70 g"),
//            NutritionInfo(label: "Protein:", value: "6 g"),
//            NutritionInfo(label: "Fat:", value: "18 g"),
//            NutritionInfo(label: "Fiber:", value: "4 g"),
//            NutritionInfo(label: "Sugar:", value: "30 g")
//        ]
//    ),
//    GroceryProducts(
//        name: "Potato Chips",
//        title: "150g, Priceg",
//        imageName: "potato_chips",
//        price: "$2.99",
//        details: "Potato chips are a crispy snack made from sliced potatoes.",
//        nutrition: [
//            NutritionInfo(label: "Calories:", value: "536 kcal"),
//            NutritionInfo(label: "Carbohydrates:", value: "52 g"),
//            NutritionInfo(label: "Protein:", value: "6 g"),
//            NutritionInfo(label: "Fat:", value: "34 g"),
//            NutritionInfo(label: "Fiber:", value: "4 g"),
//            NutritionInfo(label: "Sugar:", value: "0.8 g")
//        ]
//    ),
//    GroceryProducts(
//        name: "Granola Bars",
//        title: "6 pcs, Priceg",
//        imageName: "granola_bars",
//        price: "$3.99",
//        details: "Granola bars are a convenient and healthy snack option.",
//        nutrition: [
//            NutritionInfo(label: "Calories:", value: "150 kcal"),
//            NutritionInfo(label: "Carbohydrates:", value: "25 g"),
//            NutritionInfo(label: "Protein:", value: "3 g"),
//            NutritionInfo(label: "Fat:", value: "5 g"),
//            NutritionInfo(label: "Fiber:", value: "2 g"),
//            NutritionInfo(label: "Sugar:", value: "12 g")
//        ]
//    ),
//    GroceryProducts(
//        name: "Pretzels",
//        title: "200g, Priceg",
//        imageName: "pretzels",
//        price: "$2.49",
//        details: "Pretzels are a crunchy snack and a great alternative to chips.",
//        nutrition: [
//            NutritionInfo(label: "Calories:", value: "380 kcal"),
//            NutritionInfo(label: "Carbohydrates:", value: "76 g"),
//            NutritionInfo(label: "Protein:", value: "8 g"),
//            NutritionInfo(label: "Fat:", value: "2 g"),
//            NutritionInfo(label: "Fiber:", value: "3 g"),
//            NutritionInfo(label: "Sugar:", value: "2 g")
//        ]
//    ),
//    GroceryProducts(
//        name: "Bagels",
//        title: "4 pcs, Priceg",
//        imageName: "bagels",
//        price: "$3.29",
//        details: "Bagels are a classic breakfast item and can be enjoyed with a variety of toppings.",
//        nutrition: [
//            NutritionInfo(label: "Calories:", value: "250 kcal"),
//            NutritionInfo(label: "Carbohydrates:", value: "50 g"),
//            NutritionInfo(label: "Protein:", value: "9 g"),
//            NutritionInfo(label: "Fat:", value: "1 g"),
//            NutritionInfo(label: "Fiber:", value: "2 g"),
//            NutritionInfo(label: "Sugar:", value: "6 g")
//        ]
//    )
//]
//
//// Beverages
//let beveragesProducts: [GroceryProducts] = [
//    GroceryProducts(
//        name: "Orange Juice",
//        title: "1L, Priceg",
//        imageName: "orange_juice",
//        price: "$2.49",
//        details: "Orange juice is a refreshing beverage rich in vitamin C.",
//        nutrition: [
//            NutritionInfo(label: "Calories:", value: "45 kcal"),
//            NutritionInfo(label: "Carbohydrates:", value: "10 g"),
//            NutritionInfo(label: "Protein:", value: "0.7 g"),
//            NutritionInfo(label: "Fat:", value: "0.2 g"),
//            NutritionInfo(label: "Fiber:", value: "0.2 g"),
//            NutritionInfo(label: "Sugar:", value: "9 g")
//        ]
//    ),
//    GroceryProducts(
//        name: "Green Tea",
//        title: "20 bags, Priceg",
//        imageName: "green_tea",
//        price: "$3.29",
//        details: "Green tea is known for its antioxidant properties and soothing taste.",
//        nutrition: [
//            NutritionInfo(label: "Calories:", value: "2 kcal"),
//            NutritionInfo(label: "Carbohydrates:", value: "0 g"),
//            NutritionInfo(label: "Protein:", value: "0 g"),
//            NutritionInfo(label: "Fat:", value: "0 g"),
//            NutritionInfo(label: "Fiber:", value: "0 g"),
//            NutritionInfo(label: "Sugar:", value: "0 g")
//        ]
//    ),
//    GroceryProducts(
//        name: "Coffee Beans",
//        title: "250g, Priceg",
//        imageName: "coffee_beans",
//        price: "$5.49",
//        details: "Coffee beans are perfect for brewing a fresh cup of coffee.",
//        nutrition: [
//            NutritionInfo(label: "Calories:", value: "2 kcal"),
//            NutritionInfo(label: "Carbohydrates:", value: "0 g"),
//            NutritionInfo(label: "Protein:", value: "0 g"),
//            NutritionInfo(label: "Fat:", value: "0 g"),
//            NutritionInfo(label: "Fiber:", value: "0 g"),
//            NutritionInfo(label: "Sugar:", value: "0 g")
//        ]
//    ),
//    GroceryProducts(
//        name: "Coca-Cola",
//        title: "1.5L, Priceg",
//        imageName: "coca_cola",
//        price: "$1.99",
//        details: "Coca-Cola is a popular carbonated beverage known for its refreshing taste.",
//        nutrition: [
//            NutritionInfo(label: "Calories:", value: "42 kcal"),
//            NutritionInfo(label: "Carbohydrates:", value: "11 g"),
//            NutritionInfo(label: "Protein:", value: "0 g"),
//            NutritionInfo(label: "Fat:", value: "0 g"),
//            NutritionInfo(label: "Fiber:", value: "0 g"),
//            NutritionInfo(label: "Sugar:", value: "11 g")
//        ]
//    ),
//    GroceryProducts(
//        name: "Mineral Water",
//        title: "1.5L, Priceg",
//        imageName: "mineral_water",
//        price: "$1.29",
//        details: "Mineral water is natural and contains essential minerals.",
//        nutrition: [
//            NutritionInfo(label: "Calories:", value: "0 kcal"),
//            NutritionInfo(label: "Carbohydrates:", value: "0 g"),
//            NutritionInfo(label: "Protein:", value: "0 g"),
//            NutritionInfo(label: "Fat:", value: "0 g"),
//            NutritionInfo(label: "Fiber:", value: "0 g"),
//            NutritionInfo(label: "Sugar:", value: "0 g")
//        ]
//    )
//]
