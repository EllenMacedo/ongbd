-- Inserir 5 cidades
INSERT INTO cidade (nome, uf) VALUES
('São Paulo', 'SP'),
('Rio de Janeiro', 'RJ'),
('Belo Horizonte', 'MG'),
('Curitiba', 'PR'),
('Porto Alegre', 'RS');

-- Inserir 5 endereços
INSERT INTO endereco (rua, numero, complemento, bairro, cep, id_cidade) VALUES
('Rua das Flores', '100', 'Apto 101', 'Centro', '01001000', 1),
('Av. Paulista', '2000', NULL, 'Bela Vista', '01310000', 1),
('Rua da Praia', '50', NULL, 'Copacabana', '22070000', 2),
('Rua das Acácias', '150', 'Casa', 'Savassi', '30140000', 3),
('Av. Paraná', '500', NULL, 'Centro', '80010000', 4);

-- Inserir 5 usuários (com perfis diferentes)
INSERT INTO usuario (nome, email, senha, perfil, ativo, id_endereco) VALUES
('Ana Silva', 'ana.silva@email.com', 'senha123', 'admin', TRUE, 1),
('Carlos Pereira', 'carlos.pereira@email.com', 'senha123', 'voluntario', TRUE, 2),
('Mariana Souza', 'mariana.souza@email.com', 'senha123', 'beneficiario', TRUE, 3),
('João Lima', 'joao.lima@email.com', 'senha123', 'doador', TRUE, 4),
('Fernanda Gomes', 'fernanda.gomes@email.com', 'senha123', 'voluntario', TRUE, 5);

-- Inserir telefones para usuários (vários por usuário)
INSERT INTO telefone (id_usuario, numero, tipo) VALUES
(1, '11999990000', 'celular'),
(1, '1133333000', 'fixo'),
(2, '21988887777', 'celular'),
(3, '31977776666', 'celular'),
(4, '41955554444', 'celular');

-- Inserir voluntários (associados aos usuários voluntarios)
INSERT INTO voluntario (id_usuario, telefone, disponibilidade, habilidades) VALUES
(2, '21988887777', 'Segunda a Sexta, manhã', 'Ensino, apoio social'),
(5, '41999998888', 'Finais de semana', 'Comunicação, organização');

-- Inserir doadores (associados a usuário do perfil doador)
INSERT INTO doador (id_usuario, tipo_pessoa, telefone) VALUES
(4, 'fisica', '41955554444');

-- Inserir projetos
INSERT INTO projeto (nome, objetivo, status, data_inicio, data_fim) VALUES
('Projeto Social 1', 'Apoio à educação', 'ativo', '2024-01-01', NULL),
('Projeto Saúde', 'Campanha de vacinação', 'ativo', '2024-02-15', '2024-12-31'),
('Projeto Ambiental', 'Reflorestamento', 'planejado', '2025-03-01', NULL),
('Projeto Inclusão', 'Inclusão digital', 'ativo', '2024-05-01', NULL),
('Projeto Esportivo', 'Atividades físicas para jovens', 'concluído', '2023-01-01', '2023-12-31');

-- Inserir beneficiários (associados a usuários do perfil beneficiario)
INSERT INTO beneficiario (id_usuario, cpf, situacao, projeto_id) VALUES
(3, '123.456.789-00', 'ativo', 1);

-- Inserir doações
INSERT INTO doacao (id_doacao, id_doador, tipo, valor, descricao, data) VALUES
(1, 1, 'financeira', 500.00, 'Doação para projeto social', '2024-06-01'),
(2, 1, 'material', NULL, 'Doação de alimentos', '2024-06-05'),
(3, 1, 'financeira', 1000.00, 'Doação para campanha de vacinação', '2024-06-10'),
(4, 1, 'material', NULL, 'Doação de roupas', '2024-06-12'),
(5, 1, 'financeira', 300.00, 'Doação para projeto ambiental', '2024-06-15');

