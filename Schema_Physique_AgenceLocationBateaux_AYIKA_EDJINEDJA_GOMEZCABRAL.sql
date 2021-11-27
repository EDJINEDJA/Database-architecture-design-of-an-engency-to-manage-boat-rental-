/*==============================================================*/
/* Nom de SGBD :  ORACLE Version 11g                            */
/* Date de création :  01/01/2021 12:23:35                      */
/*==============================================================*/


alter table BATEAU
   drop constraint FK_BATEAU_COUTER_TARIF;

alter table BATEAU
   drop constraint FK_BATEAU_LIER_CONTRAT;

alter table BATEAU
   drop constraint FK_BATEAU_POSSEDER_PROPRIET;

alter table CONTRAT
   drop constraint FK_CONTRAT_CHARGER_EMPLOYE;

alter table CONTRAT
   drop constraint FK_CONTRAT_CONCERNER_CLIENT;

alter table ENREGISTRER
   drop constraint FK_ENREGIST_ENREGISTR_BATEAU;

alter table ENREGISTRER
   drop constraint FK_ENREGIST_ENREGISTR_PORT;

alter table FAIRE
   drop constraint FK_FAIRE_FAIRE_EMPLOYE;

alter table FAIRE
   drop constraint FK_FAIRE_FAIRE2_ENTRETIE;

alter table PARCOURIR
   drop constraint FK_PARCOURI_PARCOURIR_TRAJET;

alter table PARCOURIR
   drop constraint FK_PARCOURI_PARCOURIR_BATEAU;

drop table BATEAU cascade constraints;

drop table CLIENT cascade constraints;

drop table CONTRAT cascade constraints;

drop table EMPLOYE cascade constraints;

drop table ENREGISTRER cascade constraints;

drop table ENTRETIEN cascade constraints;

drop table FAIRE cascade constraints;

drop table PARCOURIR cascade constraints;

drop table PORT cascade constraints;

drop table PROPRIETAIRE cascade constraints;

drop table TARIF cascade constraints;

drop table TRAJET cascade constraints;

/*==============================================================*/
/* Table : BATEAU                                               */
/*==============================================================*/
create table BATEAU 
(
   BANUMERO             NUMBER(4)            not null
      constraint CKC_BANUMERO_BATEAU check (BANUMERO between 1 and 1000),
   TANUMERO             NUMBER(4)            not null
      constraint CKC_TANUMERO_BATEAU check (TANUMERO between 1 and 1000),
   CONUMERO             NUMBER(4)           
      constraint CKC_CONUMERO_BATEAU check (CONUMERO is null or (CONUMERO between 1 and 1000)),
   PRNUMERO             NUMBER(4)            not null
      constraint CKC_PRNUMERO_BATEAU check (PRNUMERO between 1 and 1000),
   BANOM                VARCHAR2(40)         not null
      constraint CKC_BANOM_BATEAU check (BANOM = upper(BANOM)),
   BATYPE               VARCHAR2(40)         not null
      constraint CKC_BATYPE_BATEAU check (BATYPE = upper(BATYPE)),
   BACAPACITER          NUMBER(6)            not null
      constraint CKC_BACAPACITER_BATEAU check (BACAPACITER between 1 and 1000),
   BAPORT               VARCHAR2(60)         not null
      constraint CKC_BAPORT_BATEAU check (BAPORT = upper(BAPORT)),
   constraint PK_BATEAU primary key (BANUMERO)
);

/*==============================================================*/
/* Table : CLIENT                                               */
/*==============================================================*/
create table CLIENT 
(
   CLNUM                NUMBER(4)            not null
      constraint CKC_CLNUM_CLIENT check (CLNUM between 1 and 1000),
   CLNOM                VARCHAR2(40)         not null
      constraint CKC_CLNOM_CLIENT check (CLNOM = upper(CLNOM)),
   CLPRENOM             VARCHAR2(40)         not null
      constraint CKC_CLPRENOM_CLIENT check (CLPRENOM = upper(CLPRENOM)),
   CLCP                 NUMBER(6)            not null
      constraint CKC_CLCP_CLIENT check (CLCP between 1 and 100000),
   CLVILLE              VARCHAR2(40)         not null
      constraint CKC_CLVILLE_CLIENT check (CLVILLE = upper(CLVILLE)),
   CLTEL                VARCHAR2(12)         not null,
   constraint PK_CLIENT primary key (CLNUM)
);

