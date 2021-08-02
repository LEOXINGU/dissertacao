/*
Regra	Classe 1					Deve	Topologia	Classe 2				Cardinalidade
01	    hid_trecho_drenagem_l		sim		touches		hid_massa_dagua_a		0..1
*/

CREATE TABLE tab01_rul01
AS
SELECT 
V.id AS id,
V.geom AS geom
--,'hid_trecho_drenagem_l deve tocar 0 ou 1 feição da classe hid_massa_dagua_a' AS erro_msg
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
		FROM cb.hid_trecho_drenagem_l T1, cb.hid_massa_dagua_a T2 -- classes
		) C
	GROUP BY C.id, C.geom
) V
WHERE n_elemts > 1; -- cardinalidade