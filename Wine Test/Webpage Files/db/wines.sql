BEGIN TRANSACTION;
CREATE TABLE IF NOT EXISTS "wine_scores" (
	"wine"	TEXT,
	"SCORE"	INTEGER
);
CREATE TABLE IF NOT EXISTS "attributes_metadata" (
	"attribute"	TEXT,
	"AVGSCORE"	INTEGER,
	"AVGPRICE"	INTEGER,
	"WINE1"	TEXT,
	"WINE2"	TEXT,
	"WINE3"	TEXT,
	"WINE4"	TEXT,
	"WINE5"	TEXT,
	"WINE6"	TEXT,
	"WINE7"	TEXT,
	"WINE8"	TEXT,
	"WINE9"	TEXT,
	"WINE10"	TEXT,
	PRIMARY KEY("attribute")
);
INSERT INTO "wine_scores" VALUES (NULL,NULL);
INSERT INTO "wine_scores" VALUES ('gfsger',82);
INSERT INTO "wine_scores" VALUES ('gfsger',84);
INSERT INTO "wine_scores" VALUES (NULL,NULL);
INSERT INTO "attributes_metadata" VALUES ('Fruity Aroma',83.2,43.1,'sdfadg','gfsger','dfdafs','efdfsa','wresdfv','adfd','fadsfdfa','dfasdfd','asdfdasdfd','asdfasdfd');
INSERT INTO "attributes_metadata" VALUES ('Nut Aroma',80.3,23.8,'dfasf','dfasdfd','asdfds','asdfdasdf','sdfasdf','dfasdfasdf','fasdfasdf','afdfasdfsa','asdfasdfasdf','sadfasdf');
COMMIT;
