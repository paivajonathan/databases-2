use aulasql;

show tables;

insert into cliente values
	(1, 'Júnior'), (2, 'Thiago'), (3, 'Patrine');

insert into fiador values
	(1, '27306454030', 'Ronaldo'),
	(2, '99930250034', 'Messi');

insert into crediario values 
	(1, '2005-07-18', 1, 2000.00, 1, 1),
	(2, '2002-08-30', 2, 5000.00, 2, 2);

insert into prestacoes values
	(1, 1, '2005-07-30', 2000.00, '2005-07-30', '2005-07-25'),
	(2, 2, '2002-09-30', 2500.00, '2002-09-30', '2002-09-10'),
	(2, 3, '2002-10-30', 2500.00, '2002-10-30', '2002-10-10');
