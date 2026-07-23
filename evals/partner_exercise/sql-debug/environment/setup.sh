#!/bin/bash
set -e

echo "Seeding CUSTOMERS and ORDERS tables for sql-debug exercise..."

python3 << 'PYTHON_SCRIPT'
import os
import snowflake.connector

conn = snowflake.connector.connect(
    account=os.environ["SNOWFLAKE_ADMIN_ACCOUNT"],
    user=os.environ["SNOWFLAKE_ADMIN_USER"],
    password=os.environ["SNOWFLAKE_ADMIN_PASSWORD"],
    role=os.environ.get("SNOWFLAKE_ADMIN_ROLE"),
    warehouse=os.environ.get("SNOWFLAKE_ADMIN_WAREHOUSE"),
)

db = os.environ["SCRATCH_DATABASE"]
schema = os.environ["SCRATCH_SCHEMA"]

with conn.cursor() as cur:
    cur.execute(f"""
        CREATE OR REPLACE TABLE {db}.{schema}.CUSTOMERS (
            customer_id INT,
            customer_name STRING,
            region STRING
        )
    """)
    cur.execute(f"""
        INSERT INTO {db}.{schema}.CUSTOMERS VALUES
            (1, 'Acme Corp',    'West'),
            (2, 'Globex Ltd',   'East'),
            (3, 'Initech',      'West'),
            (4, 'Umbrella Co',  'North'),
            (5, 'Hooli',        'East'),
            (6, 'Pied Piper',   'West')
    """)
    cur.execute(f"""
        CREATE OR REPLACE TABLE {db}.{schema}.ORDERS (
            order_id    INT,
            customer_id INT,
            order_date  DATE,
            amount      DECIMAL(10,2)
        )
    """)
    cur.execute(f"""
        INSERT INTO {db}.{schema}.ORDERS VALUES
            (1,  1, '2024-01-15', 15000.00),
            (2,  1, '2024-02-20',  8500.00),
            (3,  2, '2024-01-10', 22000.00),
            (4,  3, '2024-03-01',  3200.00),
            (5,  4, '2024-01-25', 45000.00),
            (6,  5, '2024-02-14', 12000.00),
            (7,  6, '2024-03-10',  9800.00),
            (8,  2, '2024-03-15',  7500.00),
            (9,  4, '2024-02-28', 18000.00),
            (10, 5, '2024-03-20',  6000.00)
    """)

conn.close()
print(f"Seeded CUSTOMERS (6 rows) and ORDERS (10 rows) in {db}.{schema}")
PYTHON_SCRIPT

echo "Setup complete"
