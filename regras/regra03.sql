/*
Regra	Classe 1					Deve	Topologia	Classe 2				Cardinalidade
03	    hid_trecho_drenagem_l		sim		within		hid_ponto_drenagem_p	2..2
*/

CREATE TABLE tab01_rul03
AS
SELECT 
V.id AS id,
V.geom AS geom
--,'hid_trecho_drenagem_l deve tocar exatamente 2 feições da classe hid_ponto_drenagem_p' AS erro_msg
FROM(
	SELECT 
		C.id AS id, 
		C.geom AS geom, 
		sum(C.relation::int) AS n_elemts
	FROM(
		SELECT 
			T1.id AS id,
			T1.geom AS geom,
			st_touches(T1.geom, T2.geom) AS relation -- relação topológica
		FROM cb.hid_trecho_drenagem_l T1, cb.hid_ponto_drenagem_p T2 -- classes
		) C
	GROUP BY C.id, C.geom
) V
WHERE n_elemts <> 2; -- cardinalidade