SET sql_mode = '';
SELECT
	p.purchase_id, 
    p.student_id, 
	CASE
		WHEN p.subscription_type = 0 THEN 'monthly'
        WHEN p.subscription_type = 2 THEN 'annual'
        WHEN p.subscription_type = 3 THEN 'lifetime'
    END as subscription_type, 
    p.refund_id, 
    p.refunded_date, 
    min(p.purchase_date) as 'first_purchase_date', 
    p2.purchase_date as 'current_purchase_date',
    p.price,
    CASE
		WHEN min(p.purchase_date) = p2.purchase_date THEN 'new'
        ELSE 'recurring'
    END as 'revenue_type',
    CASE
		WHEN p.refunded_date is NULL then 'revenue'
        ELSE 'refund'
    END as refunds, 
    s.student_country
FROM 
	purchases p
INNER JOIN
	purchases p2
using (student_id)    
INNER JOIN
	students s
using (student_id)
GROUP by p.purchase_id
ORDER by p.purchase_date
    
    
