SELECT        ������.������������, ������.����_��������
FROM            ������ INNER JOIN
                         ������ ON ������.������������_������ = ������.������������
WHERE        (������.����_�������� > CONVERT(DATETIME, '2023-10-22 00:00:00', 102))
ORDER BY ������.������������

SELECT        ����
FROM            ������
WHERE        (���� > 12 AND ���� < 33)
ORDER BY ���� DESC

SELECT        ������������_������, ��������
FROM            ������
WHERE        (������������_������ = '���')
ORDER BY ������������_������

SELECT        �����_������, ����_��������, ��������
FROM            ������
WHERE        (�������� = N'�����3')
ORDER BY ����_��������