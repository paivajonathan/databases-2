-- Atividade 9.1 SELECT JOIN

-- 1) Resolvam as questões que seguem utilizando a base de Database CARROS.

-- a) Dropem a base de dados velha existente no seu computador. 
-- drop database carros;

-- b) Execute novamente o script CARROS para recriar a database.
-- create database carros;
-- 
-- use carros;
-- 
-- -- cria a tabela de marcas
-- create table cor (
--   id_cor int not null,	
--   cor varchar(20),
--   primary key(id_cor)
-- );
-- insert into cor values(1,"Branco");
-- insert into cor values(2,"Preto");
-- insert into cor values(3,"Vermelho");
-- insert into cor values(4,"Azul");
-- insert into cor values(5,"Cinza");
-- 
-- -- cria a tabela de marcas
-- create table marca (
--   id_marca int not null,
--   marca varchar(20),
--   primary key(id_marca)
-- );
-- insert into marca values(1,"Volkswagen");
-- insert into marca values(2,"Toyota");
-- insert into marca values(3,"Chevrolet");
-- insert into marca values(4,"Fiat");
-- insert into marca values(5,"Ford");
-- 
-- -- cria a tabela de modelos
-- create table modelo (
--   id_modelo int not null,
--   modelo varchar(30),
--   id_marca int not null,
--   primary key(id_modelo),
--   foreign key(id_marca) references marca(id_marca)
-- );
-- insert into modelo values(1,"Hilux",2);
-- insert into modelo values(2,"Siena",4);
-- insert into modelo values(3,"Fiesta",5);
-- insert into modelo values(4,"Fusca",1);
-- insert into modelo values(5,"Corsa",3);
-- 
-- -- cria a tabela de veiculo
-- create table veiculo(
--   placa varchar(8) not null,
--   cor int not null,
--   modelo int not null,	
--   ano int,
--   valor numeric(9,2),
--   primary key(placa),
--   foreign key(cor) references cor(id_cor),
--   foreign key(modelo) references modelo(id_modelo)
-- );
-- insert into veiculo values("LVW1518",1,5,2010,100000.00);
-- insert into veiculo values("XXX1017",5,3,2009,20000.00);
-- insert into veiculo values("YYY0516",2,2,2013,35000.00);
-- insert into veiculo values("TTT2518",3,4,1960,2000.00);
-- insert into veiculo values("AAA2512",1,3,2010,18000.00);

-- c) Exiba o nomes das marcas e respectivo nome dos modelos existentes. Ordenados de forma ascendente. 
-- Utilizando junção simples.

select marca.marca, modelo.modelo
from modelo, marca
where modelo.id_marca = marca.id_marca
order by marca.marca, modelo.modelo;

-- d) Exiba o nomes das marcas e respectivo nome dos modelos existentes. Ordenados de forma ascendente.
-- Utilizando junção interna.

select marca.marca, modelo.modelo
from modelo
	inner join marca
	on modelo.id_marca = marca.id_marca
order by marca.marca, modelo.modelo;

-- e) Exiba o nomes das marcas e respectivo nome dos modelos existentes. Ordenados de forma ascendente.
-- Utilizando junção externa à esquerda.

select marca.marca, modelo.modelo
from modelo
	left join marca
	on modelo.id_marca = marca.id_marca
order by marca.marca, modelo.modelo;

-- f) Exiba o nomes das marcas e respectivo nome dos modelos existentes. Ordenados de forma ascendente.
-- Utilizando junção externa à direita.

select marca.marca, modelo.modelo
from modelo
	right join marca
	on modelo.id_marca = marca.id_marca
order by marca.marca, modelo.modelo;

-- g) Exiba a placa e o nome da cor dos veículos cadastrados.

select
	veiculo.placa, cor.cor
from veiculo
	inner join cor
	on veiculo.cor = cor.id_cor;

-- h) Crie uma versão da questão anterior, onde exibe o nome das cores ordenadas ascendentemente e as
-- placas, também, ascendentemente.

select
	veiculo.placa, cor.cor
from veiculo
	inner join cor
	on veiculo.cor = cor.id_cor
order by cor.cor, veiculo.placa;

-- i) Exiba os modelos que são da marca FIAT.

select modelo.*, marca.marca
from modelo
	inner join marca
	on modelo.id_marca = marca.id_marca
where marca.marca = 'FIAT';

-- j) Exiba os veículos que são da cor BRANCA.

select veiculo.*, cor.cor
from veiculo
	inner join cor
	on veiculo.cor = cor.id_cor
where cor.cor = 'Branco';

-- k) Exiba a placa do veículo, nome da cor, nome do modelo, ano e valor de cada veículo ordenado por
-- modelo. Utilizando junção simples.

select
	veiculo.placa,
	cor.cor,
	modelo.modelo,
	veiculo.ano,
	veiculo.valor
from veiculo, cor, modelo
where
	veiculo.cor = cor.id_cor and
	veiculo.modelo = modelo.id_modelo
order by modelo.modelo;

-- l) Exiba a placa do veículo, nome da cor, nome do modelo, ano e valor de cada veículo ordenado por
-- modelo. Utilizando junção interna.

select
	veiculo.placa,
	cor.cor,
	modelo.modelo,
	veiculo.ano,
	veiculo.valor
from veiculo
	inner join cor
	on veiculo.cor = cor.id_cor
	inner join modelo
	on veiculo.modelo = modelo.id_modelo
order by modelo.modelo;

-- m) Exiba as cores que ainda não tem veículos referenciados.

select cor.*
from veiculo
	right join cor
	on veiculo.cor = cor.id_cor
where veiculo.placa is null;
