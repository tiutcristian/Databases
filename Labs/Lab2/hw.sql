-- insert data
INSERT INTO Coaches (name, email, experience) VALUES ('John Doe', 'john@doe.com', 5)
INSERT INTO Coaches (name, email, experience) VALUES ('Michael Thompson', 'm@t.com', 10)

INSERT INTO Teams (name, country, coach_id) VALUES ('Team John', 'USA', 1)
INSERT INTO Teams (name, country, coach_id) VALUES ('Team Michael', 'UK', 2)


INSERT INTO Athletes (name, email, team_id) VALUES ('Alice', 'a@gmail.com', 1)
INSERT INTO Athletes (name, email, team_id) VALUES ('Bob', 'b@gmail.com', 1)
INSERT INTO Athletes (name, email, team_id) VALUES ('Charlie', 'c@gmail.com', 2)

INSERT INTO Sponsors (name, country) VALUES ('Nike', 'USA')
INSERT INTO Sponsors (name, country) VALUES ('Adidas', 'Germany')

-- violating integrity constraint
INSERT INTO Teams (name, country, coach_id) VALUES ('Team John', 'USA', 3)

--! Verificat pana aici !

-- update data
UPDATE Sponsorship SET sponsor_id = 2 WHERE team_id = 1 AND sponsor_id = 1

UPDATE Teams SET country = 'Canada' WHERE name LIKE 'Team%' AND country = 'USA'

UPDATE Athletes SET email = 'alice@gmail.com' WHERE team_id = 1 AND email LIKE 'a%'

-- delete data
DELETE FROM Coaches WHERE experience < 6

DELETE FROM Teams WHERE country = 'Canada' AND name LIKE 'Team%'

-- a. 2 queries with the union operation; use UNION [ALL] and OR;
    -- Select all athletes that are sponsored by Adidas or Nike
    SELECT name
    FROM Athletes
    WHERE id = (
        SELECT athlete_id
        FROM Sponsorship
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

    -- Select all athletes that are trained by a coach with more than 5 years of experience
    SELECT name
    FROM Athletes
    WHERE team_id in (
        SELECT id
        FROM Teams
        WHERE coach_id in (
            SELECT id
            FROM Coaches
            WHERE experience > 5
        )
    )

