
-- 1. Write a query to return users who have admin roles 

SELECT humanoid_name, employee_role, admin_status FROM TAVERN_EMPLOYMENT 
INNER JOIN employee_id on (tavern_employment.employee_id = employee_id.employee_id)
INNER JOIN tavern_humanoids on (tavern_humanoids.humanoid_id = employee_id.humanoid_id)
WHERE (role_start_date IS NOT NULL AND role_end_date IS NULL AND admin_status ='YES');



-- 2. Write a query to return users who have admin roles and information about their taverns 

SELECT humanoid_name, employee_role, admin_status, tavern_name, tavern_location, tavern_floors FROM TAVERN_EMPLOYMENT 
INNER JOIN employee_id on (tavern_employment.employee_id = employee_id.employee_id)
INNER JOIN tavern_humanoids on (tavern_humanoids.humanoid_id = employee_id.humanoid_id)
JOIN tavern_info on (tavern_employment.tavern_id = tavern_info.tavern_id)
WHERE (role_start_date IS NOT NULL AND role_end_date IS NULL AND admin_status ='YES')



-- 3. Write a query that returns all guests ordered by name (ascending) and their classes and corresponding levels 


select humanoid_name, class.class_name, classlvl.lvl from tavern_humanoids FULL OUTER JOIN visitor_id on visitor_id.humanoid_id = tavern_humanoids.humanoid_id
JOIN classlvl on (classlvl.guest_id = visitor_id.visitor_id)
JOIN class ON (classlvl.class_id  = class.class_id) order by humanoid_name asc;




-- 4. Write a query that returns the top 10 sales in terms of sales price and what the services were 

--- This query selects sales from services only:
SELECT TOP 10 sale_id,service_id,total_sale FROM TAVERN_SALES order by total_sale desc;

-- This query selects from all tavern sales -- services and rooms

select sale_id,customer_id, service_id, total_sale from tavern_sales
UNION 
Select stay_id,guest_id, tavern_rooms.room_attr, sale_amt from room_stays 
join tavern_rooms on room_stays.room_id = tavern_rooms.room_id
order by total_sale desc;


-- 5. Write a query that returns guests with 2 or more classes 

-- returns the guest_id when guest has 2 or more classes
select guest_id from classlvl group by guest_id having count(*)>1;

-- returns information about guests with 2 classes
SELECT guest_id, humanoid_name, class.class_name, classlvl.lvl
FROM classlvl
JOIN visitor_id ON (visitor_id.visitor_id=classlvl.guest_id)
JOIN tavern_humanoids on (tavern_humanoids.humanoid_id = visitor_id.humanoid_id)
JOIN class on (class.class_id = classlvl.class_id)
WHERE guest_id IN
    (     SELECT guest_id
          FROM classlvl
          GROUP BY guest_id
          HAVING COUNT(*) > 1
    )
ORDER BY guest_id asc;

-- 6. Write a query that returns guests with 2 or more classes with levels higher than 5 

-- with my data values the query gives a more filtered view when up the conditions to 3 classes or lvls above 10:

SELECT guest_id, humanoid_name, class.class_name, classlvl.lvl
FROM classlvl
JOIN visitor_id ON (visitor_id.visitor_id=classlvl.guest_id)
JOIN tavern_humanoids on (tavern_humanoids.humanoid_id = visitor_id.humanoid_id)
JOIN class on (class.class_id = classlvl.class_id)
WHERE guest_id IN
    (     SELECT guest_id
          FROM classlvl
		  Where lvl> 5  --(10)-- finds all guests with 2 or more classes above lvl 5 (or lvl 10)
          GROUP BY guest_id
          HAVING COUNT(*) > 1 --(2)
    )
	AND lvl > 5 --(10) shows only the classes that are above > 5 (or 10)
ORDER BY guest_id asc;




-- 7. Write a query that returns guests with ONLY their highest level class 

SELECT classlvl.guest_id, tavern_humanoids.humanoid_name, class.class_name,classlvl.lvl FROM classlvl
JOIN visitor_id ON (visitor_id.visitor_id=classlvl.guest_id)
JOIN tavern_humanoids on (tavern_humanoids.humanoid_id = visitor_id.humanoid_id)
JOIN class on (class.class_id = classlvl.class_id)
WHERE lvl IN (
    SELECT lvl FROM
    (
        SELECT guest_id, MAX(lvl) AS lvl
        FROM classlvl
        GROUP BY guest_id
    ) AS A
)
order by lvl desc
;


-- 8. Write a query that returns guests that stay within a date range. Please remember that guests can stay for more than one night AND not all of the dates they stay have to be in that range (just some of them)
select * from tavern_visitors where (visitor_in between '1244-02-01 00:00:00' and '1244-03-02 00:00:00') --OR (visitor_out between '1244-02-20' and '1244-03-01');
UNION
select * from tavern_visitors where (visitor_out between '1244-02-01 00:00:00' and '1244-03-02 00:00:00');


--9. Using the additional queries provided, take the lab’s SELECT ‘CREATE query’ and add any IDENTITY and PRIMARY KEY constraints to it. 

-- Will post the answer to this in another file