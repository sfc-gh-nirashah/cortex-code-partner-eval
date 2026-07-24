"""Reporting functions built on top of the transforms layer.

These depend on salespipe.transforms.enrich. Implement them so the tests pass.
"""

from salespipe.transforms import enrich


def revenue_by_region(orders, customers):
    """Return {region: total_amount} summed across all orders.

    Should use enrich() to attach region to each order, then total by region.
    """
    raise NotImplementedError


def order_count_by_region(orders, customers):
    """Return {region: number_of_orders} across all orders."""
    raise NotImplementedError
