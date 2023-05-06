SET sql_mode = '';
SELECT
p.purchase_id, 
p.subscription_id, 
cast(p.purchase_date as date) as 'purchase date', 
p.received_date, 
p.price, 
p.payment_provider, 
p.subscription_type,  
s.*
  --  cast(o.order_created as date) as 'order created',
   -- u.user_registered,
   -- i.user_country,
   -- ROUND(order_payout_currency) AS order_value,
   -- o.order_product,
   -- CAST(o.order_created AS DATE) AS 'InvoiceDate'
FROM
    purchases p
        JOIN
    students s ON s.student_id = p.student_id
WHERE
        p.refunded_date IS NULL
       -- AND CAST(o.order_created AS DATE) > '2020-01-31'
        AND p.subscription_type = 0
group by p.purchase_id