import unittest

from salespipe.report import order_count_by_region, revenue_by_region

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


class TestRevenueByRegion(unittest.TestCase):
    def test_totals(self):
        rev = revenue_by_region(ORDERS, CUSTOMERS)
        self.assertEqual(rev["West"], 180)  # 100 + 50 + 30
        self.assertEqual(rev["East"], 200)


class TestOrderCountByRegion(unittest.TestCase):
    def test_counts(self):
        counts = order_count_by_region(ORDERS, CUSTOMERS)
        self.assertEqual(counts["West"], 3)
        self.assertEqual(counts["East"], 1)


if __name__ == "__main__":
    unittest.main()
