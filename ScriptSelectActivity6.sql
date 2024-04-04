create table usuario(
	idUsuario int not null,
	nome varchar(50),
	cidade varchar(35),
	idade int,
	primary key(idUsuario)
);

insert into usuario values(1,'Rebeca','Parnaiba', 18);
insert into usuario values(2,'Maria','Parnaiba', 15);
insert into usuario values(3,'Denival','Murici dos Portelas', 40);
insert into usuario values(4,'Gerson','Piracuruca', 50);
insert into usuario values(5,'Vitoria','Parnaiba', 17);
insert into usuario values(6,'Clodoaldo','Campina Grande', 32);

create table grupo(
	idGrupo int not null,
	nomeGrupo varchar(40),
	primary key(idGrupo)
);

insert into grupo values(1,'Alunos');
insert into grupo values(2,'Professores');
insert into grupo values(3,'Ifpi');

create table usuarioGrupo(
	idGrupo int not null,
	idUsuario int not null,
	primary key(idGrupo, idUsuario),
	foreign key(idGrupo) references grupo(idGrupo),
	foreign key(idUsuario) references usuario(idUsuario)
);

insert into usuarioGrupo values(1,1);
insert into usuarioGrupo values(1,2);
insert into usuarioGrupo values(1,5);
insert into usuarioGrupo values(2,3);
insert into usuarioGrupo values(2,4);
insert into usuarioGrupo values(2,6);
insert into usuarioGrupo values(3,1);
insert into usuarioGrupo values(3,2);
insert into usuarioGrupo values(3,3);
insert into usuarioGrupo values(3,4);
insert into usuarioGrupo values(3,5);
insert into usuarioGrupo values(3,6);

create table mensagem(
	idMensagem int not null,
	userOrigem int not null,
	userDestino int not null,
	data date,
	conteudo varchar(150),
	primary key(idMensagem),
	foreign key(userOrigem) references usuario(idUsuario),
	foreign key(userDestino) references usuario(idUsuario)
);

insert into mensagem values(1,1,5,'2017-04-06','Vamos estudar');
insert into mensagem values(2,2,5,'2017-04-06','Anota o assunto para mim');
insert into mensagem values(3,3,4,'2017-04-07','Trabalha piraca');

-- 1)
-- a)
select * from usuario;

-- b)
select * from grupo;

-- c)
select * from mensagem;

-- d)
select * from mensagem where conteudo like '%estudar%';

-- e)
select * from usuario where idusuario in (
  select idusuario from usuarioGrupo where idgrupo = (
    select idGrupo from grupo where nomegrupo = 'ifpi'
  )
);

-- f)
select * from usuario where idusuario in (
  select idusuario from usuarioGrupo where idgrupo in (
    select idGrupo from grupo where nomegrupo in ('alunos', 'professores')
  )
);

-- g)
select * from usuario where idusuario not in (
  select userorigem from mensagem
);

-- h)
select nome from usuario where idusuario = (
  select userorigem from mensagem where idmensagem = (
    select min(idmensagem) from mensagem
  )
);

-- i)
select 
  mensagem.idMensagem,
  (select nome from usuario where idusuario = mensagem.userOrigem) as usuarioOrigemNome,
  (select nome from usuario where idusuario = mensagem.userOrigem) as usuarioDestinoNome
from mensagem;
	

