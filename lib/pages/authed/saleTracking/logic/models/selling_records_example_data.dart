const String selling_record_example = """
{
  "selling_records": [
    {
      "id": 330,
      "total": 1399.98,
      "dateTime": "2022-01-06T14:45:00",
      "products": [
        {
          "quantity": 2,
          "product": {
            "id": 1,
            "name": "Smartphone",
            "price": 699.99,
            "imageUrl": "https://m.media-amazon.com/images/I/71QtoB1MJIL._SL1500_.jpg"
          }
        }
      ]
    },
    {
      "id": 353,
      "total": 1459.96,
      "dateTime": "2022-02-06T14:45:00",
      "products": [
        {
          "quantity": 1,
          "product": {
            "id": 1,
            "name": "Smartphone",
            "price": 699.99,
            "imageUrl": "https://m.media-amazon.com/images/I/71QtoB1MJIL._SL1500_.jpg"
          }
        },
        {
          "quantity": 3,
          "product": {
            "id": 4,
            "name": "Smartwatch",
            "price": 249.99,
            "imageUrl": "https://m.media-amazon.com/images/I/71QtoB1MJIL._SL1500_.jpg"
          }
        }
      ]
    },
    {
      "id": 101,
      "total": 1549.97,
      "dateTime": "2023-11-12T11:30:00",
      "products": [
        {
          "quantity": 1,
          "product": {
            "id": 2,
            "name": "Laptop",
            "price": 1299.99,
            "imageUrl": "https://m.media-amazon.com/images/I/71QtoB1MJIL._SL1500_.jpg"
          }
        },
        {
          "quantity": 1,
          "product": {
            "id": 3,
            "name": "Headphones",
            "price": 199.99,
            "imageUrl": "https://m.media-amazon.com/images/I/71QtoB1MJIL._SL1500_.jpg"
          }
        },
        {
          "quantity": 1,
          "product": {
            "id": 5,
            "name": "Tablet",
            "price": 599.99,
            "imageUrl": "https://m.media-amazon.com/images/I/71QtoB1MJIL._SL1500_.jpg"
          }
        }
      ]
    },
    {
      "id": 102,
      "total": 749.98,
      "dateTime": "2023-12-01T14:00:00",
      "products": [
        {
          "quantity": 2,
          "product": {
            "id": 4,
            "name": "Smartwatch",
            "price": 249.99,
            "imageUrl": "https://m.media-amazon.com/images/I/71QtoB1MJIL._SL1500_.jpg"
          }
        },
        {
          "quantity": 1,
          "product": {
            "id": 1,
            "name": "Smartphone",
            "price": 699.99,
            "imageUrl": "https://m.media-amazon.com/images/I/71QtoB1MJIL._SL1500_.jpg"
          }
        }
      ]
    },
    {
      "id": 103,
      "total": 1149.97,
      "dateTime": "2023-12-05T16:45:00",
      "products": [
        {
          "quantity": 1,
          "product": {
            "id": 8,
            "name": "Microwave Oven",
            "price": 149.99,
            "imageUrl": "https://example.com/images/microwave.jpg"
          }
        },
        {
          "quantity": 2,
          "product": {
            "id": 6,
            "name": "Air Conditioner",
            "price": 499.99,
            "imageUrl": "https://example.com/images/air_conditioner.jpg"
          }
        }
      ]
    },
    {
      "id": 104,
      "total": 899.98,
      "dateTime": "2024-01-08T10:15:00",
      "products": [
        {
          "quantity": 2,
          "product": {
            "id": 16,
            "name": "Sleeping Bag",
            "price": 79.99,
            "imageUrl": "https://example.com/images/sleeping_bag.jpg"
          }
        },
        {
          "quantity": 1,
          "product": {
            "id": 15,
            "name": "Backpack",
            "price": 49.99,
            "imageUrl": "https://example.com/images/backpack.jpg"
          }
        },
        {
          "quantity": 1,
          "product": {
            "id": 12,
            "name": "Mountain Bike",
            "price": 899.99,
            "imageUrl": "https://example.com/images/mountain_bike.jpg"
          }
        }
      ]
    },
    {
      "id": 105,
      "total": 1199.96,
      "dateTime": "2024-01-10T13:20:00",
      "products": [
        {
          "quantity": 1,
          "product": {
            "id": 7,
            "name": "Refrigerator",
            "price": 799.99,
            "imageUrl": "https://example.com/images/refrigerator.jpg"
          }
        },
        {
          "quantity": 2,
          "product": {
            "id": 10,
            "name": "Vacuum Cleaner",
            "price": 199.99,
            "imageUrl": "https://example.com/images/vacuum_cleaner.jpg"
          }
        }
      ]
    },
    {
      "id": 106,
      "total": 1249.98,
      "dateTime": "2024-01-15T17:05:00",
      "products": [
        {
          "quantity": 1,
          "product": {
            "id": 13,
            "name": "Treadmill",
            "price": 999.99,
            "imageUrl": "https://example.com/images/treadmill.jpg"
          }
        },
        {
          "quantity": 5,
          "product": {
            "id": 9,
            "name": "Washing Machine",
            "price": 399.99,
            "imageUrl": "https://example.com/images/washing_machine.jpg"
          }
        }
      ]
    },
    {
      "id": 107,
      "total": 1849.95,
      "dateTime": "2024-01-18T09:50:00",
      "products": [
        {
          "quantity": 1,
          "product": {
            "id": 3,
            "name": "Headphones",
            "price": 199.99,
            "imageUrl": "https://m.media-amazon.com/images/I/71QtoB1MJIL._SL1500_.jpg"
          }
        },
        {
          "quantity": 1,
          "product": {
            "id": 11,
            "name": "Dishwasher",
            "price": 499.99,
            "imageUrl": "https://example.com/images/dishwasher.jpg"
          }
        },
        {
          "quantity": 1,
          "product": {
            "id": 2,
            "name": "Laptop",
            "price": 1299.99,
            "imageUrl": "https://m.media-amazon.com/images/I/71QtoB1MJIL._SL1500_.jpg"
          }
        }
      ]
    },
    {
      "id": 108,
      "total": 999.98,
      "dateTime": "2024-01-20T18:45:00",
      "products": [
        {
          "quantity": 2,
          "product": {
            "id": 13,
            "name": "Treadmill",
            "price": 999.99,
            "imageUrl": "https://example.com/images/treadmill.jpg"
          }
        }
      ]
    },
    {
      "id": 109,
      "total": 179.97,
      "dateTime": "2024-01-22T15:10:00",
      "products": [
        {
          "quantity": 3,
          "product": {
            "id": 3,
            "name": "Headphones",
            "price": 199.99,
            "imageUrl": "https://m.media-amazon.com/images/I/71QtoB1MJIL._SL1500_.jpg"
          }
        }
      ]
    },
    {
      "id": 110,
      "total": 1599.97,
      "dateTime": "2024-01-25T11:30:00",
      "products": [
        {
          "quantity": 1,
          "product": {
            "id": 5,
            "name": "Tablet",
            "price": 599.99,
            "imageUrl": "https://m.media-amazon.com/images/I/71QtoB1MJIL._SL1500_.jpg"
          }
        },
        {
          "quantity": 2,
          "product": {
            "id": 2,
            "name": "Laptop",
            "price": 1299.99,
            "imageUrl": "https://m.media-amazon.com/images/I/71QtoB1MJIL._SL1500_.jpg"
          }
        }
      ]
    },
    {
      "id": 111,
      "total": 1049.96,
      "dateTime": "2024-01-26T14:15:00",
      "products": [
        {
          "quantity": 4,
          "product": {
            "id": 4,
            "name": "Smartwatch",
            "price": 249.99,
            "imageUrl": "https://m.media-amazon.com/images/I/71QtoB1MJIL._SL1500_.jpg"
          }
        }
      ]
    },
    {
      "id": 112,
      "total": 3499.93,
      "dateTime": "2024-01-27T18:20:00",
      "products": [
        {
          "quantity": 3,
          "product": {
            "id": 6,
            "name": "Air Conditioner",
            "price": 499.99,
            "imageUrl": "https://example.com/images/air_conditioner.jpg"
          }
        },
        {
          "quantity": 2,
          "product": {
            "id": 7,
            "name": "Refrigerator",
            "price": 799.99,
            "imageUrl": "https://example.com/images/refrigerator.jpg"
          }
        },
        {
          "quantity": 1,
          "product": {
            "id": 8,
            "name": "Microwave Oven",
            "price": 149.99,
            "imageUrl": "https://example.com/images/microwave.jpg"
          }
        }
      ]
    },
    {
      "id": 113,
      "total": 149.97,
      "dateTime": "2024-01-28T20:10:00",
      "products": [
        {
          "quantity": 3,
          "product": {
            "id": 14,
            "name": "Tent",
            "price": 149.99,
            "imageUrl": "https://example.com/images/tent.jpg"
          }
        }
      ]
    },
    {
      "id": 114,
      "total": 999.94,
      "dateTime": "2024-01-29T09:45:00",
      "products": [
        {
          "quantity": 10,
          "product": {
            "id": 11,
            "name": "Dishwasher",
            "price": 499.99,
            "imageUrl": "https://example.com/images/dishwasher.jpg"
          }
        },
        {
          "quantity": 1,
          "product": {
            "id": 15,
            "name": "Backpack",
            "price": 49.99,
            "imageUrl": "https://example.com/images/backpack.jpg"
          }
        }
      ]
    },
    {
      "id": 115,
      "total": 2999.94,
      "dateTime": "2024-01-30T12:00:00",
      "products": [
        {
          "quantity": 2,
          "product": {
            "id": 12,
            "name": "Mountain Bike",
            "price": 899.99,
            "imageUrl": "https://example.com/images/mountain_bike.jpg"
          }
        },
        {
          "quantity": 4,
          "product": {
            "id": 16,
            "name": "Sleeping Bag",
            "price": 79.99,
            "imageUrl": "https://example.com/images/sleeping_bag.jpg"
          }
        }
      ]
    },
    {
      "id": 116,
      "total": 1799.93,
      "dateTime": "2024-01-31T16:45:00",
      "products": [
        {
          "quantity": 1,
          "product": {
            "id": 10,
            "name": "Vacuum Cleaner",
            "price": 199.99,
            "imageUrl": "https://example.com/images/vacuum_cleaner.jpg"
          }
        },
        {
          "quantity": 1,
          "product": {
            "id": 13,
            "name": "Treadmill",
            "price": 999.99,
            "imageUrl": "https://example.com/images/treadmill.jpg"
          }
        },
        {
          "quantity": 5,
          "product": {
            "id": 3,
            "name": "Headphones",
            "price": 199.99,
            "imageUrl": "https://m.media-amazon.com/images/I/71QtoB1MJIL._SL1500_.jpg"
          }
        }
      ]
    }
  ]
}

"""; 