# SQL Murder Mystery

This repository contains the solution to the [SQL Murder Mystery](https://mystery.knightlab.com/) challenge created by Northwestern University's Knight Lab. The case is a fictional murder mystery that we can solve using SQL queries on a database of crime reports, interviews, check-ins, and personal records.

## Objective

Use SQL to identify:
1. The **mastermind** behind the murder

The challenge begins with only a vague memory:
> A **murder** took place on **Jan 15, 2018**, in **SQL City**.

---

## Dataset Tables

Key tables in the database:
- `crime_scene_report`
- `drivers_license`
- `facebook_event_checkin`
- `interview`
- `get_fit_now_member`
- `get_fit_now_check_in`
- `solution`
- `income`
- `person`

---

## Step-by-Step Approach

### 1. Retrieve the Crime Report
```sql
SELECT * FROM crime_scene_report 
WHERE date = '20180115' AND city = 'SQL City' AND type = 'murder';
```

### 2. Find the Witnesses
- First witness lived at the last house on **Northwestern Dr**
- Second witness named **Annabel** lived on **Franklin Ave**

### 3. Interview the Witnesses
- First saw the killer with a **Get Fit Now Gym bag** (ID starts with **48Z**) and car plate **H42W**
- Second recognized the killer from the gym on **Jan 9**

### 4. Identify the Suspect from Gym Check-ins
```sql
SELECT person.id, person.name
FROM get_fit_now_member
JOIN get_fit_now_check_in ON get_fit_now_member.id = get_fit_now_check_in.membership_id 
JOIN person ON get_fit_now_member.person_id = person.id 
JOIN drivers_license ON person.license_id = drivers_license.id
WHERE get_fit_now_member.id LIKE '48Z%'
AND get_fit_now_member.membership_status = 'gold'
AND get_fit_now_check_in.check_in_date = '20180109'
AND drivers_license.gender = 'male'
AND drivers_license.plate_number LIKE '%H42W%';
```

✅ **Suspect Identified:** `Jeremy Bowers`

### 5. Interview the Suspect

Jeremy reveals he was **hired by a wealthy woman**, around **5'5" to 5'7"**, with **red hair**, drives a **Tesla Model S**, and attended the **SQL Symphony Concert 3 times in Dec 2017**.

### 6. Identify the Mastermind
```sql
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
```

**Criminal Mastermind:** `Miranda Priestly`

---

## Final Step: Submit the Solution
```sql
INSERT INTO solution VALUES (1, 'Miranda Priestly');
SELECT value FROM solution;
```

You solved the case! SQL City hails you as the greatest detective of all time.

---

## Tools Used

- SQLite

---

## What I Learned

- SQL joins, filtering, and aggregation in a fun and practical scenario
- Reverse-engineering logic from narrative clues
- Multi-table query design and efficient searching

---
