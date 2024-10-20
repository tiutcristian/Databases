# Seminar 2 - Data manipulation language (DML)
- Select
- Insert
- Update
- Delete

## 1. Select
```sql
SELECT [DISTINCT] column1, column2, ...
FROM Table1 t1, Table2 t2, ...
WHERE condition
[GROUP BY column1]
[HAVING condition]
[UNION | UNION ALL | INTERSECT | EXCEPT]
[ORDER BY column1]
```

```sql
SELEct Over18 = S.age - 18, S.age * 2 AS DoubleAge, S.weight / (S.height * S.height) BMI
FROM Students S
WHERE S.name LIKE '_%'
```

### 1.1. Set operators
`UNION vs UNION ALL` - UNION removes duplicates, UNION ALL does not

- UNION
```sql
SELECT column1, column2, ...
FROM Table1
UNION
SELECT column1, column2, ...
FROM Table2
```

- INTERSECT
```sql
SELECT T.spyId
FROM Tasks T, Missions M
WHERE T.missionId = M.missionId AND M.location = 'Online'
INTERSECT
SELECT T.spyId
FROM Tasks T, Missions M
WHERE T.missionId = M.missionId AND M.location <> 'Online'
```

- EXCEPT
```sql
SELECT T.spyId
FROM Tasks T, Missions M
WHERE T.missionId = M.missionId AND M.location = 'Online'
EXCEPT
SELECT T.spyId
FROM Tasks T, Missions M
WHERE T.missionId = M.missionId AND M.location <> 'Online'
```

### 1.2. Nested queries
Find the real names of the spies who have not been assigned a task in mission 100

a. Using `NOT IN`
```sql
SELECT S.realName
FROM Spies S
WHERE S.spyId NOT IN
    (SELECT T.spyId
    FROM Tasks T
    WHERE T.missionId = 100)
```

b. Using `NOT EXISTS`
```sql
SELECT S.realName
FROM Spies S
WHERE NOT EXISTS
    (SELECT T.spyId
    FROM Tasks T
    WHERE T.missionId = 100 AND T.spyId = S.spyId)
```

Find the real names of the spies with age greater than some spy named "John"

```sql
SELECT S.realName
FROM Spies S
WHERE S.age > ANY
    (SELECT S2.age
    FROM Spies S2
    WHERE S2.realName = 'John')
```

Find the real names of the spies with age greater than all spies named "John"

```sql
SELECT S.realName
FROM Spies S
WHERE S.age > ALL
    (SELECT S2.age
    FROM Spies S2
    WHERE S2.realName = 'John')
```

Equivalent keywords:  
- ALL <=> MAX  
- ANY <=> MIN  
- NOT IN <=> EXCEPT  
- IN <=> INTERSECT  
- expr <> ALL <=> expr NOT IN (subquery)

### 1.3. Joins
- INNER JOIN
```sql
SELECT column1, column2, ...
FROM Table1 T1 INNER JOIN Table2 T2 ON T1.column = T2.column
```

- LEFT JOIN
```sql
SELECT column1, column2, ...
FROM Table1 T1 LEFT JOIN Table2 T2 ON T1.column = T2.column
```