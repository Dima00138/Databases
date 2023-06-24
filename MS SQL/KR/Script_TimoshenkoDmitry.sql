use SHOP;

/* 1 ������� 
	����� ������, ������� ���������� ���������� �� ������ ���������� �������*/

SELECT ORDERS.CUST, ORDERS.PRODUCT FROM ORDERS
	INNER JOIN SALESREPS
	ON ORDERS.REP = SALESREPS.MANAGER
	INNER JOIN OFFICES
	ON SALESREPS.REP_OFFICE = OFFICES.OFFICE
		WHERE OFFICES.REGION LIKE '%Eastern%';
---

SELECT ORDERS.CUST, AVG(ORDERS.AMOUNT)[�� ����] FROM ORDERS
INNER JOIN CUSTOMERS
ON ORDERS.CUST = CUSTOMERS.CUST_NUM
	WHERE ORDERS.AMOUNT > 600
	GROUP BY ORDERS.CUST;
