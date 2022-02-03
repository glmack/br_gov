CREATE DATABASE br_geo 
WITH ENCODING 'UTF8'
LC_COLLATE = 'pt_BR.UTF-8' 
LC_CTYPE = 'pt_BR.UTF-8' 
TEMPLATE = template0;


CREATE TABLE municipios_dtb_2020
(
    codigo_municipio_completo int,
    nome_municipio text,
    uf_id int,
    uf_nome text,
    regiao_intermediaria_id int,
    regiao_intermediaria_nome text,
    regiao_imediata_id int,
    regiao_imediata_nome text,
    mesorregiao_id int,
    mesorregiao_nome text,
    microrregiao_id int,
    microrregiao_nome text,
    municipio int
);

-- create table from DTB_2020_V2, the v.2 Divisao Territorial do Brasil database of 2020
COPY municipios_dtb_2020
FROM '/Users/lee/Documents/code/br_gov/data/DTB_2020_v2/dtb_2020_municipio.csv'
WITH CSV DELIMITER ','
ENCODING 'UTF8' HEADER;

-- create table of distinct unidades federais do Brasil from dtb 2020 v2
CREATE TABLE uf AS
  SELECT distinct(uf_id), uf_nome
  FROM municipios_dtb_2020
  ORDER BY uf_nome;

-- create table of data on cities from regic report 2018 by ibge
CREATE TABLE cidades_regic_2018_v2
(
    COD_UF int,
    UF text,
    COD_CIDADE int,
    NOME_CIDADE text,
    VAR01 int,
    VAR02 numeric,
    VAR03 int,
    VAR04 int,
    VAR05 int,
    VAR06 int,
    VAR07 int,
    VAR08 int,
    VAR09 text,
    VAR10 text,
    VAR11 text,
    VAR12 text,
    VAR13 int,
    VAR14 text,
    VAR15 text,
    VAR16 text,
    VAR17 text,
    VAR18 int,
    VAR19 numeric,
    VAR20 numeric,
    VAR21 numeric,
    VAR22 text,
    VAR23 int,
    VAR24 int,
    VAR25 int,
    VAR26 int,
    VAR27 int,
    VAR28 text,
    VAR29 int,
    VAR30 int,
    VAR31 int,
    VAR32 int,
    VAR33 int,
    VAR34 int,
    VAR35 int,
    VAR36 int,
    VAR37 int,
    VAR38 int,
    VAR39 int,
    VAR40 int,
    VAR41 int,
    VAR42 int,
    VAR43 int,
    VAR44 int,
    VAR45 int,
    VAR46 int,
    VAR47 int,
    VAR48 int,
    VAR49 int,
    VAR50 int,
    VAR51 int,
    VAR52 int,
    VAR53 int,
    VAR54 int,
    VAR55 text,
    VAR56 numeric,
    VAR57 numeric,
    VAR58 numeric,
    VAR59 numeric,
    VAR60 numeric,
    VAR61 numeric,
    VAR62 numeric,
    VAR63 numeric,
    VAR64 numeric,
    VAR65 numeric,
    VAR66 numeric,
    VAR67 numeric,
    VAR68 numeric,
    VAR69 numeric,
    VAR70 numeric,
    VAR71 numeric,
    VAR72 numeric,
    VAR73 numeric,
    VAR74 numeric,
    VAR75 numeric,
    VAR76 numeric,
    VAR77 int,
    VAR78 text,
    VAR79 int,
    VAR80 numeric,
    VAR81 int,
    VAR82 numeric,
    VAR83 numeric,
    VAR84 int,
    VAR85 int,
    VAR86 int,
    VAR87 int,
    VAR88 int,
    VAR89 int,
    VAR90 int,
    VAR91 int,
    VAR92 int,
    VAR93 int,
    VAR94 int,
    VAR95 numeric,
    VAR96 int,
    VAR97 numeric,
    VAR98 int,
    VAR99 numeric,
    VAR100 numeric,
    VAR101 numeric,
    VAR102 numeric
);

COPY cidades_regic_2018_v2
FROM '/Users/lee/Documents/code/br_gov/data/regic2018_cidades_v2.csv'
WITH CSV DELIMITER ','
ENCODING 'UTF8' HEADER;


CREATE TABLE populated_places_geonet
(
    RC int,
    UFI int,
    UNI int,
    LAT numeric,
    LONG numeric,
    DMS_LAT text,
    DMS_LONG text,
    MGRS text,
    JOG text,
    FC text,
    DSG text,
    PC text,
    CC1 text,
    ADM1 int,
    POP int,
    ELEV int,
    CC2 text,
    NT text,
    LC text,
    SHORT_FORM text,
    GENERIC text,
    SORT_NAME_RO text,
    FULL_NAME_RO text,
    FULL_NAME_ND_RO text,
    SORT_NAME_RG text,
    FULL_NAME_RG text,
    FULL_NAME_ND_RG text,
    NOTE text,
    MODIFY_DATE date,
    DISPLAY text,
    NAME_RANK int,
    NAME_LINK text,
    TRANSL_CD text,
    NM_MODIFY_DATE date,
    F_EFCTV_DT text,
    F_TERM_DT text
);

COPY populated_places_geonet
FROM '/Users/lee/Documents/code/br_gov/data/geonet_br/br_populatedplaces_p.txt'
WITH DELIMITER E'\t'
ENCODING 'UTF8' -- confirm
CSV HEADER;

CREATE TABLE place_names_br_bcim
(
    id_lista_nome_geo int,
    nome_geografico text,
    sigla_categoria text,
    nm_classe text,
    sigla_pais text,
    sigla_unid_federacao text,
    latitude numeric,
    longitude numeric,
    tp_geom text
);

COPY place_names_br_bcim
FROM '/Users/lee/Documents/code/br_gov/data/bcim/bcim_2016_nomesgeograficos_18_09_2018.csv'
WITH CSV DELIMITER ';'
ENCODING 'UTF8' HEADER;

