String damaged_products_data_example = """
{
  "damaged_products": [
    {
      "id": 1,
      "quantity": 2,
      "boughtedPrice": 500.00,
      "note": "Battery issue",
      "date_time": "2025-01-14T10:00:00Z",
      "product": {
        "id": 1,
        "name": "Smartphone",
        "price": 699.99,
        "imageUrl": "https://m.media-amazon.com/images/I/71QtoB1MJIL._SL1500_.jpg"
      }
    },
    {
      "id": 2,
      "quantity": 1,
      "boughtedPrice": 1000.00,
      "note": "Keyboard not working",
      "date_time": "2025-01-14T10:10:00Z",
      "product": {
        "id": 2,
        "name": "Laptop",
        "price": 1299.99,
        "imageUrl": "https://m.media-amazon.com/images/I/71QtoB1MJIL._SL1500_.jpg"
      }
    },
    {
      "id": 3,
      "quantity": 3,
      "boughtedPrice": 150.00,
      "note": "Sound distortion",
      "date_time": "2025-01-14T10:20:00Z",
      "product": {
        "id": 3,
        "name": "Headphones",
        "price": 199.99,
        "imageUrl": "https://m.media-amazon.com/images/I/71QtoB1MJIL._SL1500_.jpg"
      }
    },
    {
      "id": 4,
      "quantity": 1,
      "boughtedPrice": 180.00,
      "note": "Cracked screen",
      "date_time": "2025-01-14T10:30:00Z",
      "product": {
        "id": 4,
        "name": "Smartwatch",
        "price": 249.99,
        "imageUrl": "https://m.media-amazon.com/images/I/71QtoB1MJIL._SL1500_.jpg"
      }
    },
    {
      "id": 5,
      "quantity": 2,
      "boughtedPrice": 450.00,
      "note": "Damaged packaging",
      "date_time": "2025-01-14T10:40:00Z",
      "product": {
        "id": 5,
        "name": "Tablet",
        "price": 599.99,
        "imageUrl": "https://m.media-amazon.com/images/I/71QtoB1MJIL._SL1500_.jpg"
      }
    },
    {
      "id": 6,
      "quantity": 1,
      "boughtedPrice": 400.00,
      "note": "Leaking water",
      "date_time": "2025-01-14T10:50:00Z",
      "product": {
        "id": 6,
        "name": "Air Conditioner",
        "price": 499.99,
        "imageUrl": "https://example.com/images/air_conditioner.jpg"
      }
    },
    {
      "id": 7,
      "quantity": 1,
      "boughtedPrice": 650.00,
      "note": "Door dented",
      "date_time": "2025-01-14T11:00:00Z",
      "product": {
        "id": 7,
        "name": "Refrigerator",
        "price": 799.99,
        "imageUrl": "https://example.com/images/refrigerator.jpg"
      }
    },
    {
      "id": 8,
      "quantity": 1,
      "boughtedPrice": 120.00,
      "note": "Heating element not working",
      "date_time": "2025-01-14T11:10:00Z",
      "product": {
        "id": 8,
        "name": "Microwave Oven",
        "price": 149.99,
        "imageUrl": "https://example.com/images/microwave.jpg"
      }
    },
    {
      "id": 9,
      "quantity": 1,
      "boughtedPrice": 320.00,
      "note": "Spin cycle malfunction",
      "date_time": "2025-01-14T11:20:00Z",
      "product": {
        "id": 9,
        "name": "Washing Machine",
        "price": 399.99,
        "imageUrl": "https://example.com/images/washing_machine.jpg"
      }
    },
    {
      "id": 10,
      "quantity": 1,
      "boughtedPrice": 150.00,
      "note": "Motor issue",
      "date_time": "2025-01-14T11:30:00Z",
      "product": {
        "id": 10,
        "name": "Vacuum Cleaner",
        "price": 199.99,
        "imageUrl": "https://example.com/images/vacuum_cleaner.jpg"
      }
    },
    {
      "id": 11,
      "quantity": 1,
      "boughtedPrice": 450.00,
      "note": "Dishes not cleaned properly",
      "date_time": "2025-01-14T11:40:00Z",
      "product": {
        "id": 11,
        "name": "Dishwasher",
        "price": 499.99,
        "imageUrl": "https://example.com/images/dishwasher.jpg"
      }
    },
    {
      "id": 12,
      "quantity": 2,
      "boughtedPrice": 750.00,
      "note": "Frame bent",
      "date_time": "2025-01-14T11:50:00Z",
      "product": {
        "id": 12,
        "name": "Mountain Bike",
        "price": 899.99,
        "imageUrl": "https://example.com/images/mountain_bike.jpg"
      }
    },
    {
      "id": 13,
      "quantity": 1,
      "boughtedPrice": 800.00,
      "note": "Belt slipping",
      "date_time": "2025-01-14T12:00:00Z",
      "product": {
        "id": 13,
        "name": "Treadmill",
        "price": 999.99,
        "imageUrl": "https://example.com/images/treadmill.jpg"
      }
    },
    {
      "id": 14,
      "quantity": 1,
      "boughtedPrice": 120.00,
      "note": "Torn fabric",
      "date_time": "2025-01-14T12:10:00Z",
      "product": {
        "id": 14,
        "name": "Tent",
        "price": 149.99,
        "imageUrl": "https://example.com/images/tent.jpg"
      }
    },
    {
      "id": 15,
      "quantity": 1,
      "boughtedPrice": 40.00,
      "note": "Broken strap",
      "date_time": "2025-01-14T12:20:00Z",
      "product": {
        "id": 15,
        "name": "Backpack",
        "price": 49.99,
        "imageUrl": "https://example.com/images/backpack.jpg"
      }
    },
    {
      "id": 16,
      "quantity": 1,
      "boughtedPrice": 70.00,
      "note": "Zipper stuck",
      "date_time": "2025-01-14T12:30:00Z",
      "product": {
        "id": 16,
        "name": "Sleeping Bag",
        "price": 79.99,
        "imageUrl": "https://example.com/images/sleeping_bag.jpg"
      }
    }
  ]
}

"""; 