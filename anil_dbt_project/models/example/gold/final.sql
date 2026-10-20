select 
    sales_id,
    product_name,
    category,
    {{ multiply('list_price', 'calculated_gross_amount') }} as total_sales,
    gross_amount as total_gross_amount,
    {{ merges('first_name', 'last_name') }} as full_name,
    email,
    phone,
    date,
    payment_method,
from 

    {{ ref('silver_salesinfo') }}
group by 
    sales_id,
    product_name,
    category,
    list_price,
    calculated_gross_amount,
    gross_amount,
    first_name,
    last_name,
    email,
    phone,
    date,
    payment_method
order by 
    total_sales desc