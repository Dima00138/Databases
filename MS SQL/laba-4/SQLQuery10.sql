USE T_MyBase;

SELECT ������.�����_������, ��������.�����_������
		FROM ������ INNER JOIN ��������
		ON ������.�����_������ = ��������.�����_������

SELECT ��������.������������_��������, ����_�����������_������.������������_�������� 
		FROM �������� INNER JOIN ����_�����������_������
		ON ��������.������������_�������� = ����_�����������_������.������������_��������
				AND ��������.������������_�������� LIKE '%op%'

SELECT ������.�����_������, ��������.�����_������
		FROM ������, ��������
		WHERE ������.�����_������ = ��������.�����_������

SELECT ��������.������������_��������, ����_�����������_������.������������_�������� 
		FROM ��������, ����_�����������_������
		WHERE ��������.������������_�������� = ����_�����������_������.������������_��������
				AND ��������.������������_�������� LIKE '%op%'

SELECT	����_�����������_������.�������_���������, ��������.����,
		CASE 
		WHEN (��������.���� BETWEEN 1 AND 1) THEN '����'
		WHEN (��������.���� BETWEEN 2 AND 7) THEN '2 - 7'
		WHEN (��������.���� > 8) THEN '������ ������'
		ELSE ''
		end [������]
		FROM �������� INNER JOIN ����_�����������_������
			ON ��������.�������_��������� = ����_�����������_������.�������_���������
								ORDER BY 
								��������.���� DESC;

SELECT	����_�����������_������.�������_���������, ��������.����,
		CASE 
		WHEN (��������.���� BETWEEN 1 AND 1) THEN '����'
		WHEN (��������.���� BETWEEN 2 AND 7) THEN '2 - 7'
		WHEN (��������.���� > 8) THEN '������ ������'
		ELSE ''
		end [������]
		FROM �������� INNER JOIN ����_�����������_������
			ON ��������.�������_��������� = ����_�����������_������.�������_���������
								ORDER BY 
								(CASE 
									WHEN(��������.���� BETWEEN 2 AND 7) THEN 4
									WHEN(��������.���� = 1) THEN 3
									WHEN(��������.���� > 7) THEN 2
									ELSE 1
								END) DESC;

SELECT ������.�����_������, ISNULL(��������.�����_������, 0)[�������� �� �������]
		FROM ������ LEFT OUTER JOIN ��������
			ON ������.�����_������ = ��������.�����_������;

SELECT ISNULL(��������.�����_������, 0)[�������� �� �������],  ������.�����_������
		FROM �������� RIGHT OUTER JOIN ������
			ON ��������.�����_������ = ������.�����_������;

SELECT ISNULL(��������.�����_������, 0)[�������� �� �������],  ������.�����_������
		FROM �������� FULL OUTER JOIN ������
			ON ��������.�����_������ = ������.�����_������;

SELECT ISNULL(��������.�����_������, 0)[�������� �� �������],  ������.�����_������
		FROM �������� CROSS JOIN ������
			WHERE ��������.�����_������ = ������.�����_������;