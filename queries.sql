USE Detailist;

# List all customers and their email addresses.

SELECT name AS Name, email AS Email
FROM Kunde;

# Show all articles with their current stock and minimum stock.

SELECT bestand AS Bestand, mindestbestand AS Mindestbestand
FROM Artikel;
# SELECT COUNT(*) AS 'Anzahl Artikel' FROM Artikel;

# Find all orders (Bestellung) with their order date and delivery date.

SELECT bestell_nr, bestell_datum, liefer_datum
FROM Bestellung;

# List all order positions (Bestellposition) for a specific order, including article name and quantity.

SELECT bp.bestell_nr AS BestellNr, a.bezeichnung AS Artikelname, bp.menge AS Bestellmenge
FROM Bestellposition bp
JOIN Artikel a ON bp.artikel_nr = a.artikel_nr
WHERE bp.bestell_nr = 1;

# Show all articles with their VAT rate (MWStSatz).

SELECT * FROM Artikel a
JOIN MWStSatz m ON a.art_mwst = m.mwst_art
ORDER BY a.art_mwst;

# Find customers who have placed at least one order.

SELECT DISTINCT k.kunden_nr, k.name, k.email
FROM Kunde k
JOIN Bestellung b ON k.kunden_nr = b.kunden_nr;

# With a LEFT JOIN, the table on the left (before LEFT JOIN) is the main table whose rows you always want to include.
# In your example, Kunde is on the left, so you get all customers, and any matching orders from Bestellung.
# If a customer has no order, the order columns will be NULL.

# List all orders that have not been delivered yet (liefer_datum is NULL).

SELECT *
FROM Bestellung
WHERE liefer_datum IS NULL;

# Show the total quantity ordered for each article.

SELECT a.artikel_nr as ArtikelNr, COUNT(bp.artikel_nr) as Bestelltotal
FROM Artikel a
LEFT JOIN Bestellposition bp ON a.artikel_nr = bp.artikel_nr
GROUP BY a.artikel_nr;

# Find the IBAN and BIC for each customer.

SELECT k.kunden_nr, g.iban, g.bic
FROM Kunde k
JOIN Girokonto g ON k.kunden_nr = g.kunden_nr;

# List all articles where the stock is below the minimum stock.

SELECT *
FROM Artikel
WHERE bestand < mindestbestand;

# is it true that the bestellposition doesnt need a reference to the mwst since it already has it via artikel?

# Yes, that's correct. The Bestellposition table references Artikel, which in turn references MWStSatz.
# So, Bestellposition does not need a direct reference to MWStSatz—the relationship is already established through Artikel.
# This keeps the schema normalized and avoids redundancy.

# but this would require two joins if I wanted to find the mwst of the articles of my order for example?

# Correct. To get the mwst_satz for the articles in an order, you need to join Bestellposition to Artikel, and then Artikel to MWStSatz. Here’s how you can do it:
#
# This query gets the VAT rate (mwst_satz) for each article in a specific order:

SELECT bp.bestellpos_nr, a.bezeichnung, m.mwst_satz
FROM Bestellposition bp
    JOIN Artikel a ON bp.artikel_nr = a.artikel_nr
    JOIN MWStSatz m ON a.art_mwst = m.mwst_art
WHERE bp.bestell_nr = 1;