--
CREATE TABLE geonames_br
(
    geonameid int, --integer id of record in geonames database
    geoname text, --name of geographical point (utf8), varchar(200)
    asciiname text, --name of geographical point in plain ascii characters, varchar(200)
    altnames text, -- alternate names, comma separated, ascii, varchar(10000)
    latitude numeric, --latitude in decimal degrees, (wgs84)
    longitude numeric, --longitude in decimal degrees, (wgs84)
    feature_class text, --see http://www.geonames.org/export/codes.html, char(1)
    feature_code text, --see http://www.geonames.org/export/codes.html, varchar(10)
    country_code text, --ISO-3166 2-letter country code, 2 characters
    altcountrynames text, --alternate comma-separated country codes, ISO-3166, 200 characters
    adm1_code int, --fipscode (subject to change to iso code) varchar(20)
    adm2_code int, --code for 2nd administrative division, a county in the US; varchar(80) 
    adm3_code text, --code for 3rd level administrative division, varchar(20)
    adm4_code text, --code for 4th level administrative division, varchar(20)
    population int, --bigint (8 byte int) 
    elevation int, --in meters, integer
    dem int, --digital elevation model, average elevation in meters, srtm3 or gtopo30, srtm processed by cgiar/ciat
    timezone text, --the iana timezone id (see file timeZone.txt) varchar(40)
    modification date --date of last modification in yyyy-MM-dd format
);

--TODO (Lee): Fix error from workaround in copy, with csv header
-- postgres doesn't like the first line: '3375720	Tawaribar Rapids' without csv header
-- I omitted first line as temp workaround
COPY geonames_br
FROM '/Users/lee/Documents/code/br_gov/data/geonames_br/BR.txt'
WITH DELIMITER E'\t'
ENCODING 'UTF8'
CSV HEADER; -- confirm


-- TODO (Lee) - details steps re: utf bom of csv preceding uf_id join below


-- add column and, add uf id from join results
ALTER TABLE trechos
ADD COLUMN origem_uf_id INT,
ADD COLUMN destino_uf_id INT;

-- update origem_uf_id with results of join to uf_dtb_2020 for Br states, origem
update trechos 
set origem_uf_id = uf_dtb_2020.uf_id
from uf_dtb_2020 where trechos.origem_uf = uf_dtb_2020.uf_nome;

-- update destino_uf_id with results of join to uf_dtb_2020 for Br states, destino
update trechos 
set destino_uf_id = uf_dtb_2020.uf_id
from uf_dtb_2020 where trechos.destino_uf = uf_dtb_2020.uf_nome;

-- TODO (Lee) deal with nulls/missingness cat column for uf_id for destino, origem

-- municipios

ALTER TABLE trechos
ADD COLUMN orig_cidade_id INT,
ADD COLUMN dest_cidade_id INT;

SELECT count(*)
FROM trechos, municipios_dtb_2020
WHERE trechos.origem_cidade = municipios_dtb_2020.nome_municipio;

--test
SELECT trechos.origem_cidade, trechos.origem_uf, municipios_dtb_2020.nome_municipio, municipios_dtb_2020.uf_id
  FROM trechos 
  LEFT 
  JOIN municipios_dtb_2020 
    ON trechos.origem_cidade = municipios_dtb_2020.nome_municipio AND trechos.origem_uf_id = municipios_dtb_2020.uf_id
 WHERE trechos.origem_pais = 'Brasil' AND trechos.origem_cidade IS NULL;


 -- TODO (Lee): no matches, will require: 1) separating district from municip, 2) fuzzy match with one char or
-- accent differences, 3)?
brgmob=# SELECT distinct(trechos.origem_cidade, trechos.origem_uf)
  FROM trechos                                              
  LEFT 
  OUTER JOIN municipios_dtb_2020 
    ON trechos.origem_cidade = municipios_dtb_2020.nome_municipio AND trechos.origem_uf_id = municipios_dtb_2020.uf_id
 WHERE trechos.origem_pais = 'Brasil' AND municipios_dtb_2020.nome_municipio IS NULL LIMIT 1000;
