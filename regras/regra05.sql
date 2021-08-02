/*
Regra	Classe 1					Deve	Topologia	Classe 2				Cardinalidade
05	    hid_ponto_drenagem_p		sim		touches		hid_trecho_drenagem_l	1..*
*/

CREATE TABLE tab01_rul05
AS
SELECT 
V.id AS id,
V.geom AS geom
--,'hid_ponto_drenagem_p deve tocar pelo menos 1 feição da classe hid_trecho_drenagem_l' AS erro_msg
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
		FROM cb.hid_ponto_drenagem_p T1, cb.hid_trecho_drenagem_l T2 -- classes
		) C
	GROUP BY C.id, C.geom
) V
WHERE n_elemts = 0;  -- cardinalidade