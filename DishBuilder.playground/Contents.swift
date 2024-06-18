
protocol DishIngredient {
    func name() -> String
}

struct Dish {
    var ingredients: [DishIngredient]
}

struct Fish: DishIngredient {
    func name() -> String {
        return "Fish"
    }
}

struct Meat: DishIngredient {
    func name() -> String {
        return "Meat"
    }
}

struct Onion: DishIngredient {
    func name() -> String {
        return "Onion"
    }
}

struct Carrot: DishIngredient {
    func name() -> String {
        return "Carrot"
    }
}

struct Salt: DishIngredient {
    func name() -> String {
        return "Salt"
    }
}

@resultBuilder
struct DishBulder {
    static func buildEither(first component: Dish) -> [DishIngredient] {
        return component.ingredients
    }
    
    static func buildEither(second component: Dish) -> [DishIngredient] {
        return component.ingredients
    }
    static func buildOptional(_ component: Dish?) -> [DishIngredient] {
        return component?.ingredients ?? []
    }
    
    static func buildExpression(_ expression: DishIngredient) -> [DishIngredient] {
        [expression]
    }
    
    static func buildExpression(_ expression: [any DishIngredient]) -> [DishIngredient] {
        expression
    }
    
    static func buildBlock(_ components: [DishIngredient]...) -> Dish {
        Dish(ingredients: components.flatMap { $0 })
    }
}

@DishBulder
func makeDish() -> Dish {
    if Bool.random() {
        Onion()
        Carrot()
    }
    
    if Bool.random() {
        Fish()
    } else {
        Meat()
    }
    
    Salt()
}

(1...3).forEach { dishNumber in
    print("\(dishNumber) - \(makeDish().ingredients.map { $0.name() })")
}
