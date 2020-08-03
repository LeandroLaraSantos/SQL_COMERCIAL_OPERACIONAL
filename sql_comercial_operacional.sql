-- 2114 Gonçalves, 1329 Araújo, 3507 Mercale
-- Última cotação e média de preço das últimas entradas em 2 meses
-- Codigos das empresas
--   4:  Maracanã
--   5: Leblon
--   6: Getúlio
--   50: Centro de Distribuição
SELECT 
    produto.seqproduto AS "Cod. Produto"
   ,produto.desccompleta AS "Descrição"
   ,preco.PrecoNormal AS "Preço Praticado"
   ,preco.PrecoPromoc AS "Preço Promo"
   ,cotacao.seqconcorrente AS "Cód. Conc."
   ,cotacao.vlrprecopraticado AS "Pço Conc."
   ,cotacao.dtapesquisa AS "Data Cotacao."
   ,estoque.cmultvlrnf AS "Custo Brut. Unit"
   ,categoria.categoria AS "Categoria"
   ,estoque.estqloja AS "Estoque"
   ,entrada.vlritem AS "Vlr Entrada"
   ,estoque.nroempresa AS "Cod. Empresa"
   ,estoque.medvdiageral AS "Média de Venda Diária c/ Promo"
   ,CASE estoque.medvdiageral
        WHEN 0 THEN 0
        ELSE (estoque.estqloja / estoque.medvdiageral)
   END AS "Dias de estoque com promo"
   ,estoque.medvdiaforapromoc AS "Média de Venda Diária s/ Promo"
   ,CASE estoque.medvdiaforapromoc 
        WHEN 0 THEN 0
        ELSE (estoque.estqloja / estoque.medvdiaforapromoc)
   END AS "Dias de estoque sem promo"
   
FROM consinco.map_produto produto
     INNER JOIN consinco.Pdv_Categseqcategprod pivo_categoria 
           ON pivo_categoria.codproduto = produto.seqproduto
     INNER JOIN consinco.Map_Categoria categoria
           ON consinco.categoria.seqcategoria = pivo_categoria.seqcategoria
     INNER JOIN consinco.Mrl_produtoempresa estoque
           ON produto.seqproduto = estoque.seqproduto
     INNER JOIN consinco.mrlv_listaprecopricing preco
           ON produto.seqproduto = preco.seqproduto
     INNER JOIN consinco.mrl_cotacao cotacao
           ON produto.seqfamilia = cotacao.seqfamilia
     INNER JOIN consinco.maxv_abcentradabase entrada
           ON produto.seqproduto = entrada.seqproduto
       
WHERE 

     estoque.nroempresa in (4, 5, 6, 50)
     AND cotacao.seqconcorrente in (1329, 3507)
     AND cotacao.nroempresa = 5 -- Código empresa Leblon (Cotações)