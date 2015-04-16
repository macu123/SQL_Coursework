-------------------
-- 1156724
-- Jiapeng Chen
-------------------

CONNECT TO se4db3;
------------------------------------
--   q1
------------------------------------
SELECT ID, modelNumber, name, price
FROM Product
WHERE price > 950 AND
      price < 1000;

------------------------------------
--   q2
------------------------------------
SELECT Person.ID, Person.firstName, Person.lastName
FROM Person, Attendee
WHERE Person.ID = Attendee.ID AND
      Person.postalCode LIKE 'N%' AND
      Year(Person.dateOfBirth) > '1990';

------------------------------------
--   q3
------------------------------------
SELECT COUNT(ID) AS totalNums
FROM Warranty
WHERE Type = 'Extended';

------------------------------------
--   q4
------------------------------------
SELECT date, SUM(amount) AS totalSales
FROM Transaction
WHERE paymentMethod <> 'cash'
GROUP BY date;

------------------------------------
--   q5
------------------------------------
SELECT DISTINCT Vendor.name
FROM Vendor, Sell, Product, ProductBelongToSubcategory, ProductSubcategory
WHERE Vendor.ID = Sell.vendorID AND
      Product.ID = Sell.productID AND
      Product.ID = ProductBelongToSubcategory.productID AND
      ProductSubcategory.ID = ProductBelongToSubcategory.productSubcategoryID AND
      ProductSubcategory.name = 'LED';

------------------------------------
--   q6a
------------------------------------
SELECT Vendor.name, COUNT(Sell.productID) AS totalNums
FROM Vendor, Sell
WHERE Vendor.ID = Sell.vendorID
GROUP BY Vendor.name;

------------------------------------
--   q6b
------------------------------------
SELECT Vendor.name, COUNT(Sell.productID) AS totalNums
FROM Vendor, Sell
WHERE Vendor.ID = Sell.vendorID
GROUP BY Vendor.name
HAVING COUNT(Sell.productID) > 35;

------------------------------------
--   q7a
------------------------------------
SELECT Vendor.ID, Vendor.name, Transaction.date, SUM(Transaction.quantity) AS totalSold
FROM Vendor, Transaction
WHERE Vendor.ID = Transaction.vendorID
GROUP BY Vendor.ID, Vendor.name,  Transaction.date
HAVING SUM(Transaction.quantity) > 10
ORDER BY Transaction.date, SUM(Transaction.quantity) ASC;

------------------------------------
--   q7b
------------------------------------
SELECT Vendor.ID, Vendor.name, Transaction.date, SUM(Transaction.amount) AS totalSales
FROM Vendor, Transaction
WHERE Vendor.ID = Transaction.vendorID
GROUP BY Vendor.ID, Vendor.name, Transaction.date
HAVING SUM(Transaction.amount) > 5000
ORDER BY Transaction.date, SUM(Transaction.amount) ASC;

------------------------------------
--   q8
------------------------------------
SELECT p1.lastName, p1.firstName, p1.dateOfBirth
FROM Person p1, Person p2
WHERE p1.dateOfBirth = p2.dateOfBirth AND
      p1.ID <> p2.ID;

------------------------------------
--   q9
------------------------------------
SELECT Person.firstName, Person.lastName, KeynoteSpeaker.areaOfExpertise
FROM Person, Attendee, ListenTo, KeynoteSpeaker
WHERE Person.ID = Attendee.ID AND
      Attendee.ID = ListenTo.attendeeID AND
      KeynoteSpeaker.ID = ListenTo.keynoteSpeakerID AND
      KeynoteSpeaker.areaOfExpertise IN ('Smartphones', 'Wearable Technology');

------------------------------------
--   q10a
------------------------------------
SELECT Product.ID, Product.modelNumber, Product.name
FROM Product, ProductTrial, Transaction
WHERE Product.ID = ProductTrial.productID AND
      Product.ID = Transaction.productID AND
      ProductTrial.attendeeID = Transaction.attendeeID;

------------------------------------
--   q10b
------------------------------------
SELECT Person.ID, Person.lastName, Person.firstName
FROM Person, ProductTrial
WHERE Person.ID = ProductTrial.attendeeID AND
      ProductTrial.minutesTried >= 10 AND
      ProductTrial.ProductID NOT IN (
        SELECT ProductID
        FROM Transaction
        WHERE AttendeeID = ProductTrial.attendeeID
      );

------------------------------------
--   q11
------------------------------------
SELECT DISTINCT Person.ID, Person.firstName, Person.lastName
FROM Person, Transaction t1, Transaction t2, Transaction t3
WHERE Person.ID = t1.attendeeID AND
      Person.ID = t2.attendeeID AND
      Person.ID = t3.attendeeID AND
      t1.date = '04/02/2014' AND
      t2.date = '04/03/2014' AND
      t3.date = '04/04/2014';

------------------------------------
--   q12
------------------------------------
SELECT MAX(totalSales) AS highesttotalSales
FROM (
	SELECT SUM(Transaction.amount) AS totalSales
        FROM ProductSubcategory, ProductBelongToSubcategory, Transaction 
        WHERE ProductSubcategory.ID = ProductBelongToSubcategory.productsubcategoryID AND
              Transaction.productID = ProductBelongToSubcategory.productID
        GROUP BY ProductSubcategory.ID
     );
