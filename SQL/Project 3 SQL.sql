CREATE TABLE "winebyrow" (
	"id" integer,
	 "tier_1" VARCHAR(50),
 	"tier_2" VARCHAR(50),
	"tier_3" VARCHAR(50),
	"wine" VARCHAR(100),
	"avgscore" FLOAT,
	"avgprice" FLOAT,
	"rownum" integer
);

CREATE TABLE "winebyrowtier1" (
	"id" integer,
	 "tier_1" VARCHAR(50),
 	"tier_2" VARCHAR(50),
	"tier_3" VARCHAR(50),
	"wine" VARCHAR(100),
	"avgscore" FLOAT,
	"avgprice" FLOAT,
	"rownum" integer
);

CREATE TABLE "winebyrowtier2" (
	"id" integer,
	 "tier_1" VARCHAR(50),
 	"tier_2" VARCHAR(50),
	"tier_3" VARCHAR(50),
	"wine" VARCHAR(100),
	"avgscore" FLOAT,
	"avgprice" FLOAT,
	"rownum" integer
);

--Code to get the top “N” wines by tier 3

WITH MyRowSet AS
(SELECT aroma_list.tier_1 AS Tier_1
		, aroma_list.tier_2 AS Tier_2
		, wine_words.attribute
		, wine_words.wine
		, AVG(wine_words.score) AS Avgscore
		, Avg(wine_words.price) AS Avgprice
		, ROW_NUMBER() OVER (PARTITION BY attribute order by wine_words.score desc, wine_words.price) AS RowNum
FROM wine_words
INNER JOIN aroma_list ON wine_words.attribute = aroma_list.tier_3
GROUP BY aroma_list.tier_1
		, aroma_list.tier_2
		, wine_words.attribute
		, wine_words.wine
		, wine_words.score
		, wine_words.price
HAVING wine_words.wine Is Not Null
AND (Avg(wine_words.price)) Is Not Null
ORDER BY attribute, wine_words.score DESC, wine_words.price)

Select * FROM MyRowSet WHERE RowNum <=5;


--Code to get the top “N” wines by tier 2

WITH MyRowSet2 AS
(SELECT aroma_list.tier_1 AS Tier_1
		, aroma_list.tier_2 AS Tier_2
 		, aroma_list.tier_2 AS Tier_3
		, wine_words.wine
		, AVG(wine_words.score) AS Avgscore
		, Avg(wine_words.price) AS Avgprice
		, ROW_NUMBER() OVER (PARTITION BY Tier_2 order by wine_words.score desc, wine_words.price) AS RowNum
FROM wine_words
INNER JOIN aroma_list ON wine_words.attribute = aroma_list.tier_3
GROUP BY aroma_list.tier_1
		, aroma_list.tier_2
		, wine_words.wine
		, wine_words.score
		, wine_words.price
HAVING wine_words.wine Is Not Null
AND (Avg(wine_words.price)) Is Not Null
ORDER BY Tier_2, wine_words.score DESC, wine_words.price)

Select * FROM MyRowSet2 WHERE RowNum <=5;

--Code to get the top “N” wines by tier 1 

WITH MyRowSet3 AS
(SELECT aroma_list.tier_1 AS Tier_1
		, aroma_list.tier_1 AS Tier_2
 		, aroma_list.tier_1 AS Tier_3
		, wine_words.wine
		, AVG(wine_words.score) AS Avgscore
		, Avg(wine_words.price) AS Avgprice
		, ROW_NUMBER() OVER (PARTITION BY Tier_1 order by wine_words.score desc, wine_words.price) AS RowNum
FROM wine_words
INNER JOIN aroma_list ON wine_words.attribute = aroma_list.tier_3
GROUP BY aroma_list.tier_1
		, wine_words.wine
		, wine_words.score
		, wine_words.price
HAVING wine_words.wine Is Not Null
AND (Avg(wine_words.price)) Is Not Null
ORDER BY Tier_1, wine_words.score DESC, wine_words.price)

Select * FROM MyRowSet3 WHERE RowNum <=5;

--QRY0 – Joins three field values (Wine Name, Score and Price) to create a unique field name “winelong”
--Create view QRY0_Create_Wine_Row_combo as
SELECT ID
	, tier_1
	, tier_2
	, tier_3
	, concat(wine,' Score: ', avgscore, ' Price: ',avgprice) "winelong"
	, rownum
