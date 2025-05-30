//criar banco
CREATE DATABASE oasi_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE oasi_db;

-- Tabela de Usuários
CREATE TABLE usuarios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    telefone VARCHAR(50),
    -- senha_hash VARCHAR(255) NOT NULL,
    criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

-- Tabela de Produtos
CREATE TABLE produtos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_vendedor INT NOT NULL,
    nome VARCHAR(255) NOT NULL,
    preco DECIMAL(10, 2) NOT NULL,
    nivel_sustentabilidade INT,
    descricao TEXT,
    imagem_url VARCHAR(500),
    criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_vendedor) REFERENCES usuarios(id) ON DELETE CASCADE
) ENGINE=InnoDB;

-- Tabela de Carrinhos
CREATE TABLE carrinhos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    nome VARCHAR(255) NOT NULL,
    proposito TEXT,
    criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id) ON DELETE CASCADE
) ENGINE=InnoDB;

-- Tabela de Junção: carrinho_produtos
CREATE TABLE carrinho_produtos (
    id_carrinho INT NOT NULL,
    id_produto INT NOT NULL,
    quantidade INT NOT NULL DEFAULT 1,
    adicionado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id_carrinho, id_produto),
    FOREIGN KEY (id_carrinho) REFERENCES carrinhos(id) ON DELETE CASCADE,
    FOREIGN KEY (id_produto) REFERENCES produtos(id) ON DELETE CASCADE
) ENGINE=InnoDB;

-- Opcional: Adicionar alguns índices para melhorar a performance de buscas comuns
CREATE INDEX idx_produtos_id_vendedor ON produtos(id_vendedor);
CREATE INDEX idx_carrinhos_id_usuario ON carrinhos(id_usuario);

//inserir dados genericos
INSERT INTO usuarios (id, nome, email, telefone) VALUES (1, 'Usuário Teste', 'teste@oasi.com', '99999-8888');
INSERT INTO carrinhos (id_usuario, nome, proposito) VALUES (1, 'Compras de Supermercado Semanais', 'Itens essenciais para casa');
INSERT INTO carrinhos (id_usuario, nome, proposito) VALUES (1, 'Presentes de Aniversário - Maria', 'Comprar presentes para a festa da Maria');

