-- Bom para ser criado como uma VIEW

SELECT
    ite.codprod,
    ite.vlrunit
FROM
    tgfite ite
WHERE
    ite.nunota = (
        SELECT
            MAX(cab.nunota)
        FROM
            tgfcab   cab
            INNER JOIN tgfite   itein ON cab.nunota = itein.nunota
        WHERE
            itein.codprod = ite.codprod
            AND cab.tipmov = 'C'
            AND cab.statusnota = 'L'
    )
ORDER BY
    ite.codprod;
