CREATE OR REPLACE PROCEDURE STP_VAL_ATRASO (
     P_NUNOTA INT,
     P_SUCESSO OUT VARCHAR2,
     P_MENSAGEM OUT VARCHAR2,
     P_LIBERADOR OUT INT)
AS
BEGIN
  DECLARE
     P_VALIDAATRASO VARCHAR2(10);

  BEGIN
            SELECT CASE WHEN NVL(qtdematraso.qtdematraso, 0) > 0
                            THEN 'N'
                        ELSE 'L'
                   END VALIDAATRASO INTO P_VALIDAATRASO
            FROM
            (
                    SELECT codparc
                    FROM tgfcab
                    WHERE nunota = P_NUNOTA
            ) codparc
            LEFT JOIN
            (
                    SELECT fin.codparc CODPARCQTDEMATRASO,
                           COUNT(nufinmax.nufin) QTDEMATRASO
                    FROM
                    (
                            SELECT nufin
                              FROM tgffin
                             WHERE codparc = (SELECT codparc FROM tgfcab WHERE nunota = P_NUNOTA)
                               AND dtvenc < (SELECT dtneg - 5 FROM tgfcab WHERE nunota = P_NUNOTA)
                               AND recdesp = 1
                               AND provisao = 'N'
                               AND dhbaixa IS NULL
                    ) nufinmax
                    INNER JOIN tgffin fin ON nufinmax.nufin = fin.nufin
                    WHERE dhbaixa IS NULL
                    GROUP BY fin.codparc
            ) qtdematraso
            ON codparc.codparc = qtdematraso.codparcqtdematraso;

	IF P_VALIDAATRASO = 'N' THEN 
	   P_SUCESSO := 'N';
	   P_MENSAGEM := 'O cliente possui títulos em atraso.';
	ELSE
	   P_SUCESSO := 'S';
	END IF;
  END;
END;
