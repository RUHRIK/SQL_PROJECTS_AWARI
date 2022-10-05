#Gere uma amostra com 70% dos pedidos.
SELECT
    ORD.order_id as ID,
    DATE(order_purchase_timestamp) AS DT_COMPRA,
    payment_type AS FORMA_DE_PAGAMENTO,
    price AS PRECO,
    freight_value AS VALOR_FRETE
FROM OLIST_ORDER AS ORD
JOIN OLIST_ORDER_ITEM AS OIT
    ON ORD.order_id = OIT.order_id
JOIN OLIST_ORDER_PAYMENT AS PAY
    ON ORD.order_id = PAY.order_id
JOIN (SELECT
          order_id,
                    PERCENT_RANK() OVER (ORDER BY RAND()) AS RK_PEDIDOS
                        FROM OLIST_ORDER
        WHERE order_status IN('approved','shipped','delivered', 'processing', 'created')
                            AND DATE(order_purchase_timestamp) BETWEEN '2017-01-01' AND '2018-08-31') AS TMP
    ON TMP.order_id = ORD.order_id
WHERE RK_PEDIDOS <=0.7;

