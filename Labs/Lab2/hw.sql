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

--! Verificat pana  aici !

-- update data
UPDATE Coaches SET experience = 6 WHERE experience > 5

UPDATE Teams SET country = 'Canada' WHERE name LIKE 'Team%' AND country = 'USA'

UPDATE Athletes SET email = 'alice@gmail.com' WHERE team_id = 1 AND email LIKE 'a%'



-- delete data
DELETE FROM Coaches WHERE experience < 6

DELETE FROM Teams WHERE country = 'Canada' AND name LIKE 'Team%'