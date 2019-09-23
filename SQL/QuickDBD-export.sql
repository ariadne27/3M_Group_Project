-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.

-- Modify this code to update the DB schema diagram.
-- To reset the sample schema, replace everything with
-- two dots ('..' - without quotes).

CREATE TABLE aroma_list (
    tier_1 VARCHAR(50),
    tier_2 VARCHAR(50),
    tier_3 VARCHAR(50),
    alt_name VARCHAR(50),
    CONSTRAINT pk_aroma_list PRIMARY KEY (
        tier_3
     )
);

CREATE TABLE wine_words (
    ID FLOAT,
    wine VARCHAR(100),
    attribute VARCHAR(50),
    score FLOAT,
    price FLOAT
);

CREATE TABLE wine_count (
    attribute VARCHAR(50),
    tally FLOAT
);

CREATE TABLE wine_avg (
    attribute VARCHAR(50),
    avg_score FLOAT,
    avg_price FLOAT
);

ALTER TABLE wine_words ADD CONSTRAINT fk_wine_words_attribute FOREIGN KEY(attribute)
REFERENCES aroma_list (tier_3);

ALTER TABLE wine_count ADD CONSTRAINT fk_wine_count_attribute FOREIGN KEY(attribute)
REFERENCES aroma_list (tier_3);

ALTER TABLE wine_avg ADD CONSTRAINT fk_wine_avg_attribute FOREIGN KEY(attribute)
REFERENCES aroma_list (tier_3);