FROM winebyrow;

--QRY1 – wine 1 of 5  and displays in wine1 column
--Create view QRY1_Create_Wine_Row_1 as
SELECT ID
    , tier_1
    , tier_2
    , tier_3
    , winelong AS wine1
FROM public.qry0_create_wine_row_combo
WHERE rownum = 1;

--QRY2 – takes wine 2 of 5 and displays in wine2 column alongside wine 1
--CREATE view QRY2_Create_wine_row_1_2 as
SELECT public.qry1_create_wine_row_1.ID
    , public.qry1_create_wine_row_1.tier_1
    , public.qry1_create_wine_row_1.tier_2
    , public.qry1_create_wine_row_1.tier_3
    , public.qry1_create_wine_row_1.wine1
    , public.qry0_create_wine_row_combo.winelong AS wine2
FROM public.qry1_create_wine_row_1 
INNER JOIN public.qry0_create_wine_row_combo ON public.qry1_create_wine_row_1.tier_3 = public.qry0_create_wine_row_combo.tier_3
WHERE public.qry0_create_wine_row_combo.rownum = 2;

--QRY3 – takes wine 3 of 5 and displays in wine3 column alongside wine 1 and wine2
--CREATE view QRY3_Create_wine_row_1_2_3 as
SELECT public.qry2_create_wine_row_1_2.ID
    , public.qry2_create_wine_row_1_2.tier_1
    , public.qry2_create_wine_row_1_2.tier_2
    , public.qry2_create_wine_row_1_2.tier_3
    , public.qry2_create_wine_row_1_2.wine1
    , public.qry2_create_wine_row_1_2.wine2
    , public.qry0_create_wine_row_combo.winelong AS wine3
FROM public.qry2_create_wine_row_1_2
INNER JOIN public.qry0_create_wine_row_combo ON public.qry2_create_wine_row_1_2.tier_3 = public.qry0_create_wine_row_combo.tier_3
WHERE public.qry0_create_wine_row_combo.rownum = 3;

--QRY4 – takes wine 4 of 5 and displays in wine2 column alongside wine 1, wine2 and wine3
--CREATE view QRY4_Create_wine_row_1_2_3_4 as
SELECT public.qry3_create_wine_row_1_2_3.ID
    , public.qry3_create_wine_row_1_2_3.tier_1
    , public.qry3_create_wine_row_1_2_3.tier_2
    , public.qry3_create_wine_row_1_2_3.tier_3
    , public.qry3_create_wine_row_1_2_3.wine1
    , public.qry3_create_wine_row_1_2_3.wine2
    , public.qry3_create_wine_row_1_2_3.wine3
    , public.qry0_create_wine_row_combo.winelong AS wine4
FROM public.qry3_create_wine_row_1_2_3
INNER JOIN public.qry0_create_wine_row_combo ON public.qry3_create_wine_row_1_2_3.tier_3 = public.qry0_create_wine_row_combo.tier_3
WHERE public.qry0_create_wine_row_combo.rownum = 4;

--QRY5 – takes wine 5 of 5 and displays in wine2 column alongside wine 1, wine2, wine3 and wine4
--CREATE view QRY5_Create_wine_row_1_2_3_4_5 as
SELECT public.qry4_create_wine_row_1_2_3_4.ID
    , public.qry4_create_wine_row_1_2_3_4.tier_1
    , public.qry4_create_wine_row_1_2_3_4.tier_2
    , public.qry4_create_wine_row_1_2_3_4.tier_3
    , public.qry4_create_wine_row_1_2_3_4.wine1
    , public.qry4_create_wine_row_1_2_3_4.wine2
    , public.qry4_create_wine_row_1_2_3_4.wine3
    , public.qry4_create_wine_row_1_2_3_4.wine4
    , public.qry0_create_wine_row_combo.winelong AS wine5
FROM public.qry4_create_wine_row_1_2_3_4
INNER JOIN public.qry0_create_wine_row_combo ON public.qry4_create_wine_row_1_2_3_4.tier_3 = public.qry0_create_wine_row_combo.tier_3
WHERE public.qry0_create_wine_row_combo.rownum = 5;


--QRY0 – Joins three field values (Wine Name, Score and Price) to create a unique field name “winelong”
--Create view QRY00_Create_Wine_Row_combo as
SELECT ID
	, tier_1
	, tier_2
	, tier_3
	, concat(wine,' Score: ', avgscore, ' Price: ',avgprice) "winelong"
	, rownum
