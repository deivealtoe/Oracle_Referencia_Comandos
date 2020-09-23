CREATE OR REPLACE PROCEDURE STP_VAL_LIMITECREDITO (
     P_NUNOTA INT,
     P_SUCESSO OUT VARCHAR2,
     P_MENSAGEM OUT VARCHAR2,
     P_LIBERADOR OUT INT)
AS
BEGIN
  DECLARE
     P_VALIDALIMITE VARCHAR2(10);

  BEGIN
            SELECT CASE WHEN valor_nota.vlrnota + NVL(valor_em_aberto.vlr_em_aberto, 0) > limite_parceiro.limcred
                        THEN 'N'
                        ELSE 'L'
                   END VALIDA INTO P_VALIDALIMITE
            FROM
            (
                    SELECT codparc CODPARCNOTA,
                           nunota,
                           vlrnota
                    FROM tgfcab cab
                    WHERE cab.nunota = P_NUNOTA/*BOTAR PARÂMETRO DA NOTA AQUI P_NUNOTA*/
            ) valor_nota
            LEFT JOIN
            (
                    SELECT codparc CODPARCLIMCRED,
                           NVL(limcred, 0) LIMCRED --CASO O PARCEIRO NÃO TENHA LIMITE DE CRÉDITO CADASTRADO, CONSIDERAR VALOR MÁXIMO E LIBERAR
                    FROM tgfpar
            ) limite_parceiro
            ON valor_nota.codparcnota = limite_parceiro.codparclimcred
            LEFT JOIN
            (
                    SELECT fin.codparc CODPARCFIN,
                           NVL(SUM(fin.vlrdesdob - fin.vlrdesc), 0) VLR_EM_ABERTO -- NVL PARA CASO DE O PARCEIRO NÃO TIVER NADA EM ABERTO NA TABELA TGFFIN TELA MOVIMENTAÇÃO FINANCEIRA
                    FROM tgffin fin
                    WHERE fin.dhbaixa IS NULL
                    AND fin.codparc = (SELECT codparc FROM tgfcab WHERE nunota = P_NUNOTA/*BOTAR PARÂMETRO DA NOTA AQUI P_NUNOTA*/)
                    AND recdesp = 1
                    AND provisao = 'N'
                    GROUP BY fin.codparc
            ) valor_em_aberto
            ON valor_nota.codparcnota = valor_em_aberto.codparcfin;

	IF P_VALIDALIMITE = 'N' THEN 
	   P_SUCESSO := 'N';
	   P_MENSAGEM := 'O cliente ultrapassou seu limite de crédito.';
	ELSE
	   P_SUCESSO := 'S';
	END IF;
  END;
END;
