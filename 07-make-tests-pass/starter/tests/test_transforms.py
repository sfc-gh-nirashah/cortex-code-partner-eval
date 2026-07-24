import unittest

from salespipe.transforms import enrich, filter_by_region

CUSTOMERS = [
    {"customer_id": 1, "customer_name": "Acme", "region": "West"},
    {"customer_id": 2, "customer_name": "Globex", "region": "East"},
    {"customer_id": 3, "customer_name": "Initech", "region": "West"},
]
ORDERS = [
    {"order_id": 1, "customer_id": 1, "amount": 100},
    {"order_id": 2, "customer_id": 2, "amount": 200},
    {"order_id": 3, "customer_id": 1, "amount": 50},
    {"order_id": 4, "customer_id": 3, "amount": 30},
]


class TestEnrich(unittest.TestCase):
    def test_adds_name_and_region(self):
        enriched = enrich(ORDERS, CUSTOMERS)
        self.assertEqual(len(enriched), 4)
        self.assertEqual(enriched[0]["customer_name"], "Acme")
        self.assertEqual(enriched[0]["region"], "West")

    def test_preserves_amount(self):
        enriched = enrich(ORDERS, CUSTOMERS)
        self.assertEqual(enriched[1]["amount"], 200)
        self.assertEqual(enriched[1]["region"], "East")


class TestFilterByRegion(unittest.TestCase):
    def test_filter_west(self):
        west = filter_by_region(enrich(ORDERS, CUSTOMERS), "West")
        self.assertEqual(len(west), 3)  # orders 1, 3 (Acme) and 4 (Initech)

    def test_filter_east(self):
        east = filter_by_region(enrich(ORDERS, CUSTOMERS), "East")
        self.assertEqual(len(east), 1)


if __name__ == "__main__":
    unittest.main()
