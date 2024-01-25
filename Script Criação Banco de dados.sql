-- CRIANDO SCHEMA KARAOKE E USUARIO -- 
DROP USER IF EXISTS 'user'@'localhost';
DROP SCHEMA IF EXISTS karaoke;
CREATE SCHEMA karaoke;
USE karaoke;
CREATE USER 'user'@'localhost' IDENTIFIED BY 'karaoke123';
GRANT SELECT, INSERT, DELETE, UPDATE ON karaoke.* TO 'user'@'localhost';

-- CRIANDO TABELAS --
CREATE TABLE musica (
    id INT PRIMARY KEY AUTO_INCREMENT,
    titulo VARCHAR(255),
    artista VARCHAR(255),
    genero VARCHAR(100),
    anoLancamento INT
);

CREATE TABLE usuario (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(255),
    email VARCHAR(255) UNIQUE,
    senha VARCHAR(255),
    dataCadastro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    dataUltimaAtualizacao TIMESTAMP,
    ativo BOOLEAN DEFAULT true
);

CREATE TABLE permissao (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nomePermissao VARCHAR(50) UNIQUE
);

CREATE TABLE usuarioPermissao (
    idUsuario INT,
    idPermissao INT,
    PRIMARY KEY (idUsuario, idPermissao),
    FOREIGN KEY (idUsuario) REFERENCES usuario(id),
    FOREIGN KEY (idPermissao) REFERENCES permissao(id)
);

CREATE TABLE pedido (
    id INT PRIMARY KEY AUTO_INCREMENT,
    idMusica INT,
    numeroMesa INT,
    idUsuario INT,
    dataPedido TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (idMusica) REFERENCES musica(id),
    FOREIGN KEY (idUsuario) REFERENCES usuario(id)
);

CREATE TABLE listasReproducao (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nomeLista VARCHAR(255),
    idUsuario INT,
    FOREIGN KEY (idUsuario) REFERENCES usuario(id)
);

CREATE TABLE listasReproducaomusica (
    idLista INT,
    idMusica INT,
    ordem INT,
    PRIMARY KEY (idLista, idMusica),
    FOREIGN KEY (idLista) REFERENCES listasReproducao(id),
    FOREIGN KEY (idMusica) REFERENCES musica(id)
);
