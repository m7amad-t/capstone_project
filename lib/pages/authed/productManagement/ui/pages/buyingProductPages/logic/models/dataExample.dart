String boughtedProductsData = """
{
  "boughted": [
    {
      "quantity": 5,
      "price_per_item": 699.99,
      "expire_date": "2025-06-10T12:30:00Z",
      "date_time": "2025-01-10T12:30:00Z",
      "note": "Bought for resale",
      "product": {
        "id": 1,
        "name": "Smartphone",
        "price": 699.99,
        "imageUrl": "https://m.media-amazon.com/images/I/71QtoB1MJIL._SL1500_.jpg"
      }
    },
    {
      "quantity": 2,
      "price_per_item": 1299.99,
      "expire_date": null,
      "date_time": "2025-01-10T13:00:00Z",
      "note": "Discount applied",
      "product": {
        "id": 2,
        "name": "Laptop",
        "price": 1299.99,
        "imageUrl": "https://m.media-amazon.com/images/I/71QtoB1MJIL._SL1500_.jpg"
      }
    },
    {
      "quantity": 3,
      "price_per_item": 149.99,
      "expire_date": "2026-06-01T00:00:00Z",
      "date_time": "2025-01-10T14:00:00Z",
      "note": null,
      "product": {
        "id": 8,
        "name": "Microwave Oven",
        "price": 149.99,
        "imageUrl": "https://example.com/images/microwave.jpg"
      }
    },
    {
      "quantity": 1,
      "price_per_item": 249.99,
      "expire_date": null,
      "date_time": "2025-01-10T15:00:00Z",
      "note": "Gift for a friend",
      "product": {
        "id": 4,
        "name": "Smartwatch",
        "price": 249.99,
        "imageUrl": "https://m.media-amazon.com/images/I/71QtoB1MJIL._SL1500_.jpg"
      }
    },
    {
      "quantity": 10,
      "price_per_item": 49.99,
      "expire_date": null,
      "date_time": "2025-01-10T16:00:00Z",
      "note": "Bulk purchase for hiking trip",
      "product": {
        "id": 15,
        "name": "Backpack",
        "price": 49.99,
        "imageUrl": "https://example.com/images/backpack.jpg"
      }
    }, 
     {
      "quantity": 5,
      "price_per_item": 699.99,
      "expire_date": null,
      "date_time": "2025-01-09T10:15:00Z",
      "note": "Bought for resale",
      "product": {
        "id": 1,
        "name": "Smartphone",
        "price": 699.99,
        "imageUrl": "https://m.media-amazon.com/images/I/71QtoB1MJIL._SL1500_.jpg"
      }
    },
    {
      "quantity": 3,
      "price_per_item": 199.99,
      "expire_date": null,
      "date_time": "2025-01-09T12:00:00Z",
      "note": "Seasonal discount",
      "product": {
        "id": 3,
        "name": "Headphones",
        "price": 199.99,
        "imageUrl": "https://m.media-amazon.com/images/I/71QtoB1MJIL._SL1500_.jpg"
      }
    },
    {
      "quantity": 2,
      "price_per_item": 499.99,
      "expire_date": null,
      "date_time": "2025-01-09T13:30:00Z",
      "note": "For office use",
      "product": {
        "id": 6,
        "name": "Air Conditioner",
        "price": 499.99,
        "imageUrl": "https://example.com/images/air_conditioner.jpg"
      }
    },
    {
      "quantity": 4,
      "price_per_item": 149.99,
      "expire_date": "2026-12-01T00:00:00Z",
      "date_time": "2025-01-09T14:45:00Z",
      "note": null,
      "product": {
        "id": 8,
        "name": "Microwave Oven",
        "price": 149.99,
        "imageUrl": "https://example.com/images/microwave.jpg"
      }
    },
    {
      "quantity": 1,
      "price_per_item": 249.99,
      "expire_date": null,
      "date_time": "2025-01-09T15:30:00Z",
      "note": "Gift for family",
      "product": {
        "id": 4,
        "name": "Smartwatch",
        "price": 249.99,
        "imageUrl": "https://m.media-amazon.com/images/I/71QtoB1MJIL._SL1500_.jpg"
      }
    },
    {
      "quantity": 8,
      "price_per_item": 199.99,
      "expire_date": null,
      "date_time": "2025-01-09T17:00:00Z",
      "note": "For cleaning service",
      "product": {
        "id": 10,
        "name": "Vacuum Cleaner",
        "price": 199.99,
        "imageUrl": "https://example.com/images/vacuum_cleaner.jpg"
      }
    },
    {
      "quantity": 3,
      "price_per_item": 499.99,
      "expire_date": "2027-01-01T00:00:00Z",
      "date_time": "2025-01-09T18:15:00Z",
      "note": "Holiday sale purchase",
      "product": {
        "id": 11,
        "name": "Dishwasher",
        "price": 499.99,
        "imageUrl": "https://example.com/images/dishwasher.jpg"
      }
    },
    {
      "quantity": 10,
      "price_per_item": 49.99,
      "expire_date": null,
      "date_time": "2025-01-09T19:30:00Z",
      "note": "Bulk purchase for camping",
      "product": {
        "id": 15,
        "name": "Backpack",
        "price": 49.99,
        "imageUrl": "https://example.com/images/backpack.jpg"
      }
    },
    {
      "quantity": 2,
      "price_per_item": 999.99,
      "expire_date": null,
      "date_time": "2025-01-09T20:00:00Z",
      "note": "For home gym",
      "product": {
        "id": 13,
        "name": "Treadmill",
        "price": 999.99,
        "imageUrl": "https://example.com/images/treadmill.jpg"
      }
    },
    {
      "quantity": 6,
      "price_per_item": 79.99,
      "expire_date": null,
      "date_time": "2025-01-09T21:15:00Z",
      "note": "Winter sale deal",
      "product": {
        "id": 16,
        "name": "Sleeping Bag",
        "price": 79.99,
        "imageUrl": "https://example.com/images/sleeping_bag.jpg"
      }
    }, 
    {
      "quantity": 7,
      "price_per_item": 599.99,
      "expire_date": null,
      "date_time": "2025-01-10T08:30:00Z",
      "note": "Office upgrade purchase",
      "product": {
        "id": 5,
        "name": "Tablet",
        "price": 599.99,
        "imageUrl": "https://m.media-amazon.com/images/I/71QtoB1MJIL._SL1500_.jpg"
      }
    },
    {
      "quantity": 15,
      "price_per_item": 49.99,
      "expire_date": null,
      "date_time": "2025-01-10T09:15:00Z",
      "note": "Wholesale purchase for hiking club",
      "product": {
        "id": 15,
        "name": "Backpack",
        "price": 49.99,
        "imageUrl": "https://example.com/images/backpack.jpg"
      }
    },
    {
      "quantity": 1,
      "price_per_item": 1299.99,
      "expire_date": null,
      "date_time": "2025-01-10T10:45:00Z",
      "note": "Personal use",
      "product": {
        "id": 2,
        "name": "Laptop",
        "price": 1299.99,
        "imageUrl": "https://m.media-amazon.com/images/I/71QtoB1MJIL._SL1500_.jpg"
      }
    },
    {
      "quantity": 5,
      "price_per_item": 149.99,
      "expire_date": "2026-06-01T00:00:00Z",
      "date_time": "2025-01-10T11:30:00Z",
      "note": "Kitchen essentials",
      "product": {
        "id": 8,
        "name": "Microwave Oven",
        "price": 149.99,
        "imageUrl": "https://example.com/images/microwave.jpg"
      }
    },
    {
      "quantity": 3,
      "price_per_item": 399.99,
      "expire_date": null,
      "date_time": "2025-01-10T12:15:00Z",
      "note": "Laundry room upgrade",
      "product": {
        "id": 9,
        "name": "Washing Machine",
        "price": 399.99,
        "imageUrl": "https://example.com/images/washing_machine.jpg"
      }
    },
    {
      "quantity": 2,
      "price_per_item": 499.99,
      "expire_date": null,
      "date_time": "2025-01-10T13:45:00Z",
      "note": "Gift for parents",
      "product": {
        "id": 6,
        "name": "Air Conditioner",
        "price": 499.99,
        "imageUrl": "https://example.com/images/air_conditioner.jpg"
      }
    },
    {
      "quantity": 20,
      "price_per_item": 79.99,
      "expire_date": null,
      "date_time": "2025-01-10T14:30:00Z",
      "note": "Camping event supplies",
      "product": {
        "id": 16,
        "name": "Sleeping Bag",
        "price": 79.99,
        "imageUrl": "https://example.com/images/sleeping_bag.jpg"
      }
    },
    {
      "quantity": 4,
      "price_per_item": 199.99,
      "expire_date": null,
      "date_time": "2025-01-10T15:00:00Z",
      "note": "Renovation cleaning tools",
      "product": {
        "id": 10,
        "name": "Vacuum Cleaner",
        "price": 199.99,
        "imageUrl": "https://example.com/images/vacuum_cleaner.jpg"
      }
    },
    {
      "quantity": 3,
      "price_per_item": 899.99,
      "expire_date": null,
      "date_time": "2025-01-10T16:15:00Z",
      "note": "New stock for sports shop",
      "product": {
        "id": 12,
        "name": "Mountain Bike",
        "price": 899.99,
        "imageUrl": "https://example.com/images/mountain_bike.jpg"
      }
    },
    {
      "quantity": 2,
      "price_per_item": 799.99,
      "expire_date": null,
      "date_time": "2025-01-10T17:45:00Z",
      "note": "Refrigerator replacement",
      "product": {
        "id": 7,
        "name": "Refrigerator",
        "price": 799.99,
        "imageUrl": "https://example.com/images/refrigerator.jpg"
      }
    },
    {
      "quantity": 1,
      "price_per_item": 249.99,
      "expire_date": null,
      "date_time": "2025-01-10T18:30:00Z",
      "note": "Gift for colleague",
      "product": {
        "id": 4,
        "name": "Smartwatch",
        "price": 249.99,
        "imageUrl": "https://m.media-amazon.com/images/I/71QtoB1MJIL._SL1500_.jpg"
      }
    },
    {
      "quantity": 10,
      "price_per_item": 199.99,
      "expire_date": null,
      "date_time": "2025-01-10T19:00:00Z",
      "note": "Inventory for retail store",
      "product": {
        "id": 3,
        "name": "Headphones",
        "price": 199.99,
        "imageUrl": "https://m.media-amazon.com/images/I/71QtoB1MJIL._SL1500_.jpg"
      }
    },
    {
      "quantity": 1,
      "price_per_item": 999.99,
      "expire_date": null,
      "date_time": "2025-01-10T20:15:00Z",
      "note": "Gym upgrade equipment",
      "product": {
        "id": 13,
        "name": "Treadmill",
        "price": 999.99,
        "imageUrl": "https://example.com/images/treadmill.jpg"
      }
    },
    {
      "quantity": 10,
      "price_per_item": 149.99,
      "expire_date": null,
      "date_time": "2025-01-10T21:30:00Z",
      "note": "Camping accessories",
      "product": {
        "id": 14,
        "name": "Tent",
        "price": 149.99,
        "imageUrl": "https://example.com/images/tent.jpg"
      }
    }

  ]
}

""";
