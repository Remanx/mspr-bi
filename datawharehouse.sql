/*==============================================================*/
/* Table : DW_CLIENT                                            */
/*==============================================================*/
create table DW_CLIENT 
(
   ID_CLIENT            INT            not null,
   NOM_CLIENT           VARCHAR(50),
   NOTEL                VARCHAR(10),
   EMAIL                VARCHAR(100),
   NOM_CONTACT          VARCHAR(50),
   ID_ADRESSE           INT,
   constraint PK_ID_CLIENT primary key (ID_CLIENT)
);

/*==============================================================*/
/* Table : DW_ADRESSE                                           */
/*==============================================================*/
create table DW_ADRESSE 
(
   ID_ADRESSE           SERIAL,
   NORUE                VARCHAR(10),
   RUE                  VARCHAR(100),
   CPOSTAL              INT,
   VILLE                VARCHAR(100),
   constraint PK_ID_ADRESSE primary key (ID_ADRESSE)
);

/*==============================================================*/
/* Table : DW_FOURNISSEUR                                          */
/*==============================================================*/
create table DW_FOURNISSEUR
(
   NO_FOURNISSEUR       SMALLINT            not null,
   NOM_FOURNISSEUR      VARCHAR(50),
   NOTEL                VARCHAR(10),
   EMAIL                VARCHAR(100),
   ID_ADRESSE           INT,
   constraint PK_FOURNISSEUR primary key (NO_FOURNISSEUR)
);

/*==============================================================*/
/* Table : DW_SITE_STOCK                                             */
/*==============================================================*/
create table DW_SITE_STOCK 
(
   ID_SITE_STOCK              SMALLINT  not null,
   HANGAR               SMALLINT,
   ALLEE                SMALLINT,
   constraint PK_ID_SITE_STOCK primary key (ID_SITE_STOCK)
);

/*==============================================================*/
/* Table : DW_SITE                                           */
/*==============================================================*/
create table DW_SITE 
(
   ID_SITE              SMALLINT  not null,
   ID_SITE_STOCK        SMALLINT,
   NOM_SITE               VARCHAR(MAX),
   NORUE                VARCHAR(10),
   RUE                  VARCHAR(100),
   CPOSTAL              INT,
   VILLE                VARCHAR(100),
   constraint PK_ID_SITE primary key (ID_SITE)
);

/*==============================================================*/
/* Table : DW_STOCK                                             */
/*==============================================================*/
create table DW_STOCK
(
   ID_STOCK             INT  not null,
   QUANTITE_STOCK       INT  not null,
   ID_SITE              SMALLINT            not null,
   constraint PK_ID_STOCK primary key (ID_STOCK)
);


	  
	  
/*==============================================================*/
/* Table : DW_ACHAT                                                */
/*==============================================================*/
create table DW_ACHAT 
(
   NO_ACHAT             INT            not null,
   COMMENT_ACHAT        VARCHAR(100),
   ID_FOURNISSEUR       SMALLINT            not null,
   QUANTITE_ACHAT       SMALLINT,
   QUANTITE_LIVRAISON       SMALLINT,
   constraint PK_DW_ACHAT primary key (NO_ACHAT)
);

/*==============================================================*/
/* Table : DW_TABLE_DE_FAIT_PRODUIT                             */
/*==============================================================*/
create table DW_TABLE_DE_FAIT_PRODUIT
(
   CODE_PRODUIT         VARCHAR(8) not null,
   CAT_NO_CATEGORIE     SMALLINT not null,
   NOM_CATEGORIE        VARCHAR(50),
   ID_VENTE              INT,
   ID_ACHAT              INT,
   ID_STOCK              INT,
   ID_DATE              TIMESTAMP,
   ID_DATE_LIVRAISON    TIMESTAMP,
   COMMENT_PRODUIT      VARCHAR(100),
   LONGEUR              DECIMAL(5,2),
   LARGEUR              DECIMAL(5,2),
   HAUTEUR              DECIMAL(5,2),
   PRIX_PIECE_HT        DECIMAL(5,2),
   NO_COMPOSER          SMALLINT,
   NO_FOURNISSEUR       SMALLINT,
   NO_PROPOSER          SMALLINT,
   constraint PK_CODE_PRODUIT primary key (CODE_PRODUIT)
);



