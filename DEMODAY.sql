#Quantidade de ligacoes por operador por estado
SELECT state_name as ESTADO,
      operator AS OPERADOR,
       COUNT(*) AS QNT_LIGACAO
FROM MYCALL_CALL
GROUP BY state_name, operator
ORDER BY QNT_LIGACAO DESC;

# Média de avaliação por operador.
SELECT operator as OPERADOR,
      AVG(rating) AS NOTA
     FROM MYCALL_CALL
GROUP BY operator
ORDER BY NOTA DESC;

# Categorias ordenadas por melhor avaliação
SELECT calldrop_category as CATEGORIA,
       avg(rating) as MEDIA_AVALIACAO
FROM  MYCALL_CALL
GROUP BY calldrop_category
ORDER BY MEDIA_AVALIACAO desc;

# Agrupamento de chamadas por tipo de conexão
SELECT inout_travelling AS CHAMADA,
       network_type AS CONEXAO
    FROM MYCALL_CALL
GROUP BY CHAMADA, CONEXAO
ORDER BY CONEXAO DESC;

# Tipos de conexão ordenadas da melhor para a pior avaliação (media)
SELECT network_type AS CONEXAO,
       AVG(rating) AS AVALIACAO
FROM MYCALL_CALL
GROUP BY CONEXAO
ORDER BY AVALIACAO DESC;





