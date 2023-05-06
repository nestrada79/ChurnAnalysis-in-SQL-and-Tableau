SET sql_mode = '';
SELECT 
    s1.cancelled_date as 'original canceled date',
    s2.cancelled_date as 'resurrected canceled date', 
    s1.created_date as 'original created date', 
    s2.created_date as 'resurrected created date',
    s1.end_date as 'original end date',
    s2.end_date as 'resurrected end date',
    s1.next_charge_date as 'original next charge date', 
    s2.next_charge_date as 'resurrected next charge date', 
    CASE 
    WHEN s1.subscription_type = 0 then 'monthly'
    WHEN s1.subscription_type = 2 then 'annual'
    WHEN s1.subscription_type = 3 then 'lifetime'
    END as 'original plan',
    CASE
    WHEN s2.subscription_type = 0 then 'monthly'
    WHEN s2.subscription_type = 2 then 'annual'
    WHEN s2.subscription_type = 3 then 'lifetime'
    END as 'resurrected plan', 
    s1.student_id, 
    s1.subscription_id as 'original subscription id',
    s2.subscription_id as 'resurrected subscription id', 
    datediff(s2.created_date, s1.end_date) as 'days to resurrection'
    
FROM
    subscriptions s1
JOIN
	subscriptions s2
ON (s1.student_id = s2.student_id and s1.subscription_id != s2.subscription_id and s2.subscription_id > s1.subscription_id and s2.created_date > s1.created_date)
WHERE
datediff(s2.created_date, s1.end_date)  > 1
GROUP BY s1.student_id
;