/*==============================================================*/
/* Table : DW_VENTE                                             */
/*==============================================================*/
create table DW_VENTE 
(
   ID_VENTE      INT  not null,
   ID_CLIENT        INT  not null,
   QUANTITE_VENTE       SMALLINT,
   QUANTITE_LIVRAISON       SMALLINT,
   constraint PK_ID_VENTE primary key (ID_VENTE)
);

/*==============================================================*/
/* Table : DW_DATE                                            */
/*==============================================================*/
create table DW_DATE
(
   DATE       TIMESTAMP,
   JOUR INT  not null,
   MOIS INT  not null,
   ANNEE INT  not null,
   constraint PK_DATE primary key (DATE)
);


/*==============================================================*/
/* Table : COMPOSER                                             */
/*==============================================================*/
create table COMPOSER 
(
   NO_COMPOSER        SMALLINT          not null,
   NO_MATIERE           SMALLINT            not null,
   constraint PK_COMPOSER primary key (NO_COMPOSER)
); 

/*==============================================================*/
/* Table : MATIERE                                              */
/*==============================================================*/
create table MATIERE 
(
   NO_MATIERE           SMALLINT            not null,
   NOM_MATIERE          VARCHAR(70),
   constraint PK_MATIERE primary key (NO_MATIERE)
);


/*==============================================================*/
/* Table : PROPOSER                                             */
/*==============================================================*/
create table PROPOSER 
(
   NO_PROPOSER          SMALLINT          not null,
   NO_FOURNISSEUR       SMALLINT          not null,
   constraint PK_PROPOSER primary key (NO_PROPOSER)
);




alter table COMPOSER
    add constraint FK_NO_MATIERE foreign key (NO_MATIERE)
        references MATIERE (NO_MATIERE);

alter table DW_FOURNISSEUR
   add constraint FK_ID_ADRESSE foreign key (ID_ADRESSE)
      references DW_ADRESSE (ID_ADRESSE);

alter table DW_CLIENT
   add constraint FK_ID_ADRESSE foreign key (ID_ADRESSE)
      references DW_ADRESSE (ID_ADRESSE);

alter table DW_ACHAT
   add constraint FK_ID_FOURNISSEUR foreign key (ID_FOURNISSEUR)
      references DW_FOURNISSEUR (NO_FOURNISSEUR);

alter table DW_VENTE
   add constraint FK_ID_CLIENT foreign key (ID_CLIENT)
      references DW_CLIENT (ID_CLIENT);

alter table DW_STOCK
   add constraint FK_ID_SITE foreign key (ID_SITE)
      references DW_SITE (ID_SITE);

alter table DW_SITE
    add constraint FK_ID_SITE_STOCK foreign key (ID_SITE_STOCK)
        references DW_SITE_STOCK (ID_SITE_STOCK);
	  
alter table DW_TABLE_DE_FAIT_PRODUIT
   add constraint FK_ID_ACHAT foreign key (ID_ACHAT)
      references DW_ACHAT (NO_ACHAT);
	  
alter table DW_TABLE_DE_FAIT_PRODUIT
   add constraint FK_ID_VENTE foreign key (ID_VENTE)
      references DW_VENTE (ID_VENTE);	  
	  
alter table DW_TABLE_DE_FAIT_PRODUIT
   add constraint FK_ID_STOCK foreign key (ID_STOCK)
      references DW_STOCK (ID_STOCK);

alter table DW_TABLE_DE_FAIT_PRODUIT
   add constraint FK_ID_DATE foreign key (ID_DATE)
      references DW_DATE (DATE);
	  
alter table DW_TABLE_DE_FAIT_PRODUIT
   add constraint FK_ID_DATE_LIVRAISON foreign key (ID_DATE_LIVRAISON)
      references DW_DATE (DATE);

alter table DW_TABLE_DE_FAIT_PRODUIT
    add constraint FK_NO_COMPOSER foreign key (NO_COMPOSER)
        references COMPOSER (NO_COMPOSER); 

alter table DW_TABLE_DE_FAIT_PRODUIT
    add constraint FK_NO_PROPOSER foreign key (NO_PROPOSER)
        references PROPOSER (NO_PROPOSER);

alter table PROPOSER
    add constraint FK_NO_FOURNISSEUR foreign key (NO_FOURNISSEUR)
        references DW_FOURNISSEUR (NO_FOURNISSEUR);
