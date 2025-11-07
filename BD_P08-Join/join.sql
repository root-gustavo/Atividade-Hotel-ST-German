USE HotelSaintGermain;

-- =====================================================
-- 1 Nome de todos os clientes e data de entrada de suas reservas (ordem alfabética)
-- =====================================================
SELECT C.Nome, R.Entrada
FROM Cliente C
JOIN Reserva R ON C.Id = R.ClienteId
ORDER BY C.Nome ASC;

-- =====================================================
-- 2 Nome e CPF de todos os clientes brasileiros
-- =====================================================
SELECT C.Nome, CB.Cpf
FROM Cliente C
JOIN ClienteBrasileiro CB ON C.Id = CB.ClienteId;

-- =====================================================
-- 3 Nome e passaporte de todos os clientes estrangeiros
-- =====================================================
SELECT C.Nome, CE.Passaporte
FROM Cliente C
JOIN ClienteEstrangeiro CE ON C.Id = CE.ClienteId;

-- =====================================================
-- 4 Número da reserva e nome do gerente de todas as reservas aprovadas
-- =====================================================
SELECT A.ReservaNumero, G.Nome AS Gerente
FROM Aprovacao A
JOIN Gerente G ON A.GerenteMatricula = G.Matricula;

-- =====================================================
-- 5 Número da reserva, descrição e valor dos pratos consumidos
-- =====================================================
SELECT ORest.ReservaNumero, R.Prato, R.Preco
FROM OcupacaoRestaurante ORest
JOIN Restaurante R ON ORest.RestauranteId = R.Id;

-- =====================================================
-- 6 Nome do cliente e tipo de pagamento de todas as ocupações pagas
-- =====================================================
SELECT C.Nome, TP.Descricao AS TipoPagamento
FROM PagamentoOcupacao PO
JOIN Reserva R ON PO.ReservaNumero = R.Numero
JOIN Cliente C ON R.ClienteId = C.Id
JOIN TipoPagamento TP ON PO.TipoPagamentoId = TP.Id;

-- =====================================================
-- 7 Nome do cliente e produtos utilizados nas massagens nos últimos 12 meses
-- =====================================================
SELECT C.Nome, OM.Produtos
FROM OcupacaoMassagem OM
JOIN Reserva R ON OM.ReservaNumero = R.Numero
JOIN Cliente C ON R.ClienteId = C.Id
WHERE OM.DataHora >= DATE_SUB(NOW(), INTERVAL 1 YEAR);

-- =====================================================
-- 8 Nome do cliente, data de nascimento e andar do quarto nos últimos 3 meses
-- =====================================================
SELECT C.Nome, C.DtaNasc, Q.Andar
FROM Ocupacao O
JOIN Reserva R ON O.ReservaNumero = R.Numero
JOIN Cliente C ON R.ClienteId = C.Id
JOIN Quarto Q ON O.QuartoNumero = Q.Numero
WHERE O.Entrada >= DATE_SUB(NOW(), INTERVAL 3 MONTH);

-- =====================================================
-- 9 Estado, cidade e nome do cliente nos últimos 5 anos
-- =====================================================
SELECT CB.Estado, CB.Cidade, C.Nome
FROM Ocupacao O
JOIN Reserva R ON O.ReservaNumero = R.Numero
JOIN Cliente C ON R.ClienteId = C.Id
JOIN ClienteBrasileiro CB ON C.Id = CB.ClienteId
WHERE O.Entrada >= DATE_SUB(NOW(), INTERVAL 5 YEAR);

-- =====================================================
-- 10 Nome do cliente, data prevista de entrada, entrada e saída da hospedagem, andar e número do quarto no ano corrente
-- =====================================================
SELECT C.Nome, R.Entrada AS DataPrevista, O.Entrada AS EntradaHospedagem, O.Saida AS SaidaHospedagem,
       Q.Andar, Q.Numero AS NumeroQuarto
FROM Ocupacao O
JOIN Reserva R ON O.ReservaNumero = R.Numero
JOIN Cliente C ON R.ClienteId = C.Id
JOIN Quarto Q ON O.QuartoNumero = Q.Numero
WHERE YEAR(O.Entrada) = YEAR(NOW());