-- -[ RECORD 1 ]--------------------------------------------
-- row | (Acarapé,Ceará)
-- -[ RECORD 2 ]--------------------------------------------
-- row | (Acégua,"Rio Grande do Sul")
-- -[ RECORD 3 ]--------------------------------------------
-- row | ("Almeirim - Monte Dourado",Pará)
-- -[ RECORD 4 ]--------------------------------------------
-- row | ("Alta Floresta do Oeste",Rondônia)
-- -[ RECORD 5 ]--------------------------------------------
-- row | ("Altamira - Castelo de Sonhos",Pará)
-- -[ RECORD 6 ]--------------------------------------------
-- row | ("Alto Paraíso de Goiás - São Jorge",Goiás)
-- -[ RECORD 7 ]--------------------------------------------
-- row | ("Alvorada do Oeste",Rondônia)
-- -[ RECORD 8 ]--------------------------------------------
-- row | (Amambaí,"Mato Grosso do Sul")
-- -[ RECORD 9 ]--------------------------------------------
-- row | ("Americo de Campos","São Paulo")
-- -[ RECORD 10 ]-------------------------------------------
-- row | ("Amparo da Serra","Minas Gerais")
-- -[ RECORD 11 ]-------------------------------------------
-- row | ("Amparo de São Francisco",Sergipe)
-- -[ RECORD 12 ]-------------------------------------------
-- row | ("Aparecida D,Oeste","São Paulo")
-- -[ RECORD 13 ]-------------------------------------------
-- row | (Aracatú,Bahia)
-- -[ RECORD 14 ]-------------------------------------------
-- row | (Araçoiaba,Ceará)
-- -[ RECORD 15 ]-------------------------------------------
-- row | (Araguaia,"Mato Grosso")
-- -[ RECORD 16 ]-------------------------------------------
-- row | ("Arquipélago de São Pedro e São Paulo",Pernambuco)
-- -[ RECORD 17 ]-------------------------------------------
-- row | ("Arquipélago do Bailique",Amapá)
-- -[ RECORD 18 ]-------------------------------------------
-- row | ("Atilio Vivacqua","Espírito Santo")
-- -[ RECORD 19 ]-------------------------------------------
-- row | ("Augusto Severo","Rio Grande do Norte")
-- -[ RECORD 20 ]-------------------------------------------
-- row | ("Barra D,Alcântara",Piauí)
-- -[ RECORD 21 ]-------------------------------------------
-- row | (Barreiros,Piauí)
-- -[ RECORD 22 ]-------------------------------------------
-- row | ("Bela Vista do Caroba",Paraná)
-- -[ RECORD 23 ]-------------------------------------------
-- row | ("Belém de São Francisco",Pernambuco)
-- -[ RECORD 24 ]-------------------------------------------
-- row | (Biritiba-Mirim,"São Paulo")
-- -[ RECORD 25 ]-------------------------------------------
-- row | (Bocaína,Piauí)
-- -[ RECORD 26 ]-------------------------------------------
-- row | (Brasópolis,"Minas Gerais")
-- -[ RECORD 27 ]-------------------------------------------
-- row | (Brodósqui,"São Paulo")
-- -[ RECORD 28 ]-------------------------------------------
-- row | ("Brumado - Itaquaraí",Bahia)
-- -[ RECORD 29 ]-------------------------------------------
-- row | (Cabo,Pernambuco)
-- -[ RECORD 30 ]-------------------------------------------
-- row | (Cambirá,Paraná)
-- -[ RECORD 31 ]-------------------------------------------
-- row | ("Campo Limpo Goiás",Goiás)
-- -[ RECORD 32 ]-------------------------------------------
-- row | ("Campo de Santana",Paraíba)
-- -[ RECORD 33 ]-------------------------------------------
-- row | ("Cerro Cora","Rio Grande do Norte")
-- -[ RECORD 34 ]-------------------------------------------
-- row | (Chiapeta,"Rio Grande do Sul")
-- -[ RECORD 35 ]-------------------------------------------
-- row | ("Cidade de Goiás",Goiás)
-- -[ RECORD 36 ]-------------------------------------------
-- row | ("Conceição da Barra - Itaúnas","Espírito Santo")
-- -[ RECORD 37 ]-------------------------------------------
-- row | ("Conquista D,Oeste","Mato Grosso")
-- -[ RECORD 38 ]-------------------------------------------
-- row | ("Conselheiro Mairynck",Paraná)
-- -[ RECORD 39 ]-------------------------------------------
-- row | ("Couto de Magalhães",Tocantins)
-- -[ RECORD 40 ]-------------------------------------------
-- row | (Cristais,"São Paulo")
-- -[ RECORD 41 ]-------------------------------------------
-- row | (Curuca,Pará)
-- -[ RECORD 42 ]-------------------------------------------
-- row | ("Diamante do Oeste",Paraná)
-- -[ RECORD 43 ]-------------------------------------------
-- row | ("Dias D,Ávila",Bahia)
-- -[ RECORD 44 ]-------------------------------------------
-- row | ("Eldorado dos Carajás",Pará)
-- -[ RECORD 45 ]-------------------------------------------
-- row | (Embu,"São Paulo")
-- -[ RECORD 46 ]-------------------------------------------
-- row | (Ererê,Ceará)
-- -[ RECORD 47 ]-------------------------------------------
-- row | ("Estrela D,Oeste","São Paulo")
-- -[ RECORD 48 ]-------------------------------------------
-- row | ("Figueirópolis D,Oeste","Mato Grosso")
-- -[ RECORD 49 ]-------------------------------------------
-- row | ("Fortaleza do Tabocão",Tocantins)
-- -[ RECORD 50 ]-------------------------------------------
-- row | ("Francisco Macêdo",Piauí)
-- -[ RECORD 51 ]-------------------------------------------
-- row | ("Glória D,Oeste","Mato Grosso")
-- -[ RECORD 52 ]-------------------------------------------
-- row | (Goio-Erê,Paraná)
-- -[ RECORD 53 ]-------------------------------------------
-- row | (Gouvêa,"Minas Gerais")
-- -[ RECORD 54 ]-------------------------------------------
-- row | ("Governador Lindemberg","Espírito Santo")
-- -[ RECORD 55 ]-------------------------------------------
-- row | ("Governador Newton Belo",Maranhão)
-- -[ RECORD 56 ]-------------------------------------------
-- row | ("Grão Pará","Santa Catarina")
-- -[ RECORD 57 ]-------------------------------------------
-- row | (Guaimbé,"São Paulo")
-- -[ RECORD 58 ]-------------------------------------------
-- row | ("Guarani D,Oeste","São Paulo")
-- -[ RECORD 59 ]-------------------------------------------
-- row | (Guaraniaçú,Paraná)
-- -[ RECORD 60 ]-------------------------------------------
-- row | ("Herval D,Oeste","Santa Catarina")
-- -[ RECORD 61 ]-------------------------------------------
-- row | (Iguaraci,Pernambuco)
-- -[ RECORD 62 ]-------------------------------------------
-- row | ("Ilha Grande","Rio de Janeiro")
-- -[ RECORD 63 ]-------------------------------------------
-- row | (Ipauçu,"São Paulo")
-- -[ RECORD 64 ]-------------------------------------------
-- row | (Irati,Pará)
-- -[ RECORD 65 ]-------------------------------------------
-- row | (Itacuruçá,"Rio de Janeiro")
-- -[ RECORD 66 ]-------------------------------------------
-- row | (Itaipava,"Rio de Janeiro")
-- -[ RECORD 67 ]-------------------------------------------
-- row | (Itajuipi,Bahia)
-- -[ RECORD 68 ]-------------------------------------------
-- row | (Itamarajú,Bahia)
-- -[ RECORD 69 ]-------------------------------------------
-- row | (Itaóca,"São Paulo")
-- -[ RECORD 70 ]-------------------------------------------
-- row | (Itapagé,Ceará)
-- -[ RECORD 71 ]-------------------------------------------
-- row | ("Itapejara D,Oeste",Paraná)
-- -[ RECORD 72 ]-------------------------------------------
-- row | ("Itaperuna - Raposo","Rio de Janeiro")
-- -[ RECORD 73 ]-------------------------------------------
-- row | (Itapiuna,Ceará)
-- -[ RECORD 74 ]-------------------------------------------
-- row | ("Itaporanga D,Ajuda",Sergipe)
-- -[ RECORD 75 ]-------------------------------------------
-- row | ("Itauna do Sul",Paraná)
-- -[ RECORD 76 ]-------------------------------------------
-- row | (Jaicos,Piauí)
-- -[ RECORD 77 ]-------------------------------------------
-- row | ("Lagoa Danta","Rio Grande do Norte")
-- -[ RECORD 78 ]-------------------------------------------
-- row | ("Lagoa do Itaenga",Pernambuco)
-- -[ RECORD 79 ]-------------------------------------------
-- row | ("Lambari D,Oeste","Mato Grosso")
-- -[ RECORD 80 ]-------------------------------------------
-- row | ("Lauro Muller","Santa Catarina")
-- -[ RECORD 81 ]-------------------------------------------
-- row | (Maçambara,"Rio Grande do Sul")
-- -[ RECORD 82 ]-------------------------------------------
-- row | ("Machadinho D,Oeste",Rondônia)
-- -[ RECORD 83 ]-------------------------------------------
-- row | ("Mãe D,Água",Paraíba)
-- -[ RECORD 84 ]-------------------------------------------
-- row | (Marataizes,"Espírito Santo")
-- -[ RECORD 85 ]-------------------------------------------
-- row | ("Mirassol D,Oeste","Mato Grosso")
-- -[ RECORD 86 ]-------------------------------------------
-- row | (Mogi-Guaçú,"São Paulo")
-- -[ RECORD 87 ]-------------------------------------------
-- row | ("Moji Mirim","São Paulo")
-- -[ RECORD 88 ]-------------------------------------------
-- row | ("Morro Cabeça No Tempo",Piauí)
-- -[ RECORD 89 ]-------------------------------------------
-- row | ("Munhoz de Mello",Paraná)
-- -[ RECORD 90 ]-------------------------------------------
-- row | (Normândia,Roraima)
-- -[ RECORD 91 ]-------------------------------------------
-- row | ("Nova Brasilândia D,Oeste",Rondônia)
-- -[ RECORD 92 ]-------------------------------------------
-- row | ("Olho D,Água",Paraíba)
-- -[ RECORD 93 ]-------------------------------------------
-- row | ("Olho D,Água Grande",Alagoas)
-- -[ RECORD 94 ]-------------------------------------------
-- row | ("Olho D,Água das Cunhãs",Maranhão)
-- -[ RECORD 95 ]-------------------------------------------
-- row | ("Olho D,Água das Flores",Alagoas)
-- -[ RECORD 96 ]-------------------------------------------
-- row | ("Olho D,Água do Borges","Rio Grande do Norte")
-- -[ RECORD 97 ]-------------------------------------------
-- row | ("Olho D,Água do Casado",Alagoas)
-- -[ RECORD 98 ]-------------------------------------------
-- row | ("Olho D,Água do Piauí",Piauí)
-- -[ RECORD 99 ]-------------------------------------------
-- row | ("Olhos D,Água","Minas Gerais")
-- -[ RECORD 100 ]------------------------------------------
-- row | ("Oriximiná - Porto Trombetas",Pará)
-- -[ RECORD 101 ]------------------------------------------
-- row | ("Palmeira D,Oeste","São Paulo")
-- -[ RECORD 102 ]------------------------------------------
-- row | ("Palmeira do Tocantins",Tocantins)
-- -[ RECORD 103 ]------------------------------------------
-- row | ("Pântano Grande","Rio Grande do Sul")
-- -[ RECORD 104 ]------------------------------------------
-- row | (Parati,"Rio de Janeiro")
-- -[ RECORD 105 ]------------------------------------------
-- row | (Parau,"Rio Grande do Norte")
-- -[ RECORD 106 ]------------------------------------------
-- row | (Parauapebas/Carajás,Pará)
-- -[ RECORD 107 ]------------------------------------------
-- row | ("Parque Nacionaliba",Piauí)
-- -[ RECORD 108 ]------------------------------------------
-- row | ("Passo do Camaragibe",Alagoas)
-- -[ RECORD 109 ]------------------------------------------
-- row | (Passos,Maranhão)
-- -[ RECORD 110 ]------------------------------------------
-- row | ("Patrocínio de Muriaé","Minas Gerais")
-- -[ RECORD 111 ]------------------------------------------
-- row | ("Pau D,Arco",Pará)
-- -[ RECORD 112 ]------------------------------------------
-- row | ("Pau D,Arco",Tocantins)
-- -[ RECORD 113 ]------------------------------------------
-- row | ("Pau D`Arco do Piauí",Piauí)
-- -[ RECORD 114 ]------------------------------------------
-- row | (Pauíni,Amazonas)
-- -[ RECORD 115 ]------------------------------------------
-- row | ("Pedro Ii",Piauí)
-- -[ RECORD 116 ]------------------------------------------
-- row | ("Pérola do Oeste",Paraná)
-- -[ RECORD 117 ]------------------------------------------
-- row | ("Pindaré Mirim",Maranhão)
-- -[ RECORD 118 ]------------------------------------------
-- row | ("Pingo D,Água","Minas Gerais")
-- -[ RECORD 119 ]------------------------------------------
-- row | ("Pio Ix",Piauí)
-- -[ RECORD 120 ]------------------------------------------
-- row | ("Pio Xii",Maranhão)
-- -[ RECORD 121 ]------------------------------------------
-- row | ("Ponta Porã - Sanga Puitã","Mato Grosso do Sul")
-- -[ RECORD 122 ]------------------------------------------
-- row | ("Porto Velho - Abunã",Rondônia)
-- -[ RECORD 123 ]------------------------------------------
-- row | ("Porto Velho - Calama",Rondônia)
-- -[ RECORD 124 ]------------------------------------------
-- row | ("Porto Velho - Conceição da Galera",Rondônia)
-- -[ RECORD 125 ]------------------------------------------
-- row | ("Porto Velho - Cujubim Grande",Rondônia)
-- -[ RECORD 126 ]------------------------------------------
-- row | ("Porto Velho - Demarcação",Rondônia)
-- -[ RECORD 127 ]------------------------------------------
-- row | ("Porto Velho - Extrema",Rondônia)
-- -[ RECORD 128 ]------------------------------------------
-- row | ("Porto Velho - Fortaleza do Abunã",Rondônia)
-- -[ RECORD 129 ]------------------------------------------
-- row | ("Porto Velho - Jaci Paraná",Rondônia)
-- -[ RECORD 130 ]------------------------------------------
-- row | ("Porto Velho - Morrinhos",Rondônia)
-- -[ RECORD 131 ]------------------------------------------
-- row | ("Porto Velho - Mutum Paraná",Rondônia)
-- -[ RECORD 132 ]------------------------------------------
-- row | ("Porto Velho - Nazaré",Rondônia)
-- -[ RECORD 133 ]------------------------------------------
-- row | ("Porto Velho - Nova Califórnia",Rondônia)
-- -[ RECORD 134 ]------------------------------------------
-- row | ("Porto Velho - São Carlos",Rondônia)
-- -[ RECORD 135 ]------------------------------------------
-- row | ("Porto Velho - União Bandeirantes",Rondônia)
-- -[ RECORD 136 ]------------------------------------------
-- row | ("Porto Velho - Vista Alegre do Abunã",Rondônia)
-- -[ RECORD 137 ]------------------------------------------
-- row | (Poxoréo,"Mato Grosso")
-- -[ RECORD 138 ]------------------------------------------
-- row | ("Presidente Castelo Branco","Santa Catarina")
-- -[ RECORD 139 ]------------------------------------------
-- row | ("Presidente Juscelino","Rio Grande do Norte")
-- -[ RECORD 140 ]------------------------------------------
-- row | (Quebrângulo,Alagoas)
-- -[ RECORD 141 ]------------------------------------------
-- row | (Queluzita,"Minas Gerais")
-- -[ RECORD 142 ]------------------------------------------
-- row | (Quixabá,Paraíba)
-- -[ RECORD 143 ]------------------------------------------
-- row | (Quixabá,Pernambuco)
-- -[ RECORD 144 ]------------------------------------------
-- row | ("Rancho Alegre D,Oeste",Paraná)
-- -[ RECORD 145 ]------------------------------------------
-- row | ("Restinga Seca","Rio Grande do Sul")
-- -[ RECORD 146 ]------------------------------------------
-- row | (Safra,"Espírito Santo")
-- -[ RECORD 147 ]------------------------------------------
-- row | ("Santa Bárbara D,Oeste","São Paulo")
-- -[ RECORD 148 ]------------------------------------------
-- row | ("Santa Cecília de Umbuzeiro",Paraíba)
-- -[ RECORD 149 ]------------------------------------------
-- row | ("Santa Clara D,Oeste","São Paulo")
-- -[ RECORD 150 ]------------------------------------------
-- row | ("Santa Isabel do Pará",Pará)
-- -[ RECORD 151 ]------------------------------------------
-- row | ("Santa Rita D,Oeste","São Paulo")
-- -[ RECORD 152 ]------------------------------------------
-- row | ("Santa Rita do Araguaia","Mato Grosso")
-- -[ RECORD 153 ]------------------------------------------
-- row | ("Santa Teresinha",Bahia)
-- -[ RECORD 154 ]------------------------------------------
-- row | ("Santana do Livramento","Rio Grande do Sul")
-- -[ RECORD 155 ]------------------------------------------
-- row | (Santarém,Paraíba)
-- -[ RECORD 156 ]------------------------------------------
-- row | ("Santo Estevão",Bahia)
-- -[ RECORD 157 ]------------------------------------------
-- row | ("São Bento do Trairi","Rio Grande do Norte")
-- -[ RECORD 158 ]------------------------------------------
-- row | ("São Cristovão do Sul","Santa Catarina")
-- -[ RECORD 159 ]------------------------------------------
-- row | ("São Felipe D,Oeste",Rondônia)
-- -[ RECORD 160 ]------------------------------------------
-- row | ("São Francisco Xavier","São Paulo")
-- -[ RECORD 161 ]------------------------------------------
-- row | ("São João D,Aliança",Goiás)
-- -[ RECORD 162 ]------------------------------------------
-- row | ("São João do Caru",Maranhão)
-- -[ RECORD 163 ]------------------------------------------
-- row | ("São João do Pau D,Alho","São Paulo")
-- -[ RECORD 164 ]------------------------------------------
-- row | ("São Jorge D,Oeste",Paraná)
-- -[ RECORD 165 ]------------------------------------------
-- row | ("São José do Mipibu","Rio Grande do Norte")
-- -[ RECORD 166 ]------------------------------------------
-- row | ("São Luís do Norte",Goiás)
-- -[ RECORD 167 ]------------------------------------------
-- row | ("São Luís do Paraitinga","São Paulo")
-- -[ RECORD 168 ]------------------------------------------
-- row | ("São Luís do Piauí",Piauí)
-- -[ RECORD 169 ]------------------------------------------
-- row | ("São Luiz do Anauá",Roraima)
-- -[ RECORD 170 ]------------------------------------------
-- row | ("São Miguel","São Paulo")
-- -[ RECORD 171 ]------------------------------------------
-- row | ("São Sebastião - Maresias","São Paulo")
-- -[ RECORD 172 ]------------------------------------------
-- row | ("São Thomé das Letras","Minas Gerais")
-- -[ RECORD 173 ]------------------------------------------
-- row | ("São Valério da Natividade",Tocantins)
-- -[ RECORD 174 ]------------------------------------------
-- row | ("São Vicente Ferrer",Pernambuco)
-- -[ RECORD 175 ]------------------------------------------
-- row | ("Senador Eloi de Souza","Rio Grande do Norte")
-- -[ RECORD 176 ]------------------------------------------
-- row | (Seridó,Paraíba)
-- -[ RECORD 177 ]------------------------------------------
-- row | ("Sítio D,Abadia",Goiás)
-- -[ RECORD 178 ]------------------------------------------
-- row | ("Tanque D,Arca",Alagoas)
-- -[ RECORD 179 ]------------------------------------------
-- row | ("Trajano de Morais","Rio de Janeiro")
-- -[ RECORD 180 ]------------------------------------------
-- row | (Uchôa,"São Paulo")
-- -[ RECORD 181 ]------------------------------------------
-- row | ("Valença - Conservatória","Rio de Janeiro")
-- -[ RECORD 182 ]------------------------------------------
-- row | ("Várzea da Roca",Bahia)
-- -[ RECORD 183 ]------------------------------------------
-- row | ("Vazamor - Vazante","Minas Gerais")
-- -[ RECORD 184 ]------------------------------------------
-- row | ("Vespasiano Correa","Rio Grande do Sul")
-- -[ RECORD 185 ]------------------------------------------
-- row | (Xangri-Lá,"Rio Grande do Sul")
-- -[ RECORD 186 ]------------------------------------------
-- row | (Xavantina,"Mato Grosso")


