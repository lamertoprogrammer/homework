
--CREATE
CREATE TABLE "OBJECT_TYPES" (
    "OBJECT_TYPE_ID" NUMBER(10,0) PRIMARY KEY,
    "PARENT_ID" NUMBER(10,0),
    "NAME" NVARCHAR2(32) ,
    "DESCRIPTION" NVARCHAR2(64),
    "PROPERTIES" NVARCHAR2(64)
);

ALTER TABLE OBJECT_TYPES ADD FOREIGN KEY
(PARENT_ID) REFERENCES OBJECT_TYPES (OBJECT_TYPE_ID);

CREATE TABLE "ATTR_TYPES"  (
    "ATTR_TYPE_ID" NUMBER(10,0) PRIMARY KEY,
    "NAME" NVARCHAR2(32) ,
    "PROPERTIES" NVARCHAR2(64)
);

CREATE TABLE "ATTR_GROUPS" (
    "ATTR_GROUP_ID" NUMBER(10,0) PRIMARY KEY,
    "NAME" NVARCHAR2(32) ,
    "PROPERTIES" NVARCHAR2(64)
);

CREATE TABLE "ATTRIBUTES" (
    "ATTR_ID" NUMBER(10,0) PRIMARY KEY,
    "ATTR_TYPE_ID" NUMBER(10,0) NOT NULL,
    "ATTR_GROUP_ID" NUMBER(10,0) NOT NULL,
    "NAME" NVARCHAR2(32),
    "DESCRIPTION" NVARCHAR2(64),
    "ISMULTIPLE" NUMBER(1,0),
    "PROPERTIES" NVARCHAR2(64)
);

ALTER TABLE ATTRIBUTES ADD FOREIGN KEY
(ATTR_TYPE_ID) REFERENCES ATTR_TYPES(ATTR_TYPE_ID);

ALTER TABLE ATTRIBUTES ADD FOREIGN KEY
(ATTR_GROUP_ID) REFERENCES ATTR_GROUPS(ATTR_GROUP_ID);

CREATE TABLE "ATTR_BINDS" (
    "OBJECT_TYPE_ID" NUMBER(10,0) NOT NULL,
    "ATTR_ID" NUMBER(10,0) NOT NULL,
    "OPTIONS" NVARCHAR2(32) ,
    "ISREQUARED" NUMBER(1,0),
    "DEFAULT_VALUE" NVARCHAR2(64)
);

ALTER TABLE ATTR_BINDS ADD FOREIGN KEY
(OBJECT_TYPE_ID) REFERENCES OBJECT_TYPES(OBJECT_TYPE_ID);

ALTER TABLE ATTR_BINDS ADD FOREIGN KEY
(ATTR_ID) REFERENCES ATTRIBUTES(ATTR_ID);

CREATE TABLE "OBJECTS" (
     "OBJECT_ID" NUMBER(10,0) PRIMARY KEY,
     "PARENT_ID" NUMBER(10,0), 
     "OBJECT_TYPE_ID" NUMBER(10,0) NOT NULL, 
     "NAME" NVARCHAR2(32), 
     "DESCRIPTION" NVARCHAR2(64), 
     "ORDER_NUMBER " NUMBER(3,0)
);

ALTER TABLE OBJECTS ADD FOREIGN KEY
(PARENT_ID) REFERENCES OBJECTS (OBJECT_ID);

ALTER TABLE OBJECTS ADD FOREIGN KEY
(OBJECT_TYPE_ID) REFERENCES OBJECT_TYPES(OBJECT_TYPE_ID);

CREATE TABLE "PARAMS" (
    "ATTR_ID" NUMBER(10,0) NOT NULL,
    "OBJECT_ID" NUMBER(10,0) NOT NULL,
    "VALUE" NVARCHAR2(64),
    "DATE_VALUE" DATE,
    "SHOW_ORDER" NUMBER(3,0)
);

ALTER TABLE PARAMS ADD FOREIGN KEY
(ATTR_ID) REFERENCES ATTRIBUTES(ATTR_ID);

