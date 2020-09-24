SELECT DISTINCT
       cab.nunota NUNOTA_4,
       cab.vlrnota VLRNOTA_4,
       origem.nunotaorig NUNOTA_3,
       cab_origem.vlrnota VLR_NOTA_3,
       origem_da_origem.nunotaorig NUNOTA_2,
       cab_origem_da_origem.vlrnota VLR_NOTA_2,
       origem_da_origem_da_origem.nunotaorig NUNOTA_1,
       cab_origem_da_origem_da_origem.vlrnota VLR_NOTA_ORIGEM_1
FROM tgfcab cab
LEFT JOIN tgfvar origem ON cab.nunota = origem.nunota
LEFT JOIN tgfcab cab_origem ON origem.nunotaorig = cab_origem.nunota
LEFT JOIN tgfvar origem_da_origem ON origem.nunotaorig = origem_da_origem.nunota
LEFT JOIN tgfcab cab_origem_da_origem ON origem_da_origem.nunotaorig = cab_origem_da_origem.nunota
LEFT JOIN tgfvar origem_da_origem_da_origem ON origem_da_origem.nunotaorig = origem_da_origem_da_origem.nunota
LEFT JOIN tgfcab cab_origem_da_origem_da_origem ON origem_da_origem_da_origem.nunotaorig = cab_origem_da_origem_da_origem.nunota
WHERE cab.tipmov = 'V'
AND origem_da_origem_da_origem.nunotaorig IS NOT NULL
ORDER BY cab.nunota DESC;
