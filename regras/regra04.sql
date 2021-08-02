/*
Regra	Classe 1					Deve	Topologia	Classe 2				Cardinalidade
04	    hid_trecho_massa_dagua_a	sim		contains	hid_trecho_drenagem_l	1..*
*/

CREATE TABLE tab01_rul04
AS
SELECT 
V.id AS id,
V.geom AS geom
--,'hid_trecho_massa_dagua_a deve conter pelo menos 1 feição da classe hid_trecho_drenagem_l' AS erro_msg
FROM(
	SELECT 
		C.id AS id, 
		C.geom AS geom, 
		sum(C.relation::int) AS n_elemts
	FROM(
		SELECT 
			T1.id AS id,
			T1.geom AS geom,
			st_contains(T1.geom, T2.geom) AS relation -- relação topológica
		FROM cb.hid_trecho_massa_dagua_a T1, cb.hid_trecho_drenagem_l T2 -- classes
		) C
	GROUP BY C.id, C.geom
) V
WHERE n_elemts = 0; -- cardinalidade