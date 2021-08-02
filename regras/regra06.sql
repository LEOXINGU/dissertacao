/*
Regra	Classe 1					Deve	Topologia	Classe 2				Cardinalidade
06	    hid_ponto_drenagem_p		não		within		hid_massa_dagua_a		1..*
*/

CREATE TABLE tab01_rul06
AS
SELECT 
V.id AS id,
V.geom AS geom
--,'hid_ponto_drenagem_p NÃO deve estar dentro de mais de 0 feição da classe hid_massa_dagua_a' AS erro_msg
FROM(
	SELECT 
		C.id AS id, 
		C.geom AS geom, 
		sum(C.relation::int) AS n_elemts
	FROM(
		SELECT 
			T1.id AS id,
			T1.geom AS geom,
			st_within(T1.geom, T2.geom) AS relation -- relação topológica
		FROM cb.hid_ponto_drenagem_p T1, cb.hid_massa_dagua_a T2 -- classes
		) C
	GROUP BY C.id, C.geom
) V
WHERE n_elemts > 0;  -- cardinalidade