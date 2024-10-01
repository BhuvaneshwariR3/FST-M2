-- Load the CSV filei
salesTable = LOAD 'hdfs:///user/bhuvaneshwari/sales.csv' USING PigStorage(',') AS (Product:chararray,Price:chararray,Payment_Type:chararray,Name:chararray,City:chararray,State:chararray,Country:chararray);
-- Group data using the country column
GroupByCountry = GROUP salesTable BY Country;
-- Generate result format
CountByCountry = FOREACH GroupByCountry GENERATE CONCAT((chararray)$0, CONCAT(':', (chararray)COUNT($1)));
-- Remove the old results folder
rmf hdfs:///user/bhuvaneshwari/salesOutput;
-- Save result in HDFS folder
STORE CountByCountry INTO 'hdfs:///user/bhuvaneshwari/salesOutput' USING PigStorage('\t');
