USE HotelSaintGermain;

-- =====================================================
-- 1️ Alterar a data de entrada de todas as reservas para a data atual
-- =====================================================
UPDATE Reserva
SET Entrada = NOW();

-- =====================================================
-- 2️ Postergar a data de entrada de todas as reservas em um mês
-- =====================================================
UPDATE Reserva
SET Entrada = DATE_ADD(Entrada, INTERVAL 1 MONTH);

-- =====================================================
-- 3️ Alterar a cidade de todos os clientes brasileiros para “Curitiba”
-- =====================================================
UPDATE ClienteBrasileiro
SET Cidade = 'Curitiba';

-- =====================================================
-- 4️ Alterar o estado dos clientes residentes em “Curitiba” para “PR”
-- =====================================================
UPDATE ClienteBrasileiro
SET Estado = 'PR'
WHERE Cidade = 'Curitiba';

-- =====================================================
-- 5️ Alterar para “ND” os estados dos clientes que estão sem valor (nulos ou em branco)
-- =====================================================
UPDATE ClienteBrasileiro
SET Estado = 'ND'
WHERE Estado IS NULL OR TRIM(Estado) = '';

-- =====================================================
-- 6️ Aplicar acréscimo de 15% nas diárias dos quartos acima do 3º andar
-- =====================================================
UPDATE Quarto
SET VlrDiaria = VlrDiaria * 1.15
WHERE Andar > 3;

-- =====================================================
-- 7️ Baixar para 40% o valor das diárias dos quartos que não são ocupados há 2 anos
-- =====================================================
UPDATE Quarto
SET VlrDiaria = VlrDiaria * 0.40
WHERE Numero NOT IN (
    SELECT DISTINCT QuartoNumero
    FROM Ocupacao
    WHERE Saida >= DATE_SUB(NOW(), INTERVAL 2 YEAR)
);

-- =====================================================
-- 8️ Colocar a data e hora atuais como saída de todas as ocupações
-- =====================================================
UPDATE Ocupacao
SET Saida = NOW();

-- =====================================================
-- 9️ Excluir todas as reservas que estejam sem ocupação
-- =====================================================
DELETE FROM Reserva
WHERE Numero NOT IN (
    SELECT DISTINCT ReservaNumero
    FROM Ocupacao
);

-- =====================================================
-- 10 Excluir os quartos que nunca foram ocupados
-- =====================================================
DELETE FROM Quarto
WHERE Numero NOT IN (
    SELECT DISTINCT QuartoNumero
    FROM Ocupacao
);

-- =====================================================
-- 11 Excluir consumos de restaurante, frigobar e massagem anteriores a 2015
-- =====================================================
DELETE FROM OcupacaoRestaurante
WHERE YEAR(DataHora) < 2015;

DELETE FROM OcupacaoFrigobar
WHERE YEAR(DataHora) < 2015;

DELETE FROM OcupacaoMassagem
WHERE YEAR(DataHora) < 2015;