ALTER TABLE PARAMS ADD FOREIGN KEY
(OBJECT_ID) REFERENCES OBJECTS(OBJECT_ID);

CREATE TABLE "REFERENCES" (
    "ATTR_ID" NUMBER(10,0) NOT NULL,
    "OBJECT_ID" NUMBER(10,0) NOT NULL, 
    "REFERENCE" NUMBER(10,0) NOT NULL, 
    "SHOW_ORDER" NUMBER(3,0)
);

ALTER TABLE REFERENCES ADD FOREIGN KEY
(ATTR_ID) REFERENCES ATTRIBUTES(ATTR_ID);

ALTER TABLE REFERENCES ADD FOREIGN KEY
(OBJECT_ID) REFERENCES OBJECTS(OBJECT_ID);

ALTER TABLE REFERENCES ADD FOREIGN KEY
(REFERENCE) REFERENCES OBJECTS(OBJECT_ID);


--INSERT

INSERT INTO OBJECT_TYPES 
VALUES ( 1, NULL, 'Transistor', 'Транзистор', '...' );

INSERT INTO OBJECT_TYPES 
VALUES ( 2, NULL, 'Capacitor', 'Конденсатор', '...' );

INSERT INTO OBJECT_TYPES 
VALUES ( 3, 1, 'MOSFET Transistor', 'Полевой транзистор', '...' );

INSERT INTO OBJECT_TYPES 
VALUES ( 4, 2, 'Ceramic capacitor', 'Керамический конденсатор', '...' );

INSERT INTO OBJECT_TYPES 
VALUES ( 5, NULL, 'Sound card', 'Звуковая карта', '...' );
--------------------------------------------------------------------------------
INSERT INTO OBJECTS 
VALUES ( 1, NULL, 5, 'Builtin sound card', 'Sound Blaster Audigy', 1 );

INSERT INTO OBJECTS 
VALUES ( 2, NULL, 5, 'External sound card ', 'Focusrite Scarlett 2i2', 1 );

INSERT INTO OBJECTS 
VALUES ( 3, 1, 4, 'Capacitor1', 'Murata grm21', 1 );

INSERT INTO OBJECTS 
VALUES ( 4, 1, 1, 'Transistor1', 'NXP BSH103.215', 1 );

INSERT INTO OBJECTS 
VALUES ( 5, 1, 3, 'Transistor2', 'Fairchild NDS331N', 1 );

INSERT INTO OBJECTS 
VALUES ( 6, 2, 2, 'Capacitor2', 'Murata grm40', 1 );
--------------------------------------------------------------------------------
INSERT INTO ATTR_TYPES 
VALUES ( 1, 'Capacity', '...' );

INSERT INTO ATTR_TYPES 
VALUES ( 2, 'Voltage', '...' );

INSERT INTO ATTR_TYPES 
VALUES ( 3, 'Frequency', '...' );

INSERT INTO ATTR_TYPES 
VALUES ( 4, 'Current', '...' );

INSERT INTO ATTR_TYPES 
VALUES ( 5, 'Object reference', '...' );
--------------------------------------------------------------------------------
INSERT INTO ATTR_GROUPS 
VALUES ( 1, 'Transistor attributes', '...' );

INSERT INTO ATTR_GROUPS 
VALUES ( 2, 'Capacitor attributes', '...' );

INSERT INTO ATTR_GROUPS 
VALUES ( 3, 'Sound card attributes', '...' );

INSERT INTO ATTR_GROUPS 
VALUES ( 4, 'MOSFET transistor attributes', '...' );
--------------------------------------------------------------------------------
INSERT INTO ATTRIBUTES 
VALUES ( 1, 1, 2, 'Max capacity', 'Максимальная емкость, мкф', 0, '...' );

INSERT INTO ATTRIBUTES 
VALUES ( 2, 2, 1, 'Operating voltage', 'Рабочее напряжение, В', 0, '...' );

INSERT INTO ATTRIBUTES 
VALUES ( 3, 3, 3, 'Sampling frequency', 'Частота дискретизации, кГц', 0, '...' );

