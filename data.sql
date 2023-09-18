INSERT INTO animals(id, name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES
('1', 'Agumon', 'Feb 3 2020', '0', 'Yes', '10.23'),
('2', 'Gabumon', 'Nov 15 2018', '2', 'Yes', '8'),
('3', 'Pikachu', 'Jan 7 2021', '1', 'No', '15.04'),
('4', 'Devimon', 'May 12 2017', '5', 'Yes', '11');

-- Query and Update animals table

INSERT INTO animals(id, name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES
('5', 'Charmander', 'Feb 8 2020', '0', 'No', '11'),
('6', 'Plantmon', 'Nov 15 2021', '2', 'Yes', '5.7'),
('7', 'Squirtle', 'Apr 2 1993', '3', 'No', '12.13'),
('8', 'Angemon', 'Jun 12 2005', '1', 'Yes', '45'),
('9', 'Boarmon', '07 Jun 2005', '7', 'Yes', '20.4'),
('10', 'Blossom', '13 Oct 1998', '3', 'Yes', '17'),
('11', 'Ditto', '14 May 2022', '4', 'Yes', '22');

-- Query multiple table

INSERT INTO owners(full_name, age) VALUES
	('Sam Smith', '34'),
	('Jennifer Orwell', '19'),
	('Bob', '45'),
	('Melody Pond', '77'),
	('Dean Winchester', '14'),
	('Jodie Whittaker', '38');

INSERT INTO species(name) VALUES
	('Pokemon'),
	('Digimon');

UPDATE animals
SET species_id = CASE
	WHEN name LIKE '%mon' THEN (SELECT id FROM species WHERE name = 'Digimon')
	ELSE (SELECT id FROM species WHERE name = 'Pokemon')
	END;

UPDATE animals
SET owner_id = CASE
	WHEN name = 'Agumon' THEN (SELECT id FROM owners WHERE full_name = 'Sam Smith')
	WHEN name IN ('Gabumon', 'Pikachu') THEN (SELECT id FROM owners WHERE full_name = 'Jennifer Orwell')
	WHEN name IN ('Devimon', 'Plantmon') THEN (SELECT id FROM owners WHERE full_name = 'Bob')
	WHEN name IN ('Charmander', 'Squirtle', 'Blossom') THEN (SELECT id FROM owners WHERE full_name = 'Melody Pond')
	WHEN name IN ('Angemon', 'Boarmon') THEN (SELECT id FROM owners WHERE full_name = 'Dean Winchester')
	END;

    
