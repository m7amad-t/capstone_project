const String productCategoryExample = """
{
"categories" : [
    {
      "name": "Electronics",
      "items": [
        {
          "id" : 1, 
          "name": "Smartphone",
          "price": 699.99,
          "imageUrl": "https://m.media-amazon.com/images/I/71QtoB1MJIL._SL1500_.jpg",
          "description": "A high-end smartphone with amazing features features features.",
          "quantity": 50
        },  
        {
          "id" : 2, 
          "name": "Laptop",
          "price": 1299.99,
          "imageUrl": "https://m.media-amazon.com/images/I/71QtoB1MJIL._SL1500_.jpg",
          "description": "A powerful laptop for professional use.",
          "quantity": 30
        },
        {
          "id" : 3, 
          "name": "Headphones",
          "price": 199.99,
          "imageUrl": "https://m.media-amazon.com/images/I/71QtoB1MJIL._SL1500_.jpg",
          "description": "Noise-cancelling over-ear headphones.",
          "quantity": 35
        },
        {
          "id" : 4, 
          "name": "Smartwatch",
          "price": 249.99,
          "imageUrl": "https://m.media-amazon.com/images/I/71QtoB1MJIL._SL1500_.jpg",
          "description": "A smartwatch with health monitoring features.",
          "quantity": 12
        },
        {
          "id" : 5,
          "name": "Tablet",
          "price": 599.99,
          "imageUrl": "https://m.media-amazon.com/images/I/71QtoB1MJIL._SL1500_.jpg",
          "description": "A lightweight tablet for everyday use.",
          "quantity": 2
        }
      ]
    },
    {
      "name": "Home Appliances",
      "items": [
        {
          "id" : 6,
          "name": "Air Conditioner",
          "price": 499.99,
          "imageUrl": "https://example.com/images/air_conditioner.jpg",
          "description": "An energy-efficient air conditioner.",
          "quantity": 4
        },
        {
          "id" : 7,
          "name": "Refrigerator",
          "price": 799.99,
          "imageUrl": "https://example.com/images/refrigerator.jpg",
          "description": "A spacious and modern refrigerator.",
          "quantity": 0
        },
        {
          "id" : 8,
          "name": "Microwave Oven",
          "price": 149.99,
          "imageUrl": "https://example.com/images/microwave.jpg",
          "description": "A compact microwave for quick meals.",
          "quantity": 50
        },
        {
          "id" : 9,
          "name": "Washing Machine",
          "price": 399.99,
          "imageUrl": "https://example.com/images/washing_machine.jpg",
          "description": "A high-capacity washing machine.",
          "quantity": 3
        },
        {
          "id" : 10,
          "name": "Vacuum Cleaner",
          "price": 199.99,
          "imageUrl": "https://example.com/images/vacuum_cleaner.jpg",
          "description": "A lightweight and powerful vacuum cleaner.",
          "quantity": 25
        },
        {
          "id" : 11,
          "name": "Dishwasher",
          "price": 499.99,
          "imageUrl": "https://example.com/images/dishwasher.jpg",
          "description": "A quiet and efficient dishwasher.",
          "quantity": 12
        }
      ]
    },
    {
      "name": "Sports & Outdoors",
      "items": [
        {
          "id" : 12,
          "name": "Mountain Bike",
          "price": 899.99,
          "imageUrl": "https://example.com/images/mountain_bike.jpg",
          "description": "A durable mountain bike for tough terrains.",
          "quantity": 20
        },
        {
          "id" : 13,
          "name": "Treadmill",
          "price": 999.99,
          "imageUrl": "https://example.com/images/treadmill.jpg",
          "description": "A high-performance treadmill for indoor running.",
          "quantity": 10
        },
        {
          "id" : 14,
          "name": "Tent",
          "price": 149.99,
          "imageUrl": "https://example.com/images/tent.jpg",
          "description": "A waterproof tent for 4 people.",
          "quantity": 0
        },
        {
          "id" : 15,
          "name": "Backpack",
          "price": 49.99,
          "imageUrl": "https://example.com/images/backpack.jpg",
          "description": "A lightweight and spacious hiking backpack.",
          "quantity": 20
        },
        {
          "id" : 16,
          "name": "Sleeping Bag",
          "price": 79.99,
          "imageUrl": "https://example.com/images/sleeping_bag.jpg",
          "description": "A warm sleeping bag for camping.",
          "quantity": 4
        }
      ]
    }, 
     {
      "name": "Books & Stationery",
      "items": [
        {
          "id": 17,
          "name": "Notebook",
          "price": 4.99,
          "imageUrl": "https://example.com/images/notebook.jpg",
          "description": "A 200-page ruled notebook for everyday writing.",
          "quantity": 200
        },
        {
          "id": 18,
          "name": "Ballpoint Pen",
          "price": 0.99,
          "imageUrl": "https://example.com/images/pen.jpg",
          "description": "A smooth-writing ballpoint pen.",
          "quantity": 500
        },
        {
          "id": 19,
          "name": "Backpack",
          "price": 29.99,
          "imageUrl": "https://example.com/images/school_backpack.jpg",
          "description": "A durable backpack for school or office use.",
          "quantity": 50
        },
        {
          "id": 20,
          "name": "Desk Organizer",
          "price": 19.99,
          "imageUrl": "https://example.com/images/desk_organizer.jpg",
          "description": "A wooden desk organizer for office supplies.",
          "quantity": 35
        },
        {
          "id": 21,
          "name": "Art Supplies Set",
          "price": 49.99,
          "imageUrl": "https://example.com/images/art_supplies.jpg",
          "description": "A comprehensive set of art supplies for beginners.",
          "quantity": 15
        }
      ]
    },
    {
      "name": "Toys & Games",
      "items": [
        {
          "id": 22,
          "name": "Building Blocks Set",
          "price": 59.99,
          "imageUrl": "https://example.com/images/building_blocks.jpg",
          "description": "A creative building blocks set for kids aged 6+.",
          "quantity": 120
        },
        {
          "id": 23,
          "name": "Board Game",
          "price": 39.99,
          "imageUrl": "https://example.com/images/board_game.jpg",
          "description": "A classic strategy board game for family fun.",
          "quantity": 75
        },
        {
          "id": 24,
          "name": "Action Figure",
          "price": 14.99,
          "imageUrl": "https://example.com/images/action_figure.jpg",
          "description": "A collectible action figure for kids and fans.",
          "quantity": 40
        },
        {
          "id": 25,
          "name": "Remote Control Car",
          "price": 89.99,
          "imageUrl": "https://example.com/images/rc_car.jpg",
          "description": "A high-speed remote control car for outdoor fun.",
          "quantity": 30
        },
        {
          "id": 26,
          "name": "Dollhouse",
          "price": 149.99,
          "imageUrl": "https://example.com/images/dollhouse.jpg",
          "description": "A beautifully crafted dollhouse with furniture.",
          "quantity": 10
        }
      ]
    },
    {
      "name": "Health & Beauty",
      "items": [
        {
          "id": 27,
          "name": "Face Cream",
          "price": 24.99,
          "imageUrl": "https://example.com/images/face_cream.jpg",
          "description": "A moisturizing face cream for all skin types.",
          "quantity": 100
        },
        {
          "id": 28,
          "name": "Shampoo",
          "price": 12.99,
          "imageUrl": "https://example.com/images/shampoo.jpg",
          "description": "A nourishing shampoo for strong and shiny hair.",
          "quantity": 60
        },
        {
          "id": 29,
          "name": "Perfume",
          "price": 89.99,
          "imageUrl": "https://example.com/images/perfume.jpg",
          "description": "A long-lasting fragrance with floral notes.",
          "quantity": 25
        },
        {
          "id": 30,
          "name": "Lipstick Set",
          "price": 29.99,
          "imageUrl": "https://example.com/images/lipstick.jpg",
          "description": "A set of vibrant and long-lasting lipsticks.",
          "quantity": 15
        },
        {
          "id": 31,
          "name": "Electric Toothbrush",
          "price": 49.99,
          "imageUrl": "https://example.com/images/toothbrush.jpg",
          "description": "An electric toothbrush with multiple settings.",
          "quantity": 45
        }
      ]
    }
  ]
  }
  
  """;
