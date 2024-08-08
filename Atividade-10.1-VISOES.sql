-- Atividade 10.1 Visões

-- 1) Resolvam as questões que seguem utilizando a base de Database VENDAS.

-- create database Vendas; 
-- 
-- use Vendas;
-- 
-- create table produto (
--   cod_produto int not null,
--   nome varchar(40),
--   unidade varchar(2),
--   valor_unit numeric(9,2),
--   primary key(cod_produto)
-- );
-- 
-- insert into produto values(1,'Arroz','LT',2);
-- insert into produto values(2,'Feijão','LT',3);
-- insert into produto values(3,'Sabão','UN',1);
-- insert into produto values(4,'Farinha','LT',1.5);
-- insert into produto values(5,'Milho','LT',0.5);
-- insert into produto values(6,'Leite','LT',2.9);
-- insert into produto values(7,'Cafe','KG',3);
-- insert into produto values(8,'Azeite','LT',3.5);
-- 
-- create table cliente (
--   id_cliente int not null,
--   nome varchar(40),
--   primary key(id_cliente)
-- );
-- 
-- insert into cliente values(1,'João');
-- insert into cliente values(2,'Jose');
-- insert into cliente values(3,'Maria');
-- insert into cliente values(4,'Pedro');
-- insert into cliente values(5,'Antonio');
-- insert into cliente values(6,'Maria');
-- insert into cliente values(7,'Teresa');
-- insert into cliente values(8,'Carlos');
-- insert into cliente values(9,'Francisca');
-- insert into cliente values(10,'Osvaldo');
-- 
-- 
-- create table vendedor (
--   id_vendedor int not null,
--   nome varchar(40),
--   primary key(id_vendedor)
-- );
-- 
-- insert into vendedor values(1,'Denival');
-- insert into vendedor values(2,'Gerson');
-- insert into vendedor values(3,'Regis');
-- insert into vendedor values(4,'Ely');
-- insert into vendedor values(5,'Cunha');
-- 
-- create table vendas (
--   num_venda int not null,
--   vendedor int,
--   comprador int,
--   data date,
--   primary key(num_venda),
--   foreign key(vendedor) references vendedor(id_vendedor),
--   foreign key(comprador) references cliente(id_cliente)
-- );
-- 
-- insert into vendas values(1,3,1, "2013-06-10");
-- insert into vendas values(2,2,2, "2013-06-12");
-- insert into vendas values(3,1,3, "2013-06-13");
-- insert into vendas values(4,3,4, "2013-06-13");
-- insert into vendas values(5,2,5, "2013-06-13");
-- insert into vendas values(6,1,1, "2013-06-14");
-- insert into vendas values(7,3,1, "2013-06-15");
-- insert into vendas values(8,5,10, "2013-06-16");
-- insert into vendas values(9,3,9, "2013-06-17");
-- insert into vendas values(10,3,8, "2013-06-17");
-- insert into vendas values(11,3,9, "2013-06-17");
-- insert into vendas values(12,3,7, "2013-06-18");
-- 
-- create table itens_venda (
--   num_venda int,
--   produto int,
--   quantidade int,
--   valor_unit numeric(9,2),
--   primary key(num_venda, produto),
--   foreign key(num_venda) references vendas(num_venda),
--   foreign key(produto) references produto(cod_produto)
-- );
-- 
-- insert into itens_venda values(1,1,2,2);
-- insert into itens_venda values(1,2,3,3);
-- insert into itens_venda values(2,4,1,1.5);
-- insert into itens_venda values(2,1,2,2);
-- insert into itens_venda values(3,1,2,2);
-- insert into itens_venda values(4,2,2,3);
-- insert into itens_venda values(5,6,2,2.9);
-- insert into itens_venda values(6,5,4,0.5);
-- insert into itens_venda values(7,7,2,3);
-- insert into itens_venda values(8,1,5,2);
-- insert into itens_venda values(9,3,2,1);
-- insert into itens_venda values(10,2,5,2);
-- insert into itens_venda values(11,4,2,1.5);
-- insert into itens_venda values(12,1,3,2);

-- a) Crie uma visão que exiba o número da venda, o nome do produto e a quantidade em cada venda.
-- Depois execute um select sobre esta view que exiba somente o nome do produto e a quantidade.

create view vwVendas as
select
	itens_venda.num_venda,
	produto.nome as nome_produto,
	itens_venda.quantidade
from itens_venda
	inner join produto
	on itens_venda.produto = produto.cod_produto;

select 
	nome_produto,
	quantidade
from vwVendas;

-- b) Crie uma visão que exiba o nome do produto e o total deste vendido.

create view vwTotaisProdutos as
select
	produto.nome as nome_produto,
	sum(itens_venda.quantidade) as total_vendido
from itens_venda
	inner join produto
	on itens_venda.produto = produto.cod_produto
group by produto.nome;

select * from vwTotaisProdutos;

-- c) Crie uma visão que exiba o número da venda, o nome do vendedor, o nome do comprador e data desta
-- venda.

create view vwPessoasVenda as
select
	vendas.num_venda,
	vendedor.nome as nome_vendedor,
	cliente.nome as nome_comprador,
	vendas.data
from vendas
	inner join vendedor
	on vendas.vendedor = vendedor.id_vendedor
	inner join cliente
	on vendas.comprador = cliente.id_cliente;
	
select * from vwPessoasVenda;

-- d) Crie uma visão que exiba a quantidade de vendas de cada vendedor. E depois execute a mesma.

create view vwQuantidadeVendas as
select
	vendedor.nome as nome_vendedor,
	count(vendas.num_venda) as qtd_vendas
from vendas
	inner join vendedor
	on vendas.vendedor = vendedor.id_vendedor
group by nome_vendedor;

select * from vwQuantidadeVendas;

-- Fim :)