-- Inserir saídas (movimentações financeiras de doações)
INSERT INTO saida (id_saida, id_doacao, id_doador, tipo, valor, descricao, data, projeto_id) VALUES
(1, 1, 1, 'saida', 400.00, 'Compra de materiais', '2024-06-20', 1),
(2, 3, 1, 'saida', 800.00, 'Custos de campanha', '2024-06-25', 2),
(3, 5, 1, 'saida', 250.00, 'Compra de mudas', '2024-07-01', 3),
(4, 1, 1, 'entrada', 500.00, 'Recebimento doação', '2024-06-01', 1),
(5, 3, 1, 'entrada', 1000.00, 'Recebimento doação', '2024-06-10', 2);

-- Inserir relação voluntário-projeto
INSERT INTO voluntario_projeto (id_voluntario, id_projeto, papel) VALUES
(1, 1, 'Coordenador');

-- Inserir eventos
INSERT INTO evento (nome, descricao, data_inicio, data_fim, local, id_responsavel) VALUES
('Evento de Arrecadação', 'Arrecadação de fundos para projeto social', '2024-07-10 09:00', '2024-07-10 17:00', 'Centro Comunitário', 1),
('Palestra sobre Saúde', 'Palestra para a comunidade sobre saúde preventiva', '2024-08-01 18:00', '2024-08-01 20:00', 'Auditório', 2),
('Mutirão Ambiental', 'Limpeza e plantio na área verde', '2024-09-05 08:00', '2024-09-05 12:00', 'Parque Central', 3),
('Treinamento de Voluntários', 'Capacitação para novos voluntários', '2024-10-15 14:00', '2024-10-15 18:00', 'Sala de Treinamento', 2),
('Festa de Encerramento', 'Celebração de conclusão do projeto', '2024-12-20 19:00', '2024-12-20 23:00', 'Salão de Festas', 1);

-- Inserir participações em eventos
INSERT INTO participacao_evento (id_usuario, id_evento, papel) VALUES
(1, 1, 'Organizador'),
(2, 1, 'Voluntário'),
(3, 2, 'Participante'),
(4, 3, 'Doador'),
(5, 4, 'Instrutor');

-- Inserir documentos
INSERT INTO documento (nome_arquivo, caminho_arquivo, tipo_documento, id_projeto, id_usuario) VALUES
('relatorio_final.pdf', '/docs/relatorio_final.pdf', 'relatório', 1, 1),
('foto_evento.jpg', '/docs/foto_evento.jpg', 'imagem', 2, 2),
('planejamento.docx', '/docs/planejamento.docx', 'documento', 3, 3),
('manual_voluntario.pdf', '/docs/manual_voluntario.pdf', 'manual', 4, 2),
('contrato_doador.pdf', '/docs/contrato_doador.pdf', 'contrato', 5, 4);

-- Inserir feedbacks
INSERT INTO feedback (id_usuario, mensagem) VALUES
(1, 'Ótimo sistema, muito útil!'),
(2, 'Gostaria de mais opções para voluntários.'),
(3, 'Agradeço pelo apoio recebido.'),
(4, 'Fácil realizar doações pelo sistema.'),
(5, 'Eventos bem organizados, parabéns!');

-- Inserir agenda
INSERT INTO agenda (id_usuario, titulo, descricao, data_inicio, data_fim, local) VALUES
(1, 'Reunião de equipe', 'Discussão sobre novos projetos', '2024-07-01 10:00', '2024-07-01 12:00', 'Sala 101'),
(2, 'Visita ao projeto social', 'Acompanhamento das atividades', '2024-07-05 09:00', '2024-07-05 11:00', 'Projeto Social 1'),
(3, 'Consulta médica', 'Consulta agendada', '2024-07-10 14:00', '2024-07-10 15:00', 'Clínica Central'),
(4, 'Entrega de doação', 'Entrega de alimentos', '2024-07-12 08:00', '2024-07-12 09:00', 'Centro Comunitário'),
(5, 'Treinamento voluntários', 'Capacitação para novos voluntários', '2024-07-15 13:00', '2024-07-15 17:00', 'Sala de Treinamento');
