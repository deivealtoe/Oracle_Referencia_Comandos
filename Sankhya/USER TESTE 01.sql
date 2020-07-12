SELECT mixes.fabricante,
       mixes.mixcli,
       metamixcli.prevrec METAMIXCLI,
       mixes.mixprod,
       metamixprod.prevrec METAMIXPROD
FROM
(
		SELECT fabricante,
		       COUNT(DISTINCT codparc) MIXCLI,
		       COUNT(DISTINCT codprod) MIXPROD
		FROM
		(
		        SELECT vendido.fabricante,
		               vendido.codparc,
		               vendido.nomeparc,
		               vendido.codprod,
		               vendido.descrprod,
		               NVL(vendido.qtdneg, 0) QTDVEND,
		               NVL(devolvido.qtdneg, 0) QTDDEVOL,
		               NVL(vendido.qtdneg, 0) - NVL(devolvido.qtdneg, 0) QTDNEGLIQ
		        FROM
		        (
		                SELECT fabricante,
		                       codparc,
		                       nomeparc,
		                       codprod,
		                       descrprod,
		                       qtdneg
		                FROM simples_itens_da_nota
		                WHERE codtipoper IN (1101, 1010)
		                AND dtneg BETWEEN TO_DATE('01/05/20', 'DD/MM/YY')/*:P_PERIODO.INI*/ AND TO_DATE('31/05/20', 'DD/MM/YY')/*:P_PERIODO.FIN*/
		                AND statusnota = 'L'
		                --AND fabricante IN :P_FORNECEDORES
		                --AND codemp IN :P_EMPRESA
		                ORDER BY 1, 2
		        ) vendido
		        LEFT JOIN
		        (
		                SELECT fabricante,
		                       codparc,
		                       nomeparc,
		                       codprod,
		                       descrprod,
		                       qtdneg
		                FROM simples_itens_da_nota
		                WHERE codtipoper IN (1201, 1202, 1204)
		                AND dtmov BETWEEN TO_DATE('01/05/20', 'DD/MM/YY')/*:P_PERIODO.INI*/ AND TO_DATE('31/05/20', 'DD/MM/YY')/*:P_PERIODO.FIN*/
		                AND statusnota = 'L'
		                --AND fabricante IN :P_FORNECEDORES
		                --AND codemp IN :P_EMPRESA
		                ORDER BY 1, 2
		        ) devolvido
		        ON vendido.fabricante = devolvido.fabricante
		        AND vendido.codparc = devolvido.codparc
		        AND vendido.codprod = devolvido.codprod
		        WHERE NVL(vendido.qtdneg, 0) - NVL(devolvido.qtdneg, 0) > 0
		)
		GROUP BY fabricante
) mixes
LEFT JOIN
(
        SELECT fabricante,
               dtref,
               prevrec
        FROM meta_mix_clientes_fabricantes
        WHERE dtref = TRUNC(TO_DATE('01/05/20', 'DD/MM/YY'/*:P_PERIODO.INI*/), 'MM')
        --AND fabricante IN :P_FORNECEDORES
) metamixcli
ON mixes.fabricante = metamixcli.fabricante
LEFT JOIN
(
        SELECT fabricante,
               dtref,
               prevrec
        FROM meta_mix_produtos_fabricantes
        WHERE dtref = TRUNC(TO_DATE('01/05/20', 'DD/MM/YY'/*:P_PERIODO.INI*/), 'MM')
        --AND fabricante IN :P_FORNECEDORES
) metamixprod
ON mixes.fabricante = metamixprod.fabricante
ORDER BY 3 DESC;


