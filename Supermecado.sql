CREATE DATABASE supermercado;
USE supermercado;

-- =========================
-- TABELAS
-- =========================

CREATE TABLE cliente (
    id_cliente INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    cpf VARCHAR(14) UNIQUE,
    telefone VARCHAR(20) UNIQUE
);

CREATE TABLE fornecedor (
    id_fornecedor INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    contato VARCHAR(100) UNIQUE
);

CREATE TABLE produto (
    id_produto INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    preco DECIMAL(10,2) NOT NULL
);

-- RELACIONAMENTO N:N
CREATE TABLE produto_fornecedor (
    id_produto INT,
    id_fornecedor INT,
    PRIMARY KEY (id_produto, id_fornecedor),
    FOREIGN KEY (id_produto) REFERENCES produto(id_produto),
    FOREIGN KEY (id_fornecedor) REFERENCES fornecedor(id_fornecedor)
);

-- ESTOQUE (1:1 com produto)
CREATE TABLE estoque (
    id_produto INT PRIMARY KEY,
    quantidade INT,
    FOREIGN KEY (id_produto) REFERENCES produto(id_produto)
);

CREATE TABLE venda (
    id_venda INT PRIMARY KEY AUTO_INCREMENT,
    data_venda DATE NOT NULL,
    id_cliente INT NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente)
);

CREATE TABLE item_venda (
    id_item INT PRIMARY KEY AUTO_INCREMENT,
    id_venda INT NOT NULL,
    id_produto INT NOT NULL,
    quantidade INT NOT NULL,
    preco_unitario DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (id_venda) REFERENCES venda(id_venda),
    FOREIGN KEY (id_produto) REFERENCES produto(id_produto)
);

-- =========================
-- INSERTS
-- =========================

INSERT INTO cliente (nome, cpf, telefone) VALUES
('Maria Souza', '222.222.222-22', '(71) 9 9999-0002'),
('Carlos Oliveira', '333.333.333-33', '(71) 9 9999-0003'),
('Ana Santos', '444.444.444-44', '(71) 9 9999-0004'),
('Pedro Lima', '555.555.555-55', '(71) 9 9999-0005');

INSERT INTO fornecedor (nome, contato) VALUES
('Alimentos Nordeste', '(71) 9 8888-0002'),
('Distribuidora Brasil', '(11) 9 7777-0003'),
('Atacado Bom Preço', '(21) 9 6666-0004');

INSERT INTO produto (nome, preco) VALUES
('Feijão 1kg', 8.50),
('Macarrão 500g', 4.20),
('Óleo de Soja 900ml', 7.80),
('Açúcar 1kg', 5.60),
('Café 500g', 12.90);

INSERT INTO produto_fornecedor (id_produto, id_fornecedor) VALUES
(1, 1),
(2, 1),
(3, 2),
(4, 2),
(5, 3);

INSERT INTO estoque (id_produto, quantidade) VALUES
(1, 80),
(2, 150),
(3, 60),
(4, 90),
(5, 40);

INSERT INTO venda (data_venda, id_cliente) VALUES
('2026-04-02', 2),
('2026-04-03', 3),
('2026-04-04', 4),
('2026-04-05', 2);

INSERT INTO item_venda (id_venda, id_produto, quantidade, preco_unitario) VALUES
(1, 1, 2, 8.50),
(1, 2, 1, 4.20),
(2, 3, 1, 7.80);

-- =========================
-- UPDATE
-- =========================

UPDATE estoque
SET quantidade = quantidade - 4
WHERE id_produto = 4;

-- =========================
-- DELETE
-- =========================

DELETE FROM item_venda
WHERE id_item = 1;

-- =========================
-- SELECT SIMPLES
-- =========================

SELECT * FROM item_venda;

SELECT nome, preco FROM produto;

-- =========================
-- SELECT COM JOIN
-- =========================

SELECT venda.id_venda, cliente.nome, venda.data_venda
FROM venda
JOIN cliente ON venda.id_cliente = cliente.id_cliente;

SELECT venda.id_venda, cliente.nome, produto.nome AS produto, item_venda.quantidade
FROM venda
JOIN cliente ON venda.id_cliente = cliente.id_cliente
JOIN item_venda ON venda.id_venda = item_venda.id_venda
JOIN produto ON item_venda.id_produto = produto.id_produto;

-- =========================
-- SELECT COM GROUP BY
-- =========================

SELECT cliente.id_cliente, cliente.nome, SUM(item_venda.quantidade * item_venda.preco_unitario) AS total_gasto
FROM cliente
JOIN venda ON cliente.id_cliente = venda.id_cliente
JOIN item_venda ON venda.id_venda = item_venda.id_venda
GROUP BY cliente.id_cliente, cliente.nome;