INSERT INTO ATTRIBUTES 
VALUES ( 4, 4, 1, 'Max current', 'Максимальный ток, A', 0, '...' );

INSERT INTO ATTRIBUTES 
VALUES ( 5, 5, 2, 'Capacitor-transistor', '', 1, '...' );

INSERT INTO ATTRIBUTES 
VALUES ( 6, 4, 4, 'MOSFET test current', 'тестовый ток MOSFETов, A', 0, '...' );

INSERT INTO ATTRIBUTES 
VALUES ( 7, 4, 4, 'MOSFET test current', 'тестовый ток MOSFETов2, A', 0, '...' );

--------------------------------------------------------------------------------
INSERT INTO ATTR_BINDS 
VALUES ( 1, 2, 'Transistor operating voltage', 1, NULL );

INSERT INTO ATTR_BINDS 
VALUES ( 2, 1, 'Capacitor max capacity', 1, NULL );

INSERT INTO ATTR_BINDS 
VALUES ( 1, 4, 'Transistor max current', 1, NULL );

INSERT INTO ATTR_BINDS 
VALUES ( 3, 6, 'MOSFET test current', 1, NULL );

INSERT INTO ATTR_BINDS 
VALUES ( 3, 6, 'MOSFET test current2', 1, NULL );

INSERT INTO ATTR_BINDS 
VALUES ( 5, 3, 'Sound card sampling frequency', 1, NULL );

INSERT INTO ATTR_BINDS 
VALUES ( 2, 5, 'Connected transistor', 1, NULL );

--------------------------------------------------------------------------------
INSERT INTO REFERENCES 
VALUES ( 5, 3, 4, 1 );

INSERT INTO REFERENCES 
VALUES ( 5, 3, 5, 1 );
--------------------------------------------------------------------------------
INSERT INTO PARAMS 
VALUES ( 3, 1, '192', NULL, 1 ); 

INSERT INTO PARAMS 
VALUES ( 6, 5, '0.5', NULL, 1 ); 

INSERT INTO PARAMS 
VALUES ( 6, 5, '0.5', NULL, 1 ); 

INSERT INTO PARAMS 
VALUES ( 3, 2, '96', NULL, 1 ); 

INSERT INTO PARAMS 
VALUES ( 1, 3, '10', NULL, 1 ); 

INSERT INTO PARAMS 
VALUES ( 4, 4, '0.85', NULL, 1 ); 

INSERT INTO PARAMS 
VALUES ( 2, 4, '30', NULL, 1 ); 
 
INSERT INTO PARAMS 
VALUES ( 4, 5, '1.3', NULL, 1 ); 

INSERT INTO PARAMS 
VALUES ( 2, 5, '20', NULL, 1 ); 


--SELECT

--1. Получение информации обо всех атрибутах(учитывая только 
--атрибутную группу и атрибутные типы)(attr_id, attr_name, attr_group_id, attr_group_name, attr_type_id, attr_type_name)
SELECT ATTRIBUTES.ATTR_ID, ATTRIBUTES.NAME AS ATTR_NAME, ATTRIBUTES.ATTR_GROUP_ID, ATTR_GROUPS.NAME AS ATTR_GROUP_NAME, ATTRIBUTES.ATTR_TYPE_ID, ATTR_TYPES.NAME AS ATTR_TYPE_NAME
FROM ATTRIBUTES 
JOIN ATTR_GROUPS ON  ATTRIBUTES.ATTR_GROUP_ID = ATTR_GROUPS.ATTR_GROUP_ID
JOIN ATTR_TYPES ON ATTRIBUTES.ATTR_TYPE_ID = ATTR_TYPES.ATTR_TYPE_ID;

--2. Получение всех атрибутов для заданного объектного типа, 
--без учета наследования(attr_id, attr_name )
SELECT ATTRIBUTES.ATTR_ID, ATTRIBUTES.NAME AS ATTR_NAME 
FROM ATTRIBUTES 
JOIN ATTR_BINDS ON ATTRIBUTES.ATTR_ID = ATTR_BINDS.ATTR_ID 
WHERE OBJECT_TYPE_ID = 2;