FROM winebyrowtier1;

--QRY1 – wine 1 of 5  and displays in wine1 column
--Create view QRY11_Create_Wine_Row_1 as
SELECT ID
    , tier_1
    , tier_2
    , tier_3
    , winelong AS wine1
FROM public.qry00_create_wine_row_combo
WHERE rownum = 1;

--QRY2 – takes wine 2 of 5 and displays in wine2 column alongside wine 1
--CREATE view QRY22_Create_wine_row_1_2 as
SELECT public.qry11_create_wine_row_1.ID
    , public.qry11_create_wine_row_1.tier_1
    , public.qry11_create_wine_row_1.tier_2
    , public.qry11_create_wine_row_1.tier_3
    , public.qry11_create_wine_row_1.wine1
    , public.qry00_create_wine_row_combo.winelong AS wine2
FROM public.qry11_create_wine_row_1 
INNER JOIN public.qry00_create_wine_row_combo ON public.qry11_create_wine_row_1.tier_3 = public.qry00_create_wine_row_combo.tier_3
WHERE public.qry00_create_wine_row_combo.rownum = 2;

--QRY3 – takes wine 3 of 5 and displays in wine3 column alongside wine 1 and wine2
--CREATE view QRY33_Create_wine_row_1_2_3 as
SELECT public.qry22_create_wine_row_1_2.ID
    , public.qry22_create_wine_row_1_2.tier_1
    , public.qry22_create_wine_row_1_2.tier_2
    , public.qry22_create_wine_row_1_2.tier_3
    , public.qry22_create_wine_row_1_2.wine1
    , public.qry22_create_wine_row_1_2.wine2
    , public.qry00_create_wine_row_combo.winelong AS wine3
FROM public.qry22_create_wine_row_1_2
INNER JOIN public.qry00_create_wine_row_combo ON public.qry22_create_wine_row_1_2.tier_3 = public.qry00_create_wine_row_combo.tier_3
WHERE public.qry00_create_wine_row_combo.rownum = 3;

--QRY4 – takes wine 4 of 5 and displays in wine2 column alongside wine 1, wine2 and wine3
--CREATE view QRY44_Create_wine_row_1_2_3_4 as
SELECT public.qry33_create_wine_row_1_2_3.ID
    , public.qry33_create_wine_row_1_2_3.tier_1
    , public.qry33_create_wine_row_1_2_3.tier_2
    , public.qry33_create_wine_row_1_2_3.tier_3
    , public.qry33_create_wine_row_1_2_3.wine1
    , public.qry33_create_wine_row_1_2_3.wine2
    , public.qry33_create_wine_row_1_2_3.wine3
    , public.qry00_create_wine_row_combo.winelong AS wine4
FROM public.qry33_create_wine_row_1_2_3
INNER JOIN public.qry00_create_wine_row_combo ON public.qry33_create_wine_row_1_2_3.tier_3 = public.qry00_create_wine_row_combo.tier_3
WHERE public.qry00_create_wine_row_combo.rownum = 4;

--QRY5 – takes wine 5 of 5 and displays in wine2 column alongside wine 1, wine2, wine3 and wine4
--CREATE view QRY55_Create_wine_row_1_2_3_4_5 as
SELECT public.qry44_create_wine_row_1_2_3_4.ID
    , public.qry44_create_wine_row_1_2_3_4.tier_1
    , public.qry44_create_wine_row_1_2_3_4.tier_2
    , public.qry44_create_wine_row_1_2_3_4.tier_3
    , public.qry44_create_wine_row_1_2_3_4.wine1
    , public.qry44_create_wine_row_1_2_3_4.wine2
    , public.qry44_create_wine_row_1_2_3_4.wine3
    , public.qry44_create_wine_row_1_2_3_4.wine4
    , public.qry00_create_wine_row_combo.winelong AS wine5
FROM public.qry44_create_wine_row_1_2_3_4
INNER JOIN public.qry00_create_wine_row_combo ON public.qry44_create_wine_row_1_2_3_4.tier_3 = public.qry00_create_wine_row_combo.tier_3
WHERE public.qry00_create_wine_row_combo.rownum = 5;