-- with D, replaced with D'
-- -[ RECORD 1 ]--------------------------------------------
-- row | (Acarapé,Ceará)
-- -[ RECORD 2 ]--------------------------------------------
-- row | (Acégua,"Rio Grande do Sul")
-- -[ RECORD 3 ]--------------------------------------------
-- row | ("Alta Floresta do Oeste",Rondônia)
-- -[ RECORD 4 ]--------------------------------------------
-- row | ("Alvorada do Oeste",Rondônia)
-- -[ RECORD 5 ]--------------------------------------------
-- row | (Amambaí,"Mato Grosso do Sul")
-- -[ RECORD 6 ]--------------------------------------------
-- row | ("Americo de Campos","São Paulo")
-- -[ RECORD 7 ]--------------------------------------------
-- row | ("Amparo da Serra","Minas Gerais")
-- -[ RECORD 8 ]--------------------------------------------
-- row | ("Amparo de São Francisco",Sergipe)
-- -[ RECORD 9 ]--------------------------------------------
-- row | ("Aparecida D'Oeste","São Paulo")
-- -[ RECORD 10 ]-------------------------------------------
-- row | (Aracatú,Bahia)
-- -[ RECORD 11 ]-------------------------------------------
-- row | (Araçoiaba,Ceará)
-- -[ RECORD 12 ]-------------------------------------------
-- row | (Araguaia,"Mato Grosso")
-- -[ RECORD 13 ]-------------------------------------------
-- row | ("Arquipélago de São Pedro e São Paulo",Pernambuco)
-- -[ RECORD 14 ]-------------------------------------------
-- row | ("Arquipélago do Bailique",Amapá)
-- -[ RECORD 15 ]-------------------------------------------
-- row | ("Atilio Vivacqua","Espírito Santo")
-- -[ RECORD 16 ]-------------------------------------------
-- row | ("Augusto Severo","Rio Grande do Norte")
-- -[ RECORD 17 ]-------------------------------------------
-- row | (Barreiros,Piauí)
-- -[ RECORD 18 ]-------------------------------------------
-- row | ("Bela Vista do Caroba",Paraná)
-- -[ RECORD 19 ]-------------------------------------------
-- row | ("Belém de São Francisco",Pernambuco)
-- -[ RECORD 20 ]-------------------------------------------
-- row | (Biritiba-Mirim,"São Paulo")
-- -[ RECORD 21 ]-------------------------------------------
-- row | (Bocaína,Piauí)
-- -[ RECORD 22 ]-------------------------------------------
-- row | (Brasópolis,"Minas Gerais")
-- -[ RECORD 23 ]-------------------------------------------
-- row | (Brodósqui,"São Paulo")
-- -[ RECORD 24 ]-------------------------------------------
-- row | (Cabo,Pernambuco)
-- -[ RECORD 25 ]-------------------------------------------
-- row | (Cambirá,Paraná)
-- -[ RECORD 26 ]-------------------------------------------
-- row | ("Campo Limpo Goiás",Goiás)
-- -[ RECORD 27 ]-------------------------------------------
-- row | ("Campo de Santana",Paraíba)
-- -[ RECORD 28 ]-------------------------------------------
-- row | ("Cerro Cora","Rio Grande do Norte")
-- -[ RECORD 29 ]-------------------------------------------
-- row | (Chiapeta,"Rio Grande do Sul")
-- -[ RECORD 30 ]-------------------------------------------
-- row | ("Cidade de Goiás",Goiás)
-- -[ RECORD 31 ]-------------------------------------------
-- row | ("Conselheiro Mairynck",Paraná)
-- -[ RECORD 32 ]-------------------------------------------
-- row | ("Couto de Magalhães",Tocantins)
-- -[ RECORD 33 ]-------------------------------------------
-- row | (Cristais,"São Paulo")
-- -[ RECORD 34 ]-------------------------------------------
-- row | (Curuca,Pará)
-- -[ RECORD 35 ]-------------------------------------------
-- row | ("Diamante do Oeste",Paraná)
-- -[ RECORD 36 ]-------------------------------------------
-- row | ("Dias D'Ávila",Bahia)
-- -[ RECORD 37 ]-------------------------------------------
-- row | ("Eldorado dos Carajás",Pará)
-- -[ RECORD 38 ]-------------------------------------------
-- row | (Embu,"São Paulo")
-- -[ RECORD 39 ]-------------------------------------------
-- row | (Ererê,Ceará)
-- -[ RECORD 40 ]-------------------------------------------
-- row | ("Estrela D'Oeste","São Paulo")
-- -[ RECORD 41 ]-------------------------------------------
-- row | ("Fortaleza do Tabocão",Tocantins)
-- -[ RECORD 42 ]-------------------------------------------
-- row | ("Francisco Macêdo",Piauí)
-- -[ RECORD 43 ]-------------------------------------------
-- row | (Goio-Erê,Paraná)
-- -[ RECORD 44 ]-------------------------------------------
-- row | (Gouvêa,"Minas Gerais")
-- -[ RECORD 45 ]-------------------------------------------
-- row | ("Governador Lindemberg","Espírito Santo")
-- -[ RECORD 46 ]-------------------------------------------
-- row | ("Governador Newton Belo",Maranhão)
-- -[ RECORD 47 ]-------------------------------------------
-- row | ("Grão Pará","Santa Catarina")
-- -[ RECORD 48 ]-------------------------------------------
-- row | (Guaimbé,"São Paulo")
-- -[ RECORD 49 ]-------------------------------------------
-- row | ("Guarani D'Oeste","São Paulo")
-- -[ RECORD 50 ]-------------------------------------------
-- row | (Guaraniaçú,Paraná)
-- -[ RECORD 51 ]-------------------------------------------
-- row | ("Herval D'Oeste","Santa Catarina")
-- -[ RECORD 52 ]-------------------------------------------
-- row | (Iguaraci,Pernambuco)
-- -[ RECORD 53 ]-------------------------------------------
-- row | ("Ilha Grande","Rio de Janeiro")
-- -[ RECORD 54 ]-------------------------------------------
-- row | (Ipauçu,"São Paulo")
-- -[ RECORD 55 ]-------------------------------------------
-- row | (Irati,Pará)
-- -[ RECORD 56 ]-------------------------------------------
-- row | (Itacuruçá,"Rio de Janeiro")
-- -[ RECORD 57 ]-------------------------------------------
-- row | (Itaipava,"Rio de Janeiro")
-- -[ RECORD 58 ]-------------------------------------------
-- row | (Itajuipi,Bahia)
-- -[ RECORD 59 ]-------------------------------------------
-- row | (Itamarajú,Bahia)
-- -[ RECORD 60 ]-------------------------------------------
-- row | (Itaóca,"São Paulo")
-- -[ RECORD 61 ]-------------------------------------------
-- row | (Itapagé,Ceará)
-- -[ RECORD 62 ]-------------------------------------------
-- row | ("Itapejara D'Oeste",Paraná)
-- -[ RECORD 63 ]-------------------------------------------
-- row | (Itapiuna,Ceará)
-- -[ RECORD 64 ]-------------------------------------------
-- row | ("Itaporanga D'Ajuda",Sergipe)
-- -[ RECORD 65 ]-------------------------------------------
-- row | ("Itauna do Sul",Paraná)
-- -[ RECORD 66 ]-------------------------------------------
-- row | (Jaicos,Piauí)
-- -[ RECORD 67 ]-------------------------------------------
-- row | ("Lagoa Danta","Rio Grande do Norte")
-- -[ RECORD 68 ]-------------------------------------------
-- row | ("Lagoa do Itaenga",Pernambuco)
-- -[ RECORD 69 ]-------------------------------------------
-- row | ("Lauro Muller","Santa Catarina")
-- -[ RECORD 70 ]-------------------------------------------
-- row | (Maçambara,"Rio Grande do Sul")
-- -[ RECORD 71 ]-------------------------------------------
-- row | ("Mãe D'Água",Paraíba)
-- -[ RECORD 72 ]-------------------------------------------
-- row | (Marataizes,"Espírito Santo")
-- -[ RECORD 73 ]-------------------------------------------
-- row | ("Mirassol D'Oeste","Mato Grosso")
-- -[ RECORD 74 ]-------------------------------------------
-- row | (Mogi-Guaçú,"São Paulo")
-- -[ RECORD 75 ]-------------------------------------------
-- row | ("Moji Mirim","São Paulo")
-- -[ RECORD 76 ]-------------------------------------------
-- row | ("Morro Cabeça No Tempo",Piauí)
-- -[ RECORD 77 ]-------------------------------------------
-- row | ("Munhoz de Mello",Paraná)
-- -[ RECORD 78 ]-------------------------------------------
-- row | (Normândia,Roraima)
-- -[ RECORD 79 ]-------------------------------------------
-- row | ("Olho D'Água",Paraíba)
-- -[ RECORD 80 ]-------------------------------------------
-- row | ("Olho D'Água Grande",Alagoas)
-- -[ RECORD 81 ]-------------------------------------------
-- row | ("Olho D'Água das Cunhãs",Maranhão)
-- -[ RECORD 82 ]-------------------------------------------
-- row | ("Olho D'Água das Flores",Alagoas)
-- -[ RECORD 83 ]-------------------------------------------
-- row | ("Olho D'Água do Borges","Rio Grande do Norte")
-- -[ RECORD 84 ]-------------------------------------------
-- row | ("Olho D'Água do Casado",Alagoas)
-- -[ RECORD 85 ]-------------------------------------------
-- row | ("Olhos D'Água","Minas Gerais")
-- -[ RECORD 86 ]-------------------------------------------
-- row | ("Palmeira D'Oeste","São Paulo")
-- -[ RECORD 87 ]-------------------------------------------
-- row | ("Palmeira do Tocantins",Tocantins)
-- -[ RECORD 88 ]-------------------------------------------
-- row | ("Pântano Grande","Rio Grande do Sul")
-- -[ RECORD 89 ]-------------------------------------------
-- row | (Parati,"Rio de Janeiro")
-- -[ RECORD 90 ]-------------------------------------------
-- row | (Parau,"Rio Grande do Norte")
-- -[ RECORD 91 ]-------------------------------------------
-- row | (Parauapebas/Carajás,Pará)
-- -[ RECORD 92 ]-------------------------------------------
-- row | ("Parque Nacionaliba",Piauí)
-- -[ RECORD 93 ]-------------------------------------------
-- row | ("Passo do Camaragibe",Alagoas)
-- -[ RECORD 94 ]-------------------------------------------
-- row | (Passos,Maranhão)
-- -[ RECORD 95 ]-------------------------------------------
-- row | ("Patrocínio de Muriaé","Minas Gerais")
-- -[ RECORD 96 ]-------------------------------------------
-- row | ("Pau D`Arco do Piauí",Piauí)
-- -[ RECORD 97 ]-------------------------------------------
-- row | (Pauíni,Amazonas)
-- -[ RECORD 98 ]-------------------------------------------
-- row | ("Pedro Ii",Piauí)
-- -[ RECORD 99 ]-------------------------------------------
-- row | ("Pérola do Oeste",Paraná)
-- -[ RECORD 100 ]------------------------------------------
-- row | ("Pindaré Mirim",Maranhão)
-- -[ RECORD 101 ]------------------------------------------
-- row | ("Pingo D'Água","Minas Gerais")
-- -[ RECORD 102 ]------------------------------------------
-- row | ("Pio Ix",Piauí)
-- -[ RECORD 103 ]------------------------------------------
-- row | ("Pio Xii",Maranhão)
-- -[ RECORD 104 ]------------------------------------------
-- row | (Poxoréo,"Mato Grosso")
-- -[ RECORD 105 ]------------------------------------------
-- row | ("Presidente Castelo Branco","Santa Catarina")
-- -[ RECORD 106 ]------------------------------------------
-- row | ("Presidente Juscelino","Rio Grande do Norte")
-- -[ RECORD 107 ]------------------------------------------
-- row | (Quebrângulo,Alagoas)
-- -[ RECORD 108 ]------------------------------------------
-- row | (Queluzita,"Minas Gerais")
-- -[ RECORD 109 ]------------------------------------------
-- row | (Quixabá,Paraíba)
-- -[ RECORD 110 ]------------------------------------------
-- row | (Quixabá,Pernambuco)
-- -[ RECORD 111 ]------------------------------------------
-- row | ("Restinga Seca","Rio Grande do Sul")
-- -[ RECORD 112 ]------------------------------------------
-- row | (Safra,"Espírito Santo")
-- -[ RECORD 113 ]------------------------------------------
-- row | ("Santa Bárbara D'Oeste","São Paulo")
-- -[ RECORD 114 ]------------------------------------------
-- row | ("Santa Cecília de Umbuzeiro",Paraíba)
-- -[ RECORD 115 ]------------------------------------------
-- row | ("Santa Clara D'Oeste","São Paulo")
-- -[ RECORD 116 ]------------------------------------------
-- row | ("Santa Isabel do Pará",Pará)
-- -[ RECORD 117 ]------------------------------------------
-- row | ("Santa Rita D'Oeste","São Paulo")
-- -[ RECORD 118 ]------------------------------------------
-- row | ("Santa Rita do Araguaia","Mato Grosso")
-- -[ RECORD 119 ]------------------------------------------
-- row | ("Santa Teresinha",Bahia)
-- -[ RECORD 120 ]------------------------------------------
-- row | ("Santana do Livramento","Rio Grande do Sul")
-- -[ RECORD 121 ]------------------------------------------
-- row | (Santarém,Paraíba)
-- -[ RECORD 122 ]------------------------------------------
-- row | ("Santo Estevão",Bahia)
-- -[ RECORD 123 ]------------------------------------------
-- row | ("São Bento do Trairi","Rio Grande do Norte")
-- -[ RECORD 124 ]------------------------------------------
-- row | ("São Cristovão do Sul","Santa Catarina")
-- -[ RECORD 125 ]------------------------------------------
-- row | ("São Francisco Xavier","São Paulo")
-- -[ RECORD 126 ]------------------------------------------
-- row | ("São João D'Aliança",Goiás)
-- -[ RECORD 127 ]------------------------------------------
-- row | ("São João do Caru",Maranhão)
-- -[ RECORD 128 ]------------------------------------------
-- row | ("São João do Pau D'Alho","São Paulo")
-- -[ RECORD 129 ]------------------------------------------
-- row | ("São Jorge D'Oeste",Paraná)
-- -[ RECORD 130 ]------------------------------------------
-- row | ("São José do Mipibu","Rio Grande do Norte")
-- -[ RECORD 131 ]------------------------------------------
-- row | ("São Luís do Norte",Goiás)
-- -[ RECORD 132 ]------------------------------------------
-- row | ("São Luís do Paraitinga","São Paulo")
-- -[ RECORD 133 ]------------------------------------------
-- row | ("São Luís do Piauí",Piauí)
-- -[ RECORD 134 ]------------------------------------------
-- row | ("São Luiz do Anauá",Roraima)
-- -[ RECORD 135 ]------------------------------------------
-- row | ("São Miguel","São Paulo")
-- -[ RECORD 136 ]------------------------------------------
-- row | ("São Thomé das Letras","Minas Gerais")
-- -[ RECORD 137 ]------------------------------------------
-- row | ("São Valério da Natividade",Tocantins)
-- -[ RECORD 138 ]------------------------------------------
-- row | ("São Vicente Ferrer",Pernambuco)
-- -[ RECORD 139 ]------------------------------------------
-- row | ("Senador Eloi de Souza","Rio Grande do Norte")
-- -[ RECORD 140 ]------------------------------------------
-- row | (Seridó,Paraíba)
-- -[ RECORD 141 ]------------------------------------------
-- row | ("Sítio D'Abadia",Goiás)
-- -[ RECORD 142 ]------------------------------------------
-- row | ("Tanque D'Arca",Alagoas)
-- -[ RECORD 143 ]------------------------------------------
-- row | ("Trajano de Morais","Rio de Janeiro")
-- -[ RECORD 144 ]------------------------------------------
-- row | (Uchôa,"São Paulo")
-- -[ RECORD 145 ]------------------------------------------
-- row | ("Várzea da Roca",Bahia)
-- -[ RECORD 146 ]------------------------------------------
-- row | (Vazamor,"Minas Gerais")
-- -[ RECORD 147 ]------------------------------------------
-- row | ("Vespasiano Correa","Rio Grande do Sul")
-- -[ RECORD 148 ]------------------------------------------
-- row | (Xangri-Lá,"Rio Grande do Sul")
-- -[ RECORD 149 ]------------------------------------------
-- row | (Xavantina,"Mato Grosso")

