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

COPY municipios_dtb_2020
FROM '/Users/lee/Documents/code/br_gov/data/DTB_2020_v2/dtb_2020_municipio.csv'
WITH CSV DELIMITER ','
ENCODING 'UTF8' HEADER;

COPY
indice_nomes_geograficos_bcim_download.txt
municipios_por_regioes_metropolitanas.txt  servidorPorOrgao.csv