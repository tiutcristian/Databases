----------------- Setup for second part of the homework -----------------

-- Insert a bit more sponsorships
INSERT INTO Sponsorships (sponsor_id, athlete_id, amount, start_date, end_date)
VALUES  (1, 1, 1000, '2020-01-01', '2020-12-31'),
        (1, 2, 2000, '2020-01-01', '2020-12-31'),
        (2, 2, 6000, '2020-01-01', '2020-12-31'),
        (2, 3, 7000, '2020-01-01', '2020-12-31');
-- Nike sponsors 1 and 2
-- Adidas sponsors 2 and 3
-- Puma sponsors 1 and 3 (previously inserted)