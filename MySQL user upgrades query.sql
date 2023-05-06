SET sql_mode = '';
select 
o2.student_id,
case 
when o.subscription_type = 0 then 'monthly'
when o.subscription_type = 2 then 'annual'
when o.subscription_type = 3 then 'lifetime'
end as 'Subscription Type',
case 
when o.subscription_type = 0 then 'monthly'
when o.subscription_type = 2 then 'annual'
when o.subscription_type = 3 then 'lifetime'
end as 'Subscription Type Res',
max(purchase_date), 
created_at, 
o.price, 
o2.price
FROM (
select
 student_id, min(purchase_date) AS created_at, subscription_type, price, refunded_date
   FROM
     purchases
WHERE (subscription_type = 2 or subscription_type = 3)
   GROUP BY
     student_id
)
	as  o2
INNER JOIN
	purchases o
ON (o.student_id = o2.student_id 
and o.subscription_type = 0 
and o.purchase_date < o2.created_at
and o2.refunded_date is null)
join
	students u
    ON u.student_id = o.student_id
    group by created_at
    
 union   
select
o2.student_id,
case 
when o.subscription_type = 0 then 'monthly'
when o.subscription_type = 2 then 'annual'
when o.subscription_type = 3 then 'lifetime'
end as 'Subscription Type',
case 
when o2.subscription_type = 0 then 'monthly'
when o2.subscription_type = 2 then 'annual'
when o2.subscription_type = 3 then 'lifetime'
end as 'Subscription Type Res',
max(purchase_date), 
created_at, 
o.price, 
o2.price
FROM (
select
 student_id, min(purchase_date) AS created_at, subscription_type,price, refunded_date
   FROM
     purchases
WHERE subscription_type = 2
   GROUP BY
     student_id
)
	as  o2
INNER JOIN
	purchases o
ON (o.student_id = o2.student_id 
and o.subscription_type = 3
and o.purchase_date < o2.created_at
and o2.refunded_date is null and o.refunded_date is null)
join students u
on u.student_id = o.student_id
    group by created_at;    