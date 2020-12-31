create table utente(
	username varchar(20) primary key,
	password varchar(30) not null,
	email varchar(320) not null,
	dataIscrizione date not null,
	isAdmin bit default b'0' not null,
	isDeleted bit default b'0' not null,
	on delete utente set isDeleted = b'1'
);

create table amicizia(
	utente1 varchar(20),
	utente2 varchar(20),
	primary key(utente1, utente2),
	foreign key(utente1) references utente(username) on update no action on delete no action,
	foreign key(utente2) references utente(username) on update no action on delete no action
);
