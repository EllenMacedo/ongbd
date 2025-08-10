-- Tabela de cidades
CREATE TABLE cidade (
    id_cidade SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    uf CHAR(2) NOT NULL
);

-- Tabela de endereços
CREATE TABLE endereco (
    id_endereco SERIAL PRIMARY KEY,
    rua VARCHAR(100),
    numero VARCHAR(10),
    complemento VARCHAR(50),
    bairro VARCHAR(50),
    cep VARCHAR(10),
    id_cidade INTEGER,
    FOREIGN KEY (id_cidade) REFERENCES cidade(id_cidade) ON DELETE SET NULL
);

-- Tabela de usuários (base para login)
CREATE TABLE usuario (
    id_usuario SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    senha VARCHAR(255) NOT NULL,
    perfil VARCHAR(20) NOT NULL CHECK (perfil IN ('admin', 'voluntario', 'beneficiario', 'doador')),
    ativo BOOLEAN DEFAULT TRUE,
    criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    ultimo_login TIMESTAMP,
    id_endereco INTEGER,
    FOREIGN KEY (id_endereco) REFERENCES endereco(id_endereco) ON DELETE SET NULL
);

-- Tabela de telefones (múltiplos por usuário)
CREATE TABLE telefone (
    id_telefone SERIAL PRIMARY KEY,
    id_usuario INTEGER NOT NULL,
    numero VARCHAR(20) NOT NULL,
    tipo VARCHAR(20),
    FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario) ON DELETE CASCADE
);

-- Tabela de voluntários
CREATE TABLE voluntario (
    id_voluntario SERIAL PRIMARY KEY,
    id_usuario INTEGER UNIQUE NOT NULL,
    telefone VARCHAR(20),
    disponibilidade TEXT,
    habilidades TEXT,
    FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario) ON DELETE CASCADE
);

-- Tabela de doadores
CREATE TABLE doador (
    id_doador SERIAL PRIMARY KEY,
    id_usuario INTEGER UNIQUE NOT NULL,
    tipo_pessoa VARCHAR(20) NOT NULL CHECK (tipo_pessoa IN ('fisica', 'juridica')),
    telefone VARCHAR(20),
    FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario) ON DELETE CASCADE
);

-- Tabela de projetos
CREATE TABLE projeto (
    id_projeto SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    objetivo TEXT,
    status VARCHAR(30),
    data_inicio DATE,
    data_fim DATE
);

-- Tabela de beneficiários
CREATE TABLE beneficiario (
    id_beneficiario SERIAL PRIMARY KEY,
    id_usuario INTEGER UNIQUE NOT NULL,
    cpf VARCHAR(14),
    situacao TEXT,
    projeto_id INTEGER,
    FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario) ON DELETE CASCADE,
    FOREIGN KEY (projeto_id) REFERENCES projeto(id_projeto) ON DELETE SET NULL
);

-- Tabela de doações (entidade fraca)
CREATE TABLE doacao (
    id_doacao SERIAL NOT NULL,
    id_doador INTEGER NOT NULL,
    tipo VARCHAR(20) NOT NULL CHECK (tipo IN ('financeira', 'material')),
    valor NUMERIC(10,2),
    descricao TEXT,
    data DATE NOT NULL,
    PRIMARY KEY (id_doacao, id_doador),
    FOREIGN KEY (id_doador) REFERENCES doador(id_doador) ON DELETE CASCADE
);

-- Tabela de saídas (entidade fraca de doacao)
CREATE TABLE saida (
    id_saida SERIAL NOT NULL,
    id_doacao INTEGER NOT NULL,
    id_doador INTEGER NOT NULL,
    tipo VARCHAR(10) NOT NULL CHECK (tipo IN ('entrada', 'saida')),
    valor NUMERIC(10,2) NOT NULL,
    descricao TEXT,
    data DATE NOT NULL,
    projeto_id INTEGER,
    PRIMARY KEY (id_saida, id_doacao, id_doador),
    FOREIGN KEY (id_doacao, id_doador) REFERENCES doacao(id_doacao, id_doador) ON DELETE CASCADE,
    FOREIGN KEY (projeto_id) REFERENCES projeto(id_projeto) ON DELETE SET NULL
);

-- Relação N:N entre voluntários e projetos
CREATE TABLE voluntario_projeto (
    id_voluntario INTEGER,
    id_projeto INTEGER,
    papel VARCHAR(50),
    PRIMARY KEY (id_voluntario, id_projeto),
    FOREIGN KEY (id_voluntario) REFERENCES voluntario(id_voluntario) ON DELETE CASCADE,
    FOREIGN KEY (id_projeto) REFERENCES projeto(id_projeto) ON DELETE CASCADE
);

-- Tabela de eventos
CREATE TABLE evento (
    id_evento SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    descricao TEXT,
    data_inicio TIMESTAMP NOT NULL,
    data_fim TIMESTAMP,
    local VARCHAR(150),
    id_responsavel INTEGER,
    FOREIGN KEY (id_responsavel) REFERENCES usuario(id_usuario) ON DELETE SET NULL
);

-- Participação em eventos
CREATE TABLE participacao_evento (
    id_participacao SERIAL PRIMARY KEY,
    id_usuario INTEGER NOT NULL,
    id_evento INTEGER NOT NULL,
    papel VARCHAR(50),
    FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario) ON DELETE CASCADE,
    FOREIGN KEY (id_evento) REFERENCES evento(id_evento) ON DELETE CASCADE,
    UNIQUE (id_usuario, id_evento)
);

-- Tabela de documentos
CREATE TABLE documento (
    id_documento SERIAL PRIMARY KEY,
    nome_arquivo VARCHAR(150) NOT NULL,
    caminho_arquivo VARCHAR(255) NOT NULL,
    tipo_documento VARCHAR(50),
    id_projeto INTEGER,
    id_usuario INTEGER,
    data_upload TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_projeto) REFERENCES projeto(id_projeto) ON DELETE SET NULL,
    FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario) ON DELETE SET NULL
);

-- Tabela de feedback
CREATE TABLE feedback (
    id_feedback SERIAL PRIMARY KEY,
    id_usuario INTEGER NOT NULL,
    mensagem TEXT NOT NULL,
    data_envio TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario) ON DELETE CASCADE
);

-- Tabela de agenda
CREATE TABLE agenda (
    id_agenda SERIAL PRIMARY KEY,
    id_usuario INTEGER NOT NULL,
    titulo VARCHAR(100) NOT NULL,
    descricao TEXT,
    data_inicio TIMESTAMP NOT NULL,
    data_fim TIMESTAMP,
    local VARCHAR(150),
    FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario) ON DELETE CASCADE
);
