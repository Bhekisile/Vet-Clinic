CREATE DATABASE vet_clinic;

CREATE TABLE animals (
	id INT,
	name VARCHAR(50),
	date_of_birth DATE,
	escape_attempts INT,
	neutered BOOLEAN,
	weight_kg DECIMAL
);

-- Query and Update animals table

ALTER TABLE animals
ADD species VARCHAR(50);

-- Query multiple table

CREATE TABLE owners (
	id SERIAL PRIMARY KEY,
	full_name VARCHAR(50),
	age INT
);

CREATE TABLE species (
	id SERIAL PRIMARY KEY,
	name VARCHAR(50)
);

CREATE SEQUENCE animals_id_seq OWNED BY animals.id;
ALTER TABLE animals ALTER COLUMN id SET DEFAULT nextval('animals_id_seq');

ALTER TABLE animals
ADD PRIMARY KEY (id);

ALTER TABLE animals
DROP COLUMN species;

ALTER TABLE animals
ADD COLUMN species_id INT REFERENCES species(id);

ALTER TABLE animals
ADD COLUMN owner_id INT REFERENCES owners(id);
