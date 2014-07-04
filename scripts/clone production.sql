drop table account;
create table account as select * from mac_financial_admin.account;

drop table asset_liability;
create table asset_liability as select * from mac_financial_admin.asset_liability;

drop table asset_liability_class;
create table asset_liability_class as select * from mac_financial_admin.asset_liability_class;

drop table bank_record;
create table bank_record as select * from MAC_FINANCIAL_ADMIN.bank_record;

drop table category;
create table category as select * from mac_financial_admin.category;

drop table meta_category;
create table meta_category as select * from mac_financial_admin.meta_category;

drop table planned_transaction;
create table planned_transaction as select * from mac_financial_admin.planned_transaction;

drop table transaction;
create table transaction as select * from mac_financial_admin.transaction;

drop table year_beginning_resources;
create table year_beginning_resources as select * from mac_financial_admin.year_beginning_resources;

drop table budget_item;
create table budget_item as select * from mac_financial_admin.budget_item;

--drop sequence hibernate_sequence;
--create sequence hibernate_sequence start with 9774;