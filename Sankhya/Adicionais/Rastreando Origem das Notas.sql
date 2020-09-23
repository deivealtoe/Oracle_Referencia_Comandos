SELECT cab.nunota,
       origem.nunotaorig ORIDEM,
       origem_da_origem.nunotaorig ORIGEM_DA_ORIGEM,
       origem_da_origem_da_origem.nunotaorig ORIGEM_DA_ORIGEM_DA_ORIGEM
FROM tgfcab cab
LEFT JOIN tgfvar origem ON cab.nunota = origem.nunota
LEFT JOIN tgfvar origem_da_origem ON origem.nunotaorig = origem_da_origem.nunota
LEFT JOIN tgfvar origem_da_origem_da_origem ON origem_da_origem.nunotaorig = origem_da_origem_da_origem.nunota
WHERE cab.tipmov = 'V'
ORDER BY cab.nunota;
