"""Sales pipeline transforms.

Some functions are not implemented yet — the test suite is failing.
Implement them so that `tests/` passes.
"""


def enrich(orders, customers):
    """Return each order with 'customer_name' and 'region' added.

    Args:
        orders: list of dicts, each with at least 'customer_id' and 'amount'.
        customers: list of dicts, each with 'customer_id', 'customer_name', 'region'.

    Returns:
        A new list of order dicts, each including the original keys plus
        'customer_name' and 'region' looked up from customers by customer_id.
    """
    raise NotImplementedError


def filter_by_region(enriched_orders, region):
    """Return only the enriched orders whose 'region' equals the given region."""
    raise NotImplementedError
