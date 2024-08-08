-- Atividade 9.2 FUNÇÕES AGREGADAS E GRUPAMENTOS

-- 1. Resolvam as questões que seguem utilizando a base de Database CARROS.

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

-- Funções agregadas: MAX, MIN, SUM, AVG, COUNT

-- a) Exiba o veículo mais velho.

select *  -- select mais externo para obter o veiculo cujo ano é o menor ano
from veiculo
where veiculo.ano = (
	select min(ano)  -- select aninhado para obter o menor ano (mais antigo)
	from veiculo
);

-- b) Exiba o veículo mais novo.

select *  -- select mais externo para obter o veiculo cujo ano é o maior ano
from veiculo
where veiculo.ano = (
	select max(ano)  -- select aninhado para obter o maior ano (mais recente)
	from veiculo
);

-- c) Selecione a média dos valores dos veículos.

select avg(valor) as media_valores
from veiculo;

-- d) Selecione a quantidade de veículos cadastrados..

select count(placa) as qtd_veiculos
from veiculo;

-- e) Exiba a quantidade de modelos de cada marca.
-- Obs.: Atributo simples (marca.marca) junto de função agregada = GROUP BY atributo simples

select
	marca.marca,
	count(id_modelo) as qtd_modelos
from modelo
	inner join marca
	on modelo.id_marca = marca.id_marca
group by marca.id_marca;

-- f) Exiba o nome da marca e a quantidade de veículos dela cadastrados.

select
	marca.marca,
	count(veiculo.placa) as qtd_veiculos
from veiculo  -- inner join, por convenção, adotamos começar pela tabela que tem a chave estrangeira
	inner join modelo
	on veiculo.modelo = modelo.id_modelo
	inner join marca
	on modelo.id_marca = marca.id_marca
group by marca.marca;

-- g) Exiba os veículos cuja média de valor é maior que 20000.

-- *Denival talvez escreveu errado*

-- Caso seja "cujo valor é maior do que 20000":

select *
from veiculo
where valor > 20000;

-- Caso seja "Exiba os modelos cuja média de valor é maior que 20000."

select
	modelo.modelo,
	avg(veiculo.valor) as media_valor  -- apelido para utilizarmos depois
from veiculo
	inner join modelo
	on veiculo.modelo = modelo.id_modelo
group by modelo.modelo  -- agrupo pelo nome do modelo, por ser um atributo simples antes da função agregada
having media_valor > 20000;  -- having vem depois do group by, é um where aplicado a funções agregadas

-- h) Exiba a quantidade de veículos da cor branca.

select
	count(veiculo.placa) as qtd_veiculos
from veiculo
	inner join cor
	on veiculo.cor = cor.id_cor
where cor.cor = 'Branco';

-- i) Exiba o nome da cor e a respectiva quantidade de veículos cadastrados desta cor.

select
	cor.cor,
	count(veiculo.placa) as qtd_veiculos
from veiculo
	inner join cor
	on veiculo.cor = cor.id_cor
group by cor.cor;

-- j) imaginando que os veículos sejam da Paraíba, e lá os veículos são emplacados pela terminação da
-- placa. Quais veículos deveriam ser emplacados este mês.

-- Mês atual: Agosto (8)

select *
from veiculo
where placa like '%8';

-- Fim :)
