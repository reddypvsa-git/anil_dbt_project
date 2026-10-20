with sales as
(
    select 
          sales_id,
          product_sk,
          customer_sk,
          DATE_SK,

          {{multiply('unit_price','quantity')}} as calculated_gross_amount,
          gross_amount,
          payment_method
    from
        {{ref('bronze_sales')}}
),

PRODUCT AS(
    select 
          product_sk,
          product_name,
          category,
          list_price
    from 
        {{ref('bronze_product')}}
),

CUSTOMER AS 
(
    select 
          customer_sk,
          first_name,
          last_name,
          email,
          phone
    from 
        {{ref('bronze_customer')}}
),

date_bro as
(
    select 
          date_sk,
          date,
          month,
          year
    from 
        {{ref('bronze_date')}}
)




select 
    s.sales_id,
    s.product_sk,
    p.product_name,
    p.category,
    p.list_price,
    s.customer_sk,
    c.first_name,
    c.last_name,
    c.email,
    c.phone,
    s.date_sk,
    d.date,
    d.month,
    d.year,
    s.calculated_gross_amount,
    s.gross_amount,
    s.payment_method
from 
    sales s
join 
    PRODUCT p
on s.product_sk = p.product_sk
join 
    CUSTOMER c
on s.customer_sk = c.customer_sk
join 
    date_bro d
on s.date_sk = d.date_sk