/*==============================================================*/
/* Table : CONTRAT                                              */
/*==============================================================*/
create table CONTRAT 
(
   CONUMERO             NUMBER(4)            not null
      constraint CKC_CONUMERO_CONTRAT check (CONUMERO between 1 and 1000),
   EMNUMERO             NUMBER(4)            not null
      constraint CKC_EMNUMERO_CONTRAT check (EMNUMERO between 1 and 1000),
   CLNUM                NUMBER(4)            not null
      constraint CKC_CLNUM_CONTRAT check (CLNUM between 1 and 1000),
   COETAT               VARCHAR2(40)         not null
      constraint CKC_COETAT_CONTRAT check (COETAT = upper(COETAT)),
   CODC                 DATE                 not null,
   CODD                 DATE                 not null,
   CODF                 DATE                 not null,
   constraint PK_CONTRAT primary key (CONUMERO)
);

/*==============================================================*/
/* Table : EMPLOYE                                              */
/*==============================================================*/
create table EMPLOYE 
(
   EMNUMERO             NUMBER(4)            not null
      constraint CKC_EMNUMERO_EMPLOYE check (EMNUMERO between 1 and 1000),
   EMNOM                VARCHAR2(40)         not null
      constraint CKC_EMNOM_EMPLOYE check (EMNOM = upper(EMNOM)),
   EMPRENOM             VARCHAR2(40)         not null
      constraint CKC_EMPRENOM_EMPLOYE check (EMPRENOM = upper(EMPRENOM)),
   EMPROFESSION         VARCHAR2(40)         not null
      constraint CKC_EMPROFESSION_EMPLOYE check (EMPROFESSION = upper(EMPROFESSION)),
   EMVILLE              VARCHAR2(40)         not null
      constraint CKC_EMVILLE_EMPLOYE check (EMVILLE = upper(EMVILLE)),
   EMCODEPOSTAL         VARCHAR2(40)         not null,
   EMPAYS               VARCHAR2(40)         not null
      constraint CKC_EMPAYS_EMPLOYE check (EMPAYS = upper(EMPAYS)),
   EMDNAISS             DATE                 not null,
   EMDEMB               DATE                 not null,
   EMSALAIRE            NUMBER(6)            not null,
   constraint PK_EMPLOYE primary key (EMNUMERO)
);

/*==============================================================*/
/* Table : ENREGISTRER                                          */
/*==============================================================*/
create table ENREGISTRER 
(
   PONUMERO             NUMBER(4)            not null
      constraint CKC_PONUMERO_ENREGIST check (PONUMERO between 1 and 1000),
   BANUMERO             NUMBER(4)            not null
      constraint CKC_BANUMERO_ENREGIST check (BANUMERO between 1 and 1000),
   constraint PK_ENREGISTRER primary key (PONUMERO, BANUMERO)
);

/*==============================================================*/
/* Table : ENTRETIEN                                            */
/*==============================================================*/
create table ENTRETIEN 
(
   ENNUMERO             NUMBER(4)            not null
      constraint CKC_ENNUMERO_ENTRETIE check (ENNUMERO between 1 and 1000),
   ENDD                 DATE                 not null,
   ENDF                 DATE                 not null,
   constraint PK_ENTRETIEN primary key (ENNUMERO)
);

/*==============================================================*/
/* Table : FAIRE                                                */
/*==============================================================*/
create table FAIRE 
(
   ENNUMERO             NUMBER(4)            not null
      constraint CKC_ENNUMERO_FAIRE check (ENNUMERO between 1 and 1000),
   EMNUMERO             NUMBER(4)            not null
      constraint CKC_EMNUMERO_FAIRE check (EMNUMERO between 1 and 1000),
   constraint PK_FAIRE primary key (ENNUMERO, EMNUMERO)
);

/*==============================================================*/
/* Table : PARCOURIR                                            */
/*==============================================================*/
create table PARCOURIR 
(
   BANUMERO             NUMBER(4)            not null
      constraint CKC_BANUMERO_PARCOURI check (BANUMERO between 1 and 1000),
   TRNUMERO             NUMBER(4)            not null
      constraint CKC_TRNUMERO_PARCOURI check (TRNUMERO between 1 and 1000),
   constraint PK_PARCOURIR primary key (BANUMERO, TRNUMERO)
);

