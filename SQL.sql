create table utente(
	username varchar(20) primary key,
	password varchar(30) not null,
	email varchar(320) not null,
	dataIscrizione date not null,
	isAdmin bit default b'0' not null,
	isDeleted bit default b'0' not null
);

create table amicizia(
	utente1 varchar(20),
	utente2 varchar(20),
	primary key(utente1, utente2),
	foreign key(utente1) references utente(username) on update no action on delete no action,
	foreign key(utente2) references utente(username) on update no action on delete no action
);

create table messaggio(
	id serial primary key,
	dataInvio date not null,
	contenuto varchar(255) not null,
	mittente varchar(20) not null,
	destinatario varchar(20) not null,
	foreign key(mittente) references utente(username) on update no action on delete no action,
	foreign key(destinatario) references utente(username) on update no action on delete no action
);

create table sub(
	nome varchar(20) primary key,
	dataCreazione date not null,
	descrizione varchar(255) not null,
	isPremium bit not null,
	nsfw bit not null,
	creatore varchar(20) not null,
	foreign key(creatore) references utente(username) on update no action on delete no action
);

create table iscrizione(
	utente varchar(20) not null,
	sub varchar(20) not null,
	primary key(utente, sub),
	foreign key(utente) references utente(username) on update no action on delete no action,
	foreign key(sub) references sub(nome) on update no action on delete no action
);

create table post(
	id serial primary key,
	titolo varchar(100) not null,
	dataCreazione date not null,
	contenuto varchar(500) not null,
	nsfw bit not null,
	creatore varchar(20) not null,
	sub varchar(20) not null,
	foreign key(creatore) references utente(username) on update no action on delete no action,
	foreign key(sub) references sub(nome) on update no action on delete no action

);

create table votoPost(
	utente varchar(20) not null,
	post int not null,
	valore int not null,
	primary key(utente, post),
	foreign key(utente) references utente(username) on update no action on delete no action,
	foreign key(post) references post(id) on update no action on delete no action
);

create table commento(
	id serial primary key,
	dataCommento date not null,
	contenuto varchar(500) not null,
	risposta int,
	utente varchar(20) not null,
	post int not null,
	isDelete bit default b'0' not null,
	foreign key(risposta) references commento(id) on update no action on delete no action,
	foreign key(utente) references utente(username) on update no action on delete no action,
	foreign key(post) references post(id) on update no action on delete no action
);

create table votoCommento(
	utente varchar(20) not null,
	commento int not null,
	valore int not null,
	primary key(utente, commento),
	foreign key(utente) references utente(username) on update no action on delete no action,
	foreign key(commento) references commento(id) on update no action on delete no action
);

create table media(
	id serial primary key,
	nome varchar(30),
	descrizione varchar(30),
	percorso varchar(60) not null,
	tipo varchar(5) not null, check (tipo in ('foto', 'video', 'link')),
	tag varchar(100),
	foreign key(id) references post(id) on update no action on delete no action
);

create table prezzo(
	tipo char primary key,
	costo decimal(3, 1)
);

create table award(
	utente varchar(20) not null,
	commento int not null,
	tipo char not null,
	dataAcquisto date not null,
	primary key(utente, commento),
	foreign key(utente) references utente(username) on update no action on delete no action,
	foreign key(commento) references commento(id) on update no action on delete no action,
	foreign key(tipo) references prezzo(tipo) on update no action on delete no action
);

create table feed(
	utente varchar(20),
	nome varchar(30),
	primary key(utente, nome),
	foreign key(utente) references utente(username) on update no action on delete no action
);

create table include(
	feed varchar(20) not null,
	utente varchar(20) not null,
	sub varchar(20) not null,
	primary key(feed, utente, sub),
	foreign key(utente, feed) references feed(utente, nome) on update no action on delete no action,
	foreign key(sub) references sub(nome) on update no action on delete no action
);

create table moderatore(
	utente varchar(20) not null,
	sub varchar(20) not null,
	dataInizio date not null,
	primary key(utente, sub),
	foreign key(utente) references utente(username) on update no action on delete no action,
	foreign key(sub) references sub(nome) on update no action on delete no action
);

create table ban(
	sub varchar(20) not null,
	utente varchar(20) not null,
	moderatore varchar(20) not null,
	modSub varchar(20) not null,
	dataBan date not null,
	scadenza date,
	motivo varchar(255) not null,
	foreign key(sub) references sub(nome) on update no action on delete no action,
	foreign key(utente) references utente(username) on update no action on delete no action,
	foreign key(moderatore, modSub) references moderatore(utente, sub) on update no action on delete no action
);
