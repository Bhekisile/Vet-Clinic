CREATE TABLE "animals"(
    "id" INTEGER NOT NULL,
    "name" VARCHAR(255) NOT NULL,
    "date_of_birth" DATE NOT NULL,
    "escape_attempts" INTEGER NOT NULL,
    "neutered" BOOLEAN NOT NULL,
    "weight_kg" DECIMAL(8, 2) NOT NULL,
    "species_id" INTEGER NOT NULL,
    "owner_id" INTEGER NOT NULL
);
ALTER TABLE
    "animals" ADD PRIMARY KEY("id");
ALTER TABLE
    "animals" ADD PRIMARY KEY("id");
CREATE TABLE "owners"(
    "id" INTEGER NOT NULL,
    "full_name" VARCHAR(255) NOT NULL,
    "age" INTEGER NOT NULL
);
ALTER TABLE
    "owners" ADD PRIMARY KEY("id");
CREATE TABLE "specializations"(
    "species_id" INTEGER NOT NULL,
    "vet_id" INTEGER NOT NULL
);
ALTER TABLE
    "specializations" ADD PRIMARY KEY("species_id");
CREATE TABLE "visits"(
    "animal_id" INTEGER NOT NULL,
    "vet_id" INTEGER NOT NULL,
    "date_of_visit" BIGINT NOT NULL
);
ALTER TABLE
    "visits" ADD PRIMARY KEY("animal_id");
CREATE TABLE "species"(
    "id" INTEGER NOT NULL,
    "name" VARCHAR(255) NOT NULL
);
ALTER TABLE
    "species" ADD PRIMARY KEY("id");
CREATE TABLE "vets"(
    "id" INTEGER NOT NULL,
    "name" VARCHAR(255) NOT NULL,
    "age" INTEGER NOT NULL,
    "date_of_graduation" DATE NOT NULL
);
ALTER TABLE
    "vets" ADD PRIMARY KEY("id");
ALTER TABLE
    "species" ADD CONSTRAINT "species_id_foreign" FOREIGN KEY("id") REFERENCES "animals"("id");
ALTER TABLE
    "specializations" ADD CONSTRAINT "specializations_species_id_foreign" FOREIGN KEY("species_id") REFERENCES "species"("id");
ALTER TABLE
    "visits" ADD CONSTRAINT "visits_animal_id_foreign" FOREIGN KEY("animal_id") REFERENCES "animals"("id");
ALTER TABLE
    "owners" ADD CONSTRAINT "owners_id_foreign" FOREIGN KEY("id") REFERENCES "animals"("id");
ALTER TABLE
    "specializations" ADD CONSTRAINT "specializations_vet_id_foreign" FOREIGN KEY("vet_id") REFERENCES "vets"("id");
ALTER TABLE
    "vets" ADD CONSTRAINT "vets_id_foreign" FOREIGN KEY("id") REFERENCES "visits"("animal_id");