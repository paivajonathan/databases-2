-- 1)

create database aulasql;

use aulasql;

create table cliente(
	id int not null,
	nome varchar(50),
	primary key(id)
);

create table crediario(
	num_crediario int not null,
	data date,
	cliente_id int not null,
	valor decimal(15, 2),
	primary key(num_crediario),
	constraint fk_crediario_cliente foreign key(cliente_id) references cliente(id),
	check (valor >= 0)
); 

create table prestacoes(
	num_crediario int not null,
	num_prestacao int not null,
	data_vencimento date,
	primary key(num_crediario, num_prestacao),
	constraint fk_prestacoes_crediario foreign key(num_crediario) references crediario(num_crediario)
);

-- 2)

-- a)

alter table crediario 
add qtd_prestacoes int not null;

-- b)

alter table cliente
modify nome varchar(100) not null;

-- c)

alter table prestacoes 
add valor decimal(15, 2),
add data_prevista date,
add data_pagamento date;

-- d)

alter table crediario 
add cpf_fiador char(11),
add nome_fiador varchar(100);

-- 3)

create table fiador(
	id int not null,
	cpf char(11) not null,
	nome varchar(100) not null,
	primary key(id)
);

alter table crediario
drop cpf_fiador,
drop nome_fiador,
add fiador_id int,
add constraint fk_crediario_fiador foreign key(fiador_id) references fiador(id);
