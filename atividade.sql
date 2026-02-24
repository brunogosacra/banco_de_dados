CREATE TABLE cliente (
 id int primary key,
 cpf char(14) not null,
 nome varchar(232) not null,
 email varchar(220) not null
);

insert into cliente values ("10", "093.975.215-86", "Bruno", "brunin@gmail.com");

select * from cliente;

CREATE TABLE carro (
 id int,
 cliente_id int,
 modelo varchar(220) not null,
 cor varchar(202) not null,
 preco char(200) not null,
 primary key (id),
 foreign key (cliente_id) references cliente(id)
);

insert into carro values ("01","10", "ferrari", "preto", "300.000");

select * from carro;