--fuzzy matching of trechos.cidade/municipios.municipio names 
CREATE EXTENSION fuzzystrmatch;

--TODO (Lee) need to fix bug below
-- SELECT distinct(t.origem_cidade, m.nome_municipio, t.origem_uf)
-- FROM trechos t                                            
-- LEFT OUTER JOIN municipios_dtb_2020 m
-- ON t.origem_cidade = m.nome_municipio AND t.origem_uf_id = m.uf_id
-- WHERE t.origem_pais = 'Brasil'
-- AND m.nome_municipio IS NULL
-- AND levenshtein(t.origem_cidade, m.nome_municipio) >= 1
-- LIMIT 1000;

-- SELECT a.*, b.* FROM A a
--  JOIN B b
--  WHERE LEVENSHTEIN(first_name_a, first_name_b) IS LESS THAN 1
--  AND LEVENSHTEIN(last_name_a, last_name_b) IS LESS THAN 1

-- SELECT distinct(t.origem_cidade, m.nome_municipio, t.origem_uf)
-- FROM trechos t                                            
-- LEFT OUTER JOIN municipios_dtb_2020 m
-- ON t.origem_cidade = m.nome_municipio AND t.origem_uf_id = m.uf_id
-- WHERE t.origem_pais = 'Brasil'
-- AND levenshtein(t.origem_cidade, m.nome_municipio) > 0
-- LIMIT 1000;

-- SELECT distinct(t.origem_cidade, m.nome_municipio, t.origem_uf)
-- FROM trechos t, municipios_dtb_2020 m                                            
-- WHERE t.origem_pais = 'Brasil'
-- AND levenshtein(t.origem_cidade, m.nome_municipio) >= 0
-- LIMIT 1000;

COPY (SELECT nome_municipio, codigo_municipio_completo, uf_id, uf_nome
      FROM municipios_dtb_2020)
      TO '/Users/lee/Documents/code/br_gov/data/municipios.csv' 
      DELIMITER ',' CSV HEADER;