--3. Получение иерархии ОТ(объектных типов)  
--для заданного объектного типа(нужно получить иерархию наследования) (ot_id, ot_name, level)
SELECT OBJECT_TYPE_ID AS OT_ID, NAME AS OT_NAME, LEVEL
FROM OBJECT_TYPES
START WITH OBJECT_TYPE_ID = 3
CONNECT BY PRIOR PARENT_ID = OBJECT_TYPE_ID;

--4. Получение вложенности объектов для заданного 
--объекта(нужно получить иерархию вложенности)(obj_id, obj_name, level)
SELECT OBJECT_ID AS OBJ_ID, NAME AS OBJ_NAME, LEVEL
FROM OBJECTS
START WITH OBJECT_ID = 3
CONNECT BY PRIOR PARENT_ID = OBJECT_ID;

--5. Получение объектов заданного 
--объектного типа(учитывая только наследование ОТ)(ot_id, ot_name, obj_id, obj_name)
SELECT OBJECT_TYPE_ID AS OT_ID, OBJECT_TYPES.NAME AS OT_NAME, OBJECT_ID AS OBJ_ID, OBJECTS.NAME AS OBJ_NAME 
FROM  OBJECTS 
JOIN OBJECT_TYPES USING (OBJECT_TYPE_ID)
WHERE OBJECT_TYPE_ID IN (
        SELECT OBJECT_TYPE_ID FROM OBJECT_TYPES
        START WITH OBJECT_TYPE_ID = 3
        CONNECT BY OBJECT_TYPE_ID = PRIOR PARENT_ID);

--6. Получение значений всех атрибутов(всех возможных типов) для 
--заданного объекта(без учета наследования ОТ)(attr_id, attr_name, value)
SELECT ATTRIBUTES.ATTR_ID, ATTRIBUTES.NAME AS ATTR_NAME, PARAMS.VALUE
FROM ATTRIBUTES
LEFT JOIN PARAMS
ON ATTRIBUTES.ATTR_ID = PARAMS.ATTR_ID
LEFT JOIN REFERENCES
ON REFERENCES.ATTR_ID = ATTRIBUTES.ATTR_ID
WHERE REFERENCES.OBJECT_ID= 3 OR PARAMS.OBJECT_ID = 3;
 
--7. Получение ссылок 
--на заданный объект(все объекты, которые ссылаются на текущий)(ref_id, ref_name)
SELECT REFERENCES.REFERENCE AS REF_ID, OBJECTS.NAME AS REF_NAME 
FROM REFERENCES 
JOIN OBJECTS USING (OBJECT_ID )
WHERE OBJECT_ID = 3;

--8. Получение значений всех атрибутов(всех возможных типов, без повторяющихся атрибутов) 
--для заданного объекта( с учетом наследования ОТ) Вывести в виде см. п.6
SELECT DISTINCT ATTR_ID, ATTRIBUTES.NAME AS ATTR_NAME, VALUE FROM (
    SELECT * FROM (
        SELECT ATTR_ID
        FROM OBJECTS
        RIGHT JOIN ATTR_BINDS USING (OBJECT_TYPE_ID)
        WHERE OBJECT_TYPE_ID IN (
            SELECT OBJECT_TYPE_ID
            FROM OBJECT_TYPES
            START WITH OBJECT_TYPE_ID = (SELECT OBJECT_TYPE_ID FROM OBJECTS WHERE OBJECT_ID = 5)
            CONNECT BY PRIOR PARENT_ID = OBJECT_TYPE_ID
        ) 
    )
    left JOIN (
        SELECT ATTR_ID, 
               VALUE, 
               DATE_VALUE, 
               REFERENCE 
        FROM PARAMS
        FULL OUTER JOIN REFERENCES USING (ATTR_ID)
        WHERE PARAMS.OBJECT_ID = 5 OR REFERENCES.OBJECT_ID = 5
    )
    USING (ATTR_ID)
)
JOIN ATTRIBUTES USING (ATTR_ID);