--QRY0 – Joins three field values (Wine Name, Score and Price) to create a unique field name “winelong”
--Create view QRY000_Create_Wine_Row_combo as
SELECT ID
	, tier_1
	, tier_2
	, tier_3
	, concat(wine,' Score: ', avgscore, ' Price: ',avgprice) "winelong"
	, rownum
FROM winebyrowtier2;

--QRY1 – wine 1 of 5  and displays in wine1 column
--Create view QRY111_Create_Wine_Row_1 as
SELECT ID
    , tier_1
    , tier_2
    , tier_3
    , winelong AS wine1
FROM public.qry000_create_wine_row_combo
WHERE rownum = 1;

--QRY2 – takes wine 2 of 5 and displays in wine2 column alongside wine 1
--CREATE view QRY222_Create_wine_row_1_2 as
SELECT public.qry111_create_wine_row_1.ID
    , public.qry111_create_wine_row_1.tier_1
    , public.qry111_create_wine_row_1.tier_2
    , public.qry111_create_wine_row_1.tier_3
    , public.qry111_create_wine_row_1.wine1
    , public.qry000_create_wine_row_combo.winelong AS wine2
FROM public.qry111_create_wine_row_1 
INNER JOIN public.qry000_create_wine_row_combo ON public.qry111_create_wine_row_1.tier_3 = public.qry000_create_wine_row_combo.tier_3
WHERE public.qry000_create_wine_row_combo.rownum = 2;

--QRY3 – takes wine 3 of 5 and displays in wine3 column alongside wine 1 and wine2
--CREATE view QRY333_Create_wine_row_1_2_3 as
SELECT public.qry222_create_wine_row_1_2.ID
    , public.qry222_create_wine_row_1_2.tier_1
    , public.qry222_create_wine_row_1_2.tier_2
    , public.qry222_create_wine_row_1_2.tier_3
    , public.qry222_create_wine_row_1_2.wine1
    , public.qry222_create_wine_row_1_2.wine2
    , public.qry000_create_wine_row_combo.winelong AS wine3
FROM public.qry222_create_wine_row_1_2
INNER JOIN public.qry000_create_wine_row_combo ON public.qry222_create_wine_row_1_2.tier_3 = public.qry000_create_wine_row_combo.tier_3
WHERE public.qry000_create_wine_row_combo.rownum = 3;

--QRY4 – takes wine 4 of 5 and displays in wine2 column alongside wine 1, wine2 and wine3
--CREATE view QRY444_Create_wine_row_1_2_3_4 as
SELECT public.qry333_create_wine_row_1_2_3.ID
    , public.qry333_create_wine_row_1_2_3.tier_1
    , public.qry333_create_wine_row_1_2_3.tier_2
    , public.qry333_create_wine_row_1_2_3.tier_3
    , public.qry333_create_wine_row_1_2_3.wine1
    , public.qry333_create_wine_row_1_2_3.wine2
    , public.qry333_create_wine_row_1_2_3.wine3
    , public.qry000_create_wine_row_combo.winelong AS wine4
FROM public.qry333_create_wine_row_1_2_3
INNER JOIN public.qry000_create_wine_row_combo ON public.qry333_create_wine_row_1_2_3.tier_3 = public.qry000_create_wine_row_combo.tier_3
WHERE public.qry000_create_wine_row_combo.rownum = 4;

--QRY5 – takes wine 5 of 5 and displays in wine2 column alongside wine 1, wine2, wine3 and wine4
--CREATE view QRY555_Create_wine_row_1_2_3_4_5 as
SELECT public.qry444_create_wine_row_1_2_3_4.ID
    , public.qry444_create_wine_row_1_2_3_4.tier_1
    , public.qry444_create_wine_row_1_2_3_4.tier_2
    , public.qry444_create_wine_row_1_2_3_4.tier_3
    , public.qry444_create_wine_row_1_2_3_4.wine1
    , public.qry444_create_wine_row_1_2_3_4.wine2
    , public.qry444_create_wine_row_1_2_3_4.wine3
    , public.qry444_create_wine_row_1_2_3_4.wine4
    , public.qry000_create_wine_row_combo.winelong AS wine5
FROM public.qry444_create_wine_row_1_2_3_4
INNER JOIN public.qry000_create_wine_row_combo ON public.qry444_create_wine_row_1_2_3_4.tier_3 = public.qry000_create_wine_row_combo.tier_3
WHERE public.qry000_create_wine_row_combo.rownum = 5;


