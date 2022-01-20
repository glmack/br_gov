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
