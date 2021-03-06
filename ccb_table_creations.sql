use DataStage
go

--create schema ccb

drop table if exists ccb.ConfigChangeBuild
create table ccb.ConfigChangeBuild (
    ConfigChangeBuildID int identity(1,1) not null primary key,
	BuildName nvarchar(255) not null,
	IsDeployed bit default(0) not null,
	DateLastDeployed datetime null,
	DateLastRolledBack datetime null,
	Ticket varchar(30) null,
	DateAdded datetime default(getdate()) not null,
	AddedBy varchar(100) default(user) not null,
	DateModified datetime null,
	ModifiedBy nvarchar(100) null,
	ModifiedVersion smallint default(0) not null,
	ModifiedReason nvarchar(255) null)

drop table if exists ccb.ConfigChangeBuildDetail
create table ccb.ConfigChangeBuildSummary (
    ConfigChangeBuildDetailID int identity(1,1) not null primary key,
	ConfigChangeBuildID int not null,
	EntityTypeID tinyint not null,
	EntityID bigint not null,
	EntityName nvarchar(255),
	ProcedureID bigint null,
	ConfigID int not null,
	ConfigValueNew nvarchar(255) null,
	ConfigValueOld nvarchar(255) null,
	ChangeOperationID tinyint not null)

drop table if exists ccb.EntityType 
create table ccb.EntityType (
    EntityTypeID smallint identity(1,1) not null primary key,
	EntityTypeName nvarchar(255) not null,
	EntityTypeDisplayName nvarchar(255) null,
	EntityDescription nvarchar(255) null,
	DateAdded datetime default(getdate()) not null,
	AddedBy nvarchar(100) default(user) not null,
	DateModified datetime null,
	ModifiedBy nvarchar(100) null,
	ModifiedVersion smallint default(0) not null,
	ModifiedReason nvarchar(255) null)

insert into ccb.EntityType (EntityTypeName, EntityTypeDisplayName)
values (('client'), ('Client')),
       (('plan'), ('Plan')),
	   (('employer'), ('Employer')),
	   (('employer_group'), ('Employer Group')),
	   (('treatment_client'), ('Client Treatment')),
	   (('treatment_plan'), ('Plan Treatment')),
	   (('treatment_employer'), ('Employer Treatment')),
	   (('treatment_employer_group'), ('Employer Group Treatment')),
	   (('default'), ('Default'))

drop table if exists ccb.ChangeOperation 
create table ccb.ChangeOperation (
    ChangeOperationID tinyint identity(1,1) not null primary key,
	ChangeOperationName nvarchar(255) not null,
	DateAdded datetime default(getdate()) not null,
	AddedBy nvarchar(100) default(user) not null,
	DateModified datetime null,
	ModifiedBy nvarchar(100) null,
	ModifiedVersion smallint default(0) not null,
	ModifiedReason nvarchar(255) null)

insert into ccb.ChangeOperation (ChangeOperationName)
values ('update'), ('insert'), ('delete')


drop table if exists ccb.Config
create table ccb.Config (
    ConfigID smallint identity(1,1) not null primary key,
	ConfigName nvarchar(255) not null,
	ConfigGroup nvarchar(255) not null,
	ConfigSubGroup nvarchar(255),
	ConfigDescription nvarchar(255),
	IsImplemented bit default(0),
	DateAdded datetime default(getdate()) not null,
	AddedBy nvarchar(100) default(user) not null,
	DateModified datetime null,
	ModifiedBy nvarchar(100) null,
	ModifiedVersion smallint default(0) not null,
	ModifiedReason nvarchar(255) null)

insert into ccb.Config (ConfigName, ConfigGroup, ConfigSubGroup, IsImplemented)
values (('show_incentives'), ('configuration'), ('incentives'), (1)),
       (('provider_type'), ('configuration'), ('incentives'), (1)),
	   (('minimum_incentive_amount'), ('configuration'), ('incentives'), (1)),
	   (('maximum_incentive_amount'), ('configuration'), ('incentives'), (1)),
	   (('percentage_of_savings'), ('configuration'), ('incentives'), (1)),
       (('static_tier_1'), ('incentive_amounts'), null, (1)),
       (('static_tier_2'), ('incentive_amounts'), null, (1)),
       (('static_tier_3'), ('incentive_amounts'), null, (1)),
	   (('treatment_code'), ('treatment_parameter'), null, (0)),
	   (('min_radius'), ('treatment_parameter'), null, (0)),
	   (('x12_code'), ('treatment_parameter'), null, (0)),
	   (('alternate_name'), ('treatment_parameter'), null, (0)),
	   (('use_ncct_description'), ('treatment_parameter'), null, (0)),
	   (('super_type'), ('treatment_parameter'), null, (0)),
	   (('treatment_code_external'), ('treatment_parameter'), null, (0)),
	   (('use_surgical_concierge'), ('treatment_parameter'), null, (0)),
	   (('is_rts'), ('treatment_parameter'), null, (0)),
	   (('rts_category'), ('treatment_parameter'), null, (0)),
	   (('is_suppressed'), ('treatment_parameter'), ('treatment_plan'), (0))
