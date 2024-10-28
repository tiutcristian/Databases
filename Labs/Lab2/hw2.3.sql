-- a. 2 queries with the union operation; use UNION [ALL] and OR;
    -- Select all athletes that are sponsored by Adidas or Nike
    -- 1. With UNION
    SELECT id, name
    FROM Athletes
    WHERE id in (
        SELECT athlete_id
        FROM Sponsorships
        WHERE sponsor_id in (
            SELECT id
            FROM Sponsors
            WHERE name = 'Adidas'

            UNION

            SELECT id
            FROM Sponsors
            WHERE name = 'Nike'
        )
    )

    -- 2. With OR
    SELECT id, name
    FROM Athletes
    WHERE id in (
        SELECT athlete_id
        FROM Sponsorships
        WHERE sponsor_id in (
            SELECT id
            FROM Sponsors
            WHERE name = 'Adidas' OR name = 'Nike'
        ) 
    )



-- b. 2 queries with the intersection operation; use INTERSECT and IN;
    -- Select IDs of athletes that are sponsored by both Adidas and Nike
    -- 1. With INTERSECT
    SELECT athlete_id
    FROM Sponsorships
    WHERE sponsor_id = (
        SELECT id
        FROM Sponsors
        WHERE name = 'Adidas'
    )

    INTERSECT

    SELECT athlete_id
    FROM Sponsorships
    WHERE sponsor_id = (
        SELECT id
        FROM Sponsors
        WHERE name = 'Nike'
    )

    -- 2. With IN
    SELECT athlete_id
    FROM Sponsorships
    WHERE sponsor_id = (
        SELECT id
        FROM Sponsors
        WHERE name = 'Adidas'
    ) AND athlete_id IN (
        SELECT athlete_id
        FROM Sponsorships
        WHERE sponsor_id = (
            SELECT id
            FROM Sponsors
            WHERE name = 'Nike'
        )
    )



-- c. 2 queries with the difference operation; use EXCEPT and NOT IN;
    -- Select IDs of athletes that are sponsored by Adidas but not by Nike
    -- 1. With EXCEPT
    SELECT athlete_id
    FROM Sponsorships
    WHERE sponsor_id = (
        SELECT id
        FROM Sponsors
        WHERE name = 'Adidas'
    )

    EXCEPT

    SELECT athlete_id
    FROM Sponsorships
    WHERE sponsor_id = (
        SELECT id
        FROM Sponsors
        WHERE name = 'Nike'
    )

    -- 2. With NOT IN
    SELECT athlete_id
    FROM Sponsorships
    WHERE sponsor_id = (
        SELECT id
        FROM Sponsors
        WHERE name = 'Adidas'
    ) AND athlete_id NOT IN (
        SELECT athlete_id
        FROM Sponsorships
        WHERE sponsor_id = (
            SELECT id
            FROM Sponsors
            WHERE name = 'Nike'
        )
    )



-- d. 4 queries with INNER JOIN, LEFT JOIN, RIGHT JOIN, and FULL JOIN (one query per operator); 
-- one query will join at least 3 tables, while another one will join at least two many-to-many relationships;

-- INNER JOIN + many-to-many (Sponsorships, RaceResults)
-- Find the athletes (id+name) sponsored by Nike that participated in race with id 1
SELECT A.id, A.name
FROM Athletes A
JOIN Sponsorships SS ON A.id = SS.athlete_id
JOIN Sponsors S ON SS.sponsor_id = S.id
JOIN RaceResults RR ON A.id = RR.athlete
WHERE S.name = 'Nike' AND RR.race_id = 1;