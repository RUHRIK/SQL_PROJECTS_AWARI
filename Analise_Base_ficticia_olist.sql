#Com auxílio do arquivo abaixo padronize e limpe os dados
#de geolocalização em uma tabela separada de modo a nenhum dado da tabela de geolocalização deve ser perdido,
# a nova tabela deve conter 1.000.163 linhas.
SELECT
    UPPER(geolocation_zip_code_prefix) as CEP,
    UPPER( geolocation_state) AS ESTADO,
    UPPER( geolocation_city) CIDADE
FROM OLIST_GEOLOCATION;

#Quantos Clientes existem por estado ?
SELECT
    COUNT(DISTINCT customer_unique_id) AS ID,
    customer_state AS ESTADO
FROM OLIST_CUSTOMER
GROUP BY customer_state;

#Quais os 5 clientes com maior valor de compras? Quais os 5 com menor valor?
SELECT
    customer_unique_id as Cliente,
    VALOR_COMPRA
FROM(SELECT
         customer_unique_id,
        SUM(payment_value) AS VALOR_COMPRA,
        RANK() OVER (ORDER BY SUM(payment_value) DESC ) AS MAIORES_VALORES,
        RANK() OVER (ORDER BY SUM(payment_value)) AS MENORES_VALORES
     FROM OLIST_CUSTOMER AS CUS
     JOIN OLIST_ORDER AS ORD
     ON CUS.customer_id = ORD.customer_id
     JOIN OLIST_ORDER_PAYMENT AS PAY
     ON PAY.order_id = ORD.order_id
     GROUP BY customer_unique_id
     HAVING VALOR_COMPRA > 0) `*FÉ`
WHERE MAIORES_VALORES <=5 OR MENORES_VALORES <=5
ORDER BY VALOR_COMPRA DESC;

#Quais as 10 categorias de produtos que mais venderam em maio/2017 que estão com os
# status “approved”, “shipped”, “delivered”, “processing”, “created” ?
SELECT
    product_category_name ,
    COUNT(DISTINCT OIT.product_id) AS QTD_PRODUTOS
FROM OLIST_ORDER ORD
JOIN OLIST_ORDER_ITEM OIT
ON ORD.order_id = OIT.order_id
JOIN OLIST_PRODUCT PRD
ON PRD.product_id = OIT.product_id
WHERE order_status IN ('aproved', 'shipped', 'delivered', 'processing', 'created')
AND DATE(order_purchase_timestamp) BETWEEN '2017-05-01' AND '2017-05-31'
GROUP BY product_category_name
ORDER BY QTD_PRODUTOS DESC
LIMIT 10;

#Quais os 10 pedidos que mais demoram para chegar depois da data prevista de entrega?
SELECT order_id
	  ,customer_id
	  ,CAST(date(order_delivered_customer_date) - date(order_estimated_delivery_date) AS DATE) AS VL_DIAS_ATRASO
FROM OLIST_ORDER
WHERE order_status = 'delivered' AND (CAST(date(order_delivered_customer_date) - date(order_estimated_delivery_date) AS DATE)) > 0
ORDER BY VL_DIAS_ATRASO DESC
LIMIT 10;























