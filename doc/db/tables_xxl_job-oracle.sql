-- Create table
create table XXL_JOB_GROUP
(
  id           INTEGER not null,
  app_name     VARCHAR2(150) not null,
  title        VARCHAR2(50) not null,
  group_order  INTEGER default 0 not null,
  address_type INTEGER default 0 not null,
  address_list VARCHAR2(1000)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
-- Add comments to the table 
comment on table XXL_JOB_GROUP
  is '执行器信息表';
-- Add comments to the columns 
comment on column XXL_JOB_GROUP.app_name
  is '执行器AppName';
comment on column XXL_JOB_GROUP.title
  is '执行器名称';
comment on column XXL_JOB_GROUP.group_order
  is '排序';
comment on column XXL_JOB_GROUP.address_type
  is '执行器地址类型：0=自动注册、1=手动录入';
comment on column XXL_JOB_GROUP.address_list
  is '执行器地址列表，多地址逗号分隔';
-- Create/Recreate indexes 
create index IDX_XXL_JOB_GROUP_APP_NAME on XXL_JOB_GROUP (APP_NAME)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
create index IDX_XXL_JOB_GROUP_GROUP_ORDER on XXL_JOB_GROUP (GROUP_ORDER)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
-- Create/Recreate primary, unique and foreign key constraints 
alter table XXL_JOB_GROUP
  add constraint PK_XXL_JOB_GROUP_ID primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
  
  -- Create table
create table XXL_JOB_INFO
(
  id                        INTEGER not null,
  job_group                 INTEGER not null,
  job_cron                  VARCHAR2(128) not null,
  job_desc                  VARCHAR2(500) not null,
  add_time                  DATE,
  update_time               DATE,
  author                    VARCHAR2(500),
  alarm_email               VARCHAR2(500),
  executor_route_strategy   VARCHAR2(150),
  executor_handler          VARCHAR2(500),
  executor_param            VARCHAR2(1000),
  executor_block_strategy   VARCHAR2(150),
  executor_timeout          INTEGER default 0 not null,
  executor_fail_retry_count INTEGER default 0 not null,
  glue_type                 VARCHAR2(150) not null,
  glue_source               CLOB,
  glue_remark               VARCHAR2(128),
  glue_updatetime           DATE,
  child_jobid               VARCHAR2(500),
  trigger_status            INTEGER default 0 not null,
  trigger_last_time         NUMBER default 0 not null,
  trigger_next_time         NUMBER default 0 not null
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
-- Add comments to the table 
comment on table XXL_JOB_INFO
  is '调度信息表';
-- Add comments to the columns 
comment on column XXL_JOB_INFO.id
  is '主键';
comment on column XXL_JOB_INFO.job_group
  is '执行器主键ID';
comment on column XXL_JOB_INFO.job_cron
  is '任务执行CRON';
comment on column XXL_JOB_INFO.job_desc
  is '任务描述';
comment on column XXL_JOB_INFO.add_time
  is '添加时间';
comment on column XXL_JOB_INFO.update_time
  is '更新时间';
comment on column XXL_JOB_INFO.author
  is '作者';
comment on column XXL_JOB_INFO.alarm_email
  is '报警邮件';
comment on column XXL_JOB_INFO.executor_route_strategy
  is '执行器路由策略';
comment on column XXL_JOB_INFO.executor_handler
  is '执行器任务handler';
comment on column XXL_JOB_INFO.executor_param
  is '执行器任务参数';
comment on column XXL_JOB_INFO.executor_block_strategy
  is '阻塞处理策略';
comment on column XXL_JOB_INFO.executor_timeout
  is '任务执行超时时间，单位秒';
comment on column XXL_JOB_INFO.executor_fail_retry_count
  is '失败重试次数';
comment on column XXL_JOB_INFO.glue_type
  is 'GLUE类型';
comment on column XXL_JOB_INFO.glue_source
  is 'GLUE源代码';
comment on column XXL_JOB_INFO.glue_remark
  is 'GLUE备注';
comment on column XXL_JOB_INFO.glue_updatetime
  is 'GLUE更新时间';
comment on column XXL_JOB_INFO.child_jobid
  is '子任务ID，多个逗号分隔';
comment on column XXL_JOB_INFO.trigger_status
  is '调度状态：0-停止，1-运行';
comment on column XXL_JOB_INFO.trigger_last_time
  is '上次调度时间';
comment on column XXL_JOB_INFO.trigger_next_time
  is '下次调度时间';
-- Create/Recreate indexes 
create index IDX_XXL_JOB_AUTHOR on XXL_JOB_INFO (AUTHOR)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
create index IDX_XXL_JOB_EXECUTOR_HANDLER on XXL_JOB_INFO (EXECUTOR_HANDLER)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
create index IDX_XXL_JOB_JOB_GROUP on XXL_JOB_INFO (JOB_GROUP)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
create index IDX_XXL_JOB_TRIGGER_STATUS on XXL_JOB_INFO (TRIGGER_STATUS)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
-- Create/Recreate primary, unique and foreign key constraints 
alter table XXL_JOB_INFO
  add constraint PK_XXL_JOB_INFO_ID primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

  
  -- Create table
create table XXL_JOB_LOCK
(
  lock_name VARCHAR2(150) not null
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
-- Add comments to the table 
comment on table XXL_JOB_LOCK
  is '锁信息';
-- Add comments to the columns 
comment on column XXL_JOB_LOCK.lock_name
  is '锁名称';
-- Create/Recreate primary, unique and foreign key constraints 
alter table XXL_JOB_LOCK
  add constraint PK_XXL_JOB_LOCK_ primary key (LOCK_NAME)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

-- Create table
create table XXL_JOB_LOG
(
  id                        INTEGER not null,
  job_group                 INTEGER not null,
  job_id                    INTEGER not null,
  executor_address          VARCHAR2(500),
  executor_handler          VARCHAR2(500),
  executor_param            VARCHAR2(1000),
  executor_sharding_param   VARCHAR2(50),
  executor_fail_retry_count INTEGER default 0 not null,
  trigger_time              DATE,
  trigger_code              INTEGER not null,
  trigger_msg               CLOB,
  handle_time               DATE,
  handle_code               INTEGER not null,
  handle_msg                CLOB,
  alarm_status              INTEGER default 0 not null
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
-- Add comments to the table 
comment on table XXL_JOB_LOG
  is '任务日志信息';
-- Add comments to the columns 
comment on column XXL_JOB_LOG.id
  is '主键ID';
comment on column XXL_JOB_LOG.job_group
  is '执行器主键ID';
comment on column XXL_JOB_LOG.job_id
  is '任务，主键ID';
comment on column XXL_JOB_LOG.executor_address
  is '执行器地址，本次执行的地址';
comment on column XXL_JOB_LOG.executor_handler
  is '执行器任务handler';
comment on column XXL_JOB_LOG.executor_param
  is '执行器任务参数';
comment on column XXL_JOB_LOG.executor_sharding_param
  is '执行器任务分片参数，格式如 1/2';
comment on column XXL_JOB_LOG.executor_fail_retry_count
  is '失败重试次数';
comment on column XXL_JOB_LOG.trigger_time
  is '调度-时间';
comment on column XXL_JOB_LOG.trigger_code
  is '调度-结果';
comment on column XXL_JOB_LOG.trigger_msg
  is '调度-日志';
comment on column XXL_JOB_LOG.handle_time
  is '执行-时间';
comment on column XXL_JOB_LOG.handle_code
  is '执行-状态';
comment on column XXL_JOB_LOG.handle_msg
  is '执行-日志';
comment on column XXL_JOB_LOG.alarm_status
  is '告警状态：0-默认、1-无需告警、2-告警成功、3-告警失败';
-- Create/Recreate indexes 
create index IDX_XXL_JOB_LOG_HANDLE_CODE on XXL_JOB_LOG (HANDLE_CODE)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
create index IDX_XXL_JOB_LOG_HANDLE_TIME on XXL_JOB_LOG (HANDLE_TIME)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
create index IDX_XXL_JOB_LOG_JOB_GROUP on XXL_JOB_LOG (JOB_GROUP)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
create index IDX_XXL_JOB_LOG_JOB_ID on XXL_JOB_LOG (JOB_ID)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
create index IDX_XXL_JOB_LOG_TRIGGER_CODE on XXL_JOB_LOG (TRIGGER_CODE)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
create index IDX_XXL_JOB_LOG_TRIGGER_TIME on XXL_JOB_LOG (TRIGGER_TIME)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
-- Create/Recreate primary, unique and foreign key constraints 
alter table XXL_JOB_LOG
  add constraint PK_XXL_JOB_LOG_ID primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

  
  -- Create table
create table XXL_JOB_LOGGLUE
(
  id          INTEGER not null,
  job_id      INTEGER not null,
  glue_type   VARCHAR2(150),
  glue_source CLOB,
  glue_remark VARCHAR2(256) not null,
  add_time    DATE,
  update_time DATE
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
-- Add comments to the table 
comment on table XXL_JOB_LOGGLUE
  is '任务GLUE日志';
-- Add comments to the columns 
comment on column XXL_JOB_LOGGLUE.id
  is '主键ID';
comment on column XXL_JOB_LOGGLUE.job_id
  is '任务，主键ID';
comment on column XXL_JOB_LOGGLUE.glue_type
  is 'GLUE类型';
comment on column XXL_JOB_LOGGLUE.glue_source
  is 'GLUE源代码';
comment on column XXL_JOB_LOGGLUE.glue_remark
  is 'GLUE备注';
comment on column XXL_JOB_LOGGLUE.add_time
  is '添加时间';
comment on column XXL_JOB_LOGGLUE.update_time
  is '更新时间';
-- Create/Recreate indexes 
create index IDX_XXL_JOB_LOGGLUE_JOB_ID on XXL_JOB_LOGGLUE (JOB_ID)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
-- Create/Recreate primary, unique and foreign key constraints 
alter table XXL_JOB_LOGGLUE
  add constraint PK_XXL_JOB_LOGGLUE_ID primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
-- Create table
create table XXL_JOB_REGISTRY
(
  id             INTEGER not null,
  registry_group VARCHAR2(500) not null,
  registry_key   VARCHAR2(500) not null,
  registry_value VARCHAR2(500) not null,
  update_time    DATE
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
-- Add comments to the table 
comment on table XXL_JOB_REGISTRY
  is '执行器注册表';
-- Add comments to the columns 
comment on column XXL_JOB_REGISTRY.id
  is '主键ID';
comment on column XXL_JOB_REGISTRY.registry_group
  is '注册组';
comment on column XXL_JOB_REGISTRY.registry_key
  is '注册key';
comment on column XXL_JOB_REGISTRY.registry_value
  is '注册value';
comment on column XXL_JOB_REGISTRY.update_time
  is '修改时间';
-- Create/Recreate primary, unique and foreign key constraints 
alter table XXL_JOB_REGISTRY
  add constraint PK_XXL_JOB_REGISTRY_ID primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

  
  
  -- Create table
create table XXL_JOB_USER
(
  id         INTEGER not null,
  username   VARCHAR2(150) not null,
  password   VARCHAR2(150) not null,
  role       INTEGER not null,
  permission VARCHAR2(500)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
-- Add comments to the table 
comment on table XXL_JOB_USER
  is '登录用户信息';
-- Add comments to the columns 
comment on column XXL_JOB_USER.id
  is '主键ID';
comment on column XXL_JOB_USER.username
  is '账号';
comment on column XXL_JOB_USER.password
  is '密码';
comment on column XXL_JOB_USER.role
  is '角色：0-普通用户、1-管理员';
comment on column XXL_JOB_USER.permission
  is '权限：执行器ID列表，多个逗号分割';
-- Create/Recreate primary, unique and foreign key constraints 
alter table XXL_JOB_USER
  add constraint PK_XXL_JOB_USER_ID primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

  -- Create table
create table XXL_JOB_LOG_REPORT
(
  id            NUMBER(11) not null,
  trigger_day   DATE,
  running_count NUMBER(11) default '0' not null,
  suc_count     NUMBER(11) default '0' not null,
  fail_count    NUMBER(11) default '0' not null
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
  
COMMENT ON COLUMN XXL_JOB_LOG_REPORT.trigger_day IS
'调度-时间';
COMMENT ON COLUMN XXL_JOB_LOG_REPORT.running_count IS
'运行中-日志数量';
COMMENT ON COLUMN XXL_JOB_LOG_REPORT.suc_count IS
'执行成功-日志数量';
COMMENT ON COLUMN XXL_JOB_LOG_REPORT.fail_count IS
'执行失败-日志数量';
-- Create/Recreate primary, unique and foreign key constraints 
alter table XXL_JOB_LOG_REPORT
  add primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255;
