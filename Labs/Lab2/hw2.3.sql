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