/*==============================================================*/
/* Table : PORT                                                 */
/*==============================================================*/
create table PORT 
(
   PONUMERO             NUMBER(4)            not null
      constraint CKC_PONUMERO_PORT check (PONUMERO between 1 and 1000),
   PONOM                VARCHAR2(40)         not null
      constraint CKC_PONOM_PORT check (PONOM = upper(PONOM)),
   POCAP                NUMBER(6)            not null
      constraint CKC_POCAP_PORT check (POCAP between 1 and 1000),
   POVILLE              VARCHAR2(40)        
      constraint CKC_POVILLE_PORT check (POVILLE is null or (POVILLE = upper(POVILLE))),
   constraint PK_PORT primary key (PONUMERO)
);

/*==============================================================*/
/* Table : PROPRIETAIRE                                         */
/*==============================================================*/
create table PROPRIETAIRE 
(
   PRNUMERO             NUMBER(4)            not null
      constraint CKC_PRNUMERO_PROPRIET check (PRNUMERO between 1 and 1000),
   PRNOM                VARCHAR2(40)         not null
      constraint CKC_PRNOM_PROPRIET check (PRNOM = upper(PRNOM)),
   PRPRENOM             VARCHAR2(40)         not null
      constraint CKC_PRPRENOM_PROPRIET check (PRPRENOM = upper(PRPRENOM)),
   PRCP                 NUMBER(6)            not null,
   PRVILLE              VARCHAR2(40)         not null
      constraint CKC_PRVILLE_PROPRIET check (PRVILLE = upper(PRVILLE)),
   PRTEL                VARCHAR2(12)         not null,
   PREMAIL              VARCHAR2(40)         not null
      constraint CKC_PREMAIL_PROPRIET check (PREMAIL = upper(PREMAIL)),
   constraint PK_PROPRIETAIRE primary key (PRNUMERO)
);

/*==============================================================*/
/* Table : TARIF                                                */
/*==============================================================*/
create table TARIF 
(
   TANUMERO             NUMBER(4)            not null
      constraint CKC_TANUMERO_TARIF check (TANUMERO between 1 and 1000),
   TAPRIX               NUMBER(6)            not null,
   constraint PK_TARIF primary key (TANUMERO)
);

/*==============================================================*/
/* Table : TRAJET                                               */
/*==============================================================*/
create table TRAJET 
(
   TRNUMERO             NUMBER(4)            not null
      constraint CKC_TRNUMERO_TRAJET check (TRNUMERO between 1 and 1000),
   TRDD                 DATE                 not null,
   TRDA                 DATE                 not null,
   TRPD                 VARCHAR2(40)         not null
      constraint CKC_TRPD_TRAJET check (TRPD = upper(TRPD)),
   TRPA                 VARCHAR2(40)         not null
      constraint CKC_TRPA_TRAJET check (TRPA = upper(TRPA)),
   constraint PK_TRAJET primary key (TRNUMERO)
);

alter table BATEAU
   add constraint FK_BATEAU_COUTER_TARIF foreign key (TANUMERO)
      references TARIF (TANUMERO);

alter table BATEAU
   add constraint FK_BATEAU_LIER_CONTRAT foreign key (CONUMERO)
      references CONTRAT (CONUMERO);

alter table BATEAU
   add constraint FK_BATEAU_POSSEDER_PROPRIET foreign key (PRNUMERO)
      references PROPRIETAIRE (PRNUMERO);

alter table CONTRAT
   add constraint FK_CONTRAT_CHARGER_EMPLOYE foreign key (EMNUMERO)
      references EMPLOYE (EMNUMERO);

alter table CONTRAT
   add constraint FK_CONTRAT_CONCERNER_CLIENT foreign key (CLNUM)
      references CLIENT (CLNUM);

alter table ENREGISTRER
   add constraint FK_ENREGIST_ENREGISTR_BATEAU foreign key (BANUMERO)
      references BATEAU (BANUMERO);

alter table ENREGISTRER
   add constraint FK_ENREGIST_ENREGISTR_PORT foreign key (PONUMERO)
      references PORT (PONUMERO);

alter table FAIRE
   add constraint FK_FAIRE_FAIRE_EMPLOYE foreign key (EMNUMERO)
      references EMPLOYE (EMNUMERO);

alter table FAIRE
   add constraint FK_FAIRE_FAIRE2_ENTRETIE foreign key (ENNUMERO)
      references ENTRETIEN (ENNUMERO);

alter table PARCOURIR
   add constraint FK_PARCOURI_PARCOURIR_TRAJET foreign key (TRNUMERO)
      references TRAJET (TRNUMERO);

alter table PARCOURIR
   add constraint FK_PARCOURI_PARCOURIR_BATEAU foreign key (BANUMERO)
      references BATEAU (BANUMERO);

