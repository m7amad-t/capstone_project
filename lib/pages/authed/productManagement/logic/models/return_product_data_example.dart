const String returnedProductsExample = """
{
  "returns": [
    {
      "id": 4,
      "quantity": 1,
      "refund": 599.99,
      "dateTime": "2025-01-10T14:20:00Z",
      "reason": "damaged",
      "note": null,
      "product": {
        "id": 5,
        "name": "Tablet",
        "price": 599.99,
        "imageUrl": "https://m.media-amazon.com/images/I/71QtoB1MJIL._SL1500_.jpg"
      },
      "selling_record": {
        "id": 126,
        "total": 1549.97,
        "dateTime": "2025-01-09T10:15:00Z",
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
              "id": 4,
              "name": "Smartwatch",
              "price": 249.99,
              "imageUrl": "https://m.media-amazon.com/images/I/71QtoB1MJIL._SL1500_.jpg"
            }
          }
        ]
      }
    },
    {
      "id": 5,
      "quantity": 2,
      "refund": 299.98,
      "dateTime": "2025-01-09T17:45:00Z",
      "reason": "not_what_expected",
      "note": "Customer returned items due to incorrect model.",
      "product": {
        "id": 8,
        "name": "Microwave Oven",
        "price": 149.99,
        "imageUrl": "https://example.com/images/microwave.jpg"
      },
      "selling_record": {
        "id": 127,
        "total": 1299.95,
        "dateTime": "2025-01-08T15:30:00Z",
        "products": [
          {
            "quantity": 2,
            "product": {
              "id": 8,
              "name": "Microwave Oven",
              "price": 149.99,
              "imageUrl": "https://example.com/images/microwave.jpg"
            }
          },
          {
            "quantity": 1,
            "product": {
              "id": 6,
              "name": "Air Conditioner",
              "price": 499.99,
              "imageUrl": "https://example.com/images/air_conditioner.jpg"
            }
          },
          {
            "quantity": 1,
            "product": {
              "id": 10,
              "name": "Vacuum Cleaner",
              "price": 199.99,
              "imageUrl": "https://example.com/images/vacuum_cleaner.jpg"
            }
          }
        ]
      }
    },
    {
      "id": 6,
      "quantity": 1,
      "refund": 899.99,
      "dateTime": "2025-01-08T12:00:00Z",
      "reason": "defective",
      "note": "Damaged during shipping.",
      "product": {
        "id": 12,
        "name": "Mountain Bike",
        "price": 899.99,
        "imageUrl": "https://example.com/images/mountain_bike.jpg"
      },
      "selling_record": {
        "id": 128,
        "total": 1899.98,
        "dateTime": "2025-01-07T09:00:00Z",
        "products": [
          {
            "quantity": 1,
            "product": {
              "id": 12,
              "name": "Mountain Bike",
              "price": 899.99,
              "imageUrl": "https://example.com/images/mountain_bike.jpg"
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
          }
        ]
      }
    },
    {
      "id": 7,
      "quantity": 3,
      "refund": 599.97,
      "dateTime": "2025-01-07T16:30:00Z",
      "reason": "missing_parts",
      "note": null,
      "product": {
        "id": 10,
        "name": "Vacuum Cleaner",
        "price": 199.99,
        "imageUrl": "https://example.com/images/vacuum_cleaner.jpg"
      },
      "selling_record": {
        "id": 129,
        "total": 899.95,
        "dateTime": "2025-01-06T14:45:00Z",
        "products": [
          {
            "quantity": 3,
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
              "id": 16,
              "name": "Sleeping Bag",
              "price": 79.99,
              "imageUrl": "https://example.com/images/sleeping_bag.jpg"
            }
          }
        ]
      }
    },
    {
      "id": 8,
      "quantity": 1,
      "refund": 1299.99,
      "dateTime": "2025-01-06T12:00:00Z",
      "reason": "expired",
      "note": "Defective item reported by customer.",
      "product": {
        "id": 2,
        "name": "Laptop",
        "price": 1299.99,
        "imageUrl": "https://m.media-amazon.com/images/I/71QtoB1MJIL._SL1500_.jpg"
      },
      "selling_record": {
        "id": 130,
        "total": 1699.97,
        "dateTime": "2025-01-05T11:20:00Z",
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
            "quantity": 2,
            "product": {
              "id": 3,
              "name": "Headphones",
              "price": 199.99,
              "imageUrl": "https://m.media-amazon.com/images/I/71QtoB1MJIL._SL1500_.jpg"
            }
          }
        ]
      }
    }
  ]
}
""";
