-- Atividade 9.3 Revisão de assuntos

-- Prólogo) crie database pai_filho

-- create database pai_filho;
-- 
-- use pai_filho;
-- 
-- create table pai (
--   id_pai int not null,
--   nome varchar(35),
--   salario numeric(9,2),
--   primary key(id_pai)
-- );
-- 
-- create table filho (
--  Id_filho int not null,
--  id_pai int,
--  nome varchar(35),
--  idade int,
--  primary key(id_filho),
--  foreign key(id_pai) references pai(Id_pai)
-- );
-- 
-- 
-- insert into pai values(1,'Denival', 1000);
-- insert into pai values(2,'Gerson', 2000);
-- insert into pai values(3,'Regis', 3000);
-- insert into pai values(4,'Deinha', 4000);
-- 
-- insert into filho values(1,1,'Denival Jr', 13);
-- insert into filho values(2,1,'Jamilly', 9);
-- insert into filho values(3,2,'Teresa Evelin', 8);
-- insert into filho values(4,3,'Luana', 10);
-- insert into filho values(5,4,'Marilia', 30);

-- 1) Selecione o nome do pai e dos filhos.

select
	pai.nome,
	filho.nome
from filho
	inner join pai
	on filho.id_pai = pai.id_pai;

-- 2) Selecione o id do pai, nome e o maior salário.

select *  -- select mais externo para encontrar o pai cujo salário é o maior salário
from pai
where salario = (
	select max(salario)  -- select aninhado para encontrar o maior salário
	from pai
);

-- 3) Selecione os pais que possuem filhos.

select distinct pai.*
from filho
	right join pai
	on filho.id_pai = pai.id_pai
where filho.id_filho is not null;

-- ou

select *
from pai
where id_pai in (  -- vejo se o pai tem o id dentro dessa lista de ids
	select id_pai  -- pego os ids dos pais na tabela de filho (1, 1, 2, 3, 4)
	from filho
);

-- 4) Selecione os filhos, cujo idade seja maior que 18 anos.

select *
from filho
where idade > 18;

-- 5) Selecione os filhos, cujos pais possuem salarios maiores que 1000,00.
-- Informações em mais de uma tabela -> Join

select
	filho.nome,
	pai.nome,
	pai.salario
from filho
	inner join pai
	on filho.id_pai = pai.id_pai
where pai.salario > 1000;

-- 6) Selecione os filhos, cujos pais possuam salario maior que a media dos salarios.

select *
from filho
where filho.id_pai in (
	select id_pai  -- Resultado -> Pais: 3, 4
	from pai
	where salario > (
		select avg(salario)  -- Resultado -> Média dos salários: 2500
		from pai
	)
);

-- 7) Selecione o nome dos pais e a idade dos filhos mais velhos.

select
	pai.nome,
	filho.idade
from filho
	inner join pai
	on filho.id_pai = pai.id_pai
where filho.idade in (
	select max(idade)  -- Resultado -> (13, 8, 10, 30)
	from filho
	group by id_pai  -- Agrupo por pai, porque é o filho mais velho de cada pai
);

-- 8) Selecione o id e nome dos pais cujos salarios são maior que a média de salarios.

select
	id_pai,
	nome
from pai
where salario > (
	select avg(salario)
	from pai
);

-- 9) Selecione o nome do pai e a quantidade de filhos que ele tem.

select
	pai.nome,
	count(filho.id_filho) as qtd_filhos
from filho
	inner join pai
	on filho.id_pai = pai.id_pai
group by pai.nome;

-- 10) Selecione os pais que possuem mais de um filho.
-- A diferença pra anterior é o Having

select
	pai.nome,
	count(filho.id_filho) as qtd_filhos
from filho
	inner join pai
	on filho.id_pai = pai.id_pai
group by pai.nome
having qtd_filhos > 1;

-- Fim :)
