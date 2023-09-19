SELECT * FROM animals WHERE name LIKE '%mon';
SELECT name FROM animals WHERE date_of_birth >= 'Dec 31 2016' AND date_of_birth <= 'Jan 01 2019';
SELECT name FROM animals WHERE neutered = 'Yes' and escape_attempts < '3';
SELECT date_of_birth FROM animals WHERE name = 'Agumon' or name = 'Pikachu';
SELECT name, escape_attempts FROM animals WHERE weight_kg > '10.5';
SELECT * FROM animals WHERE neutered = 'Yes';
SELECT * FROM animals WHERE name NOT IN('Gabumon');
SELECT * FROM animals WHERE weight_kg >= '10.4' AND weight_kg <= '17.3';

-- Query and update animals table

BEGIN TRANSACTION;

UPDATE animals
SET species = 'unspecified'
WHERE species IS NULL;

SELECT * FROM animals;

ROLLBACK;
-----------------------------
BEGIN TRANSACTION;

UPDATE animals
SET species = 'digimon'
WHERE name LIKE '%mon';

UPDATE animals
SET species = 'pokemon'
WHERE species IS NULL;

SELECT * FROM animals;

COMMIT;

---------------------------

BEGIN TRANSACTION;

DELETE FROM animals;
SELECT * FROM animals;

ROLLBACK;

-------------------------------
BEGIN TRANSACTION;

DELETE FROM animals
WHERE date_of_birth > 'Jan 1 2022';

SAVEPOINT savepoint_weight;

UPDATE animals
SET weight_kg = weight_kg * -1;

ROLLBACK TO savepoint_weight;

UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;

COMMIT;
---------------------------------------------------------------------
SELECT COUNT(*) FROM animals;
SELECT COUNT(*) 
FROM animals
WHERE escape_attempts = 0;

SELECT AVG(weight_kg)
FROM animals;

SELECT neutered, COUNT(*) AS escape_count FROM animals
WHERE escape_attempts > 0
GROUP BY neutered
ORDER BY escape_count DESC
LIMIT 1;

SELECT species, 
MIN(weight_kg) AS min_weight, 
MAX(weight_kg) AS max_weight 
FROM animals
GROUP BY species;

SELECT species, AVG(escape_attempts) AS avg_escape_attempts
FROM animals
WHERE date_of_birth BETWEEN 'Jan 1 1990' AND 'Dec 31 2000'
GROUP BY species;

-- Query multiple table

SELECT A.name, O.full_name 
FROM animals A
JOIN owners O ON A.owner_id = O.id
WHERE O.full_name = 'Melody Pond';

SELECT A.name 
FROM animals A
JOIN species S ON A.species_id = S.id
WHERE S.name = 'Pokemon';

SELECT A.name, O.full_name
FROM owners O
LEFT JOIN animals A ON O.id = A.owner_id;

SELECT S.name AS species_name, COUNT(A.id) AS animal_count
FROM species S
LEFT JOIN animals A ON S.id = A.species_id
GROUP BY S.name;

SELECT A.name AS digimon_name
FROM animals A
JOIN species S ON A.species_id = S.id
JOIN owners O ON A.owner_id = O.id
WHERE O.full_name = 'Jennifer Orwell' AND S.name = 'Digimon';

SELECT A.name 
FROM animals A
JOIN owners O ON A.owner_id = O.id
WHERE O.full_name = 'Dean Winchester' AND A.escape_attempts = 0;

SELECT O.full_name AS owner_name, COUNT(A.id) AS animal_count
FROM owners O
LEFT JOIN animals A ON O.id = A.owner_id
GROUP BY O.full_name
ORDER BY COUNT(A.id) DESC
LIMIT 1;

-- Add 'join table' for visits

SELECT A.name AS last_animal_seen
FROM animals A
JOIN visits V ON V.animal_id = A.id
JOIN vets VE ON V.vet_id = VE.id
WHERE VE.name = 'William Tatcher'
ORDER BY V.date_of_visit DESC
LIMIT 1;

SELECT COUNT(DISTINCT V.animal_id)
FROM visits V
JOIN vets VE ON V.vet_id = VE.id
WHERE VE.name = 'Stephanie Mendez';

SELECT V.name AS vet_name, SP.name AS specialty
FROM vets V
LEFT JOIN specializations S ON S.vet_id = V.id
LEFT JOIN species SP ON SP.id = S.species_id;

SELECT A.name
FROM animals A
JOIN visits V ON A.id = V.animal_id
JOIN vets VE ON V.vet_id = VE.id
WHERE VE.name = 'Stephanie Mendez' AND V.date_of_visit 
BETWEEN '2020-04-01' AND '2020-08-30';

SELECT A.name, COUNT(V.animal_id)
FROM animals A
LEFT JOIN visits V ON A.id = V.animal_id
GROUP BY A.name
ORDER BY COUNT(V.animal_id) DESC
LIMIT 1;

SELECT A.name
FROM animals A
JOIN visits V ON A.id = V.animal_id
JOIN vets VE ON V.vet_id = VE.id
WHERE VE.name = 'Maisy Smith'
ORDER BY V.date_of_visit
LIMIT 1;

SELECT A.name AS animal_name, VE.name AS vet_name, V.date_of_visit
FROM animals A
JOIN visits V ON A.id = V.animal_id
JOIN vets VE ON V.vet_id = VE.id
ORDER BY V.date_of_visit DESC
LIMIT 1;

SELECT VE.name AS doctor, COUNT(A.name)
FROM visits V
JOIN vets VE ON V.vet_id = VE.id
JOIN animals A ON V.animal_id = A.id WHERE VE.name = 'Maisy Smith'
GROUP BY VE.name;

SELECT COUNT(*) AS type, S.name
FROM visits V JOIN vets VE ON V.vet_id = VE.id
JOIN animals A ON V.animal_id = A.id
JOIN species S ON S.id = A.species_id
WHERE VE.name = 'Maisy Smith' 
GROUP BY S.name
ORDER BY COUNT(*) DESC LIMIT 1;
