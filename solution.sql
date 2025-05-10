-- 1. Retrieve the crime report on Jan 15, 2018 in SQL City
SELECT * FROM crime_scene_report 
WHERE date = '20180115' AND city = 'SQL City' AND type = 'murder';

-- 2. Find first witness: Last house on Northwestern Dr
SELECT id, name FROM person 
WHERE address_street_name = 'Northwestern Dr' 
ORDER BY address_number DESC LIMIT 1;

-- 3. Find second witness: Annabel on Franklin Ave
SELECT id, name FROM person 
WHERE name LIKE '%Annabel%' AND address_street_name = 'Franklin Ave';

-- 4. Interview first witness
SELECT * FROM interview 
WHERE person_id = 14887;

-- 5. Interview second witness
SELECT * FROM interview 
WHERE person_id = 16371;

-- 6. Identify suspect from gym: Jan 9, 48Z, gold member, male, plate contains H42W
SELECT person.id, person.name 
FROM get_fit_now_member
JOIN get_fit_now_check_in 
    ON get_fit_now_member.id = get_fit_now_check_in.membership_id 
JOIN person 
    ON get_fit_now_member.person_id = person.id 
JOIN drivers_license 
    ON person.license_id = drivers_license.id
WHERE get_fit_now_member.id LIKE '48Z%' 
  AND get_fit_now_member.membership_status = 'gold'
  AND get_fit_now_check_in.check_in_date = '20180109'
  AND drivers_license.gender = 'male'
  AND drivers_license.plate_number LIKE '%H42W%';

-- 7. Interview the suspect: Jeremy Bowers
SELECT * FROM interview 
WHERE person_id = 67318;

-- 8. Find the mastermind: female, 65–67 inches, red hair, Tesla Model S, 3 concert check-ins
SELECT person.id, person.name 
FROM drivers_license 
JOIN person ON drivers_license.id = person.license_id
JOIN facebook_event_checkin ON person.id = facebook_event_checkin.person_id
WHERE drivers_license.gender = 'female'
  AND drivers_license.height BETWEEN 65 AND 67
  AND drivers_license.hair_color = 'red'
  AND drivers_license.car_make = 'Tesla'
  AND drivers_license.car_model LIKE '%S%'
GROUP BY drivers_license.id, person.id
HAVING COUNT(facebook_event_checkin.person_id) = 3;

-- 9. Interview Miranda Priestly
SELECT * FROM interview 
WHERE person_id = 99716;

-- 10. Submit final solution
INSERT INTO solution 
VALUES (1, 'Miranda Priestly');

SELECT value FROM solution;
