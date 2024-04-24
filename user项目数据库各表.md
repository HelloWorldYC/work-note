---
title: user 数据库各表
---

- [数据库各表](#数据库各表)
  - [user\_info 表](#user_info-表)
  - [programming\_user\_info](#programming_user_info)
  - [user\_country 表](#user_country-表)
  - [user\_hospital 表](#user_hospital-表)
  - [user\_login\_lock\_info 表](#user_login_lock_info-表)
  - [user\_mfa\_info 表](#user_mfa_info-表)
  - [user\_oauth 表](#user_oauth-表)
  - [user\_password 表](#user_password-表)
  - [user\_phone\_number 表](#user_phone_number-表)
  - [user\_role 表](#user_role-表)
  - [user\_role\_district\_qc\_center 表](#user_role_district_qc_center-表)
  - [user\_role\_mtc\_qc\_center 表](#user_role_mtc_qc_center-表)
  - [role\_authority 表](#role_authority-表)
  - [role\_district\_qc\_center 表](#role_district_qc_center-表)
  - [role\_mtc\_qc\_center 表](#role_mtc_qc_center-表)
  - [role\_info 表](#role_info-表)
  - [role\_hospital 表](#role_hospital-表)
  - [role\_user\_hospital 表](#role_user_hospital-表)
  - [authority\_info 表](#authority_info-表)
  - [hospital\_login\_lock\_rule 表](#hospital_login_lock_rule-表)
  - [hospital\_password\_rule 表](#hospital_password_rule-表)
  - [route\_info 表](#route_info-表)
  - [flyway\_schema\_history 表](#flyway_schema_history-表)


# 数据库各表

## user_info 表
该表是用户的总表，存储了用户的相关信息，其中的用户可能是其他各个系统的用户。  
值得注意的几个字段是：
- `id`：实际的用户 id，通过雪花算法计算得到的。
- `uuid`：原本的用户 id，是项目一开始使用的，但是没有加密，现在已没有用该字段。
- `avatar`：用户的头像路径。
- `is_employee`：是否是公司员工。
- `is_root`：是否是后台管理系统的管理员。

## programming_user_info
该表是编程用户的表，是一类特殊的用户，使用工作站的角色。
- `uuid`：实际用户 id，通过雪花算法计算得到
- `password`：编程用户账户的密码，账号是是 `username`
- `resume`：用户简介

## user_country 表
该表是用户的国籍表，存储了国家信息。  
- `id`：数据行 id
- `iso`：两位阿拉丁字符的国家代码，这种代码拥有多种用途,其中最重要的一个用途与互联网的地理级别域名有关
- `name`：国家名称
- `chinese_name`：国家的中文名称
- `iso3`：三位阿拉丁字符组成的国家代码
- `number_code`：三位阿拉伯数字组成的国家代码
- `phone_code`：国家的电话区号
- `available`：表示是否可在当前国家区域注册

## user_hospital 表
该表是医院用户的表，其中包含了医院和科室等信息。一个用户可能对应有多个医院。  
- `id`：数据行 id
- `user_id`：用户 id
- `hospital_id`：所属医院的 id
- `department_id`：所属科室 id
- `id_primary`：是否是该用户的主要或者默认的医院。

## user_login_lock_info 表
该表是用户登录的锁信息，其中包含了用户登录错误的信息。   
- `login_error_times`：用户登录的错误次数。
- `lock_end_time`：用户账户锁定的结束时间。
- `last_login_error_time`：上次登录失败的时间

## user_mfa_info 表
该表是用户登录时进行 MFA 验证的信息表。  
- `secret`：用户登录的 MFA 密钥
- `account`：用户的 MFA 账号
- `issuer`：用户 MFA 账号的授权机构

## user_oauth 表
该表是用户认证表，主要用于微信认证登录。  
- `oauth_name`：认证名，应该是指认证方式
- `oauth_uid`：认证方式的用户 id，例如微信的用户 id
- `access_token`：微信给予的认证令牌，通过令牌可以获取到用户的微信信息
- `expires_in`：令牌的有效时间
- `refresh_token`：刷新的令牌
- `scope`：作用范围
- `user_uuid`：本系统的用户 id

## user_password 表
该表是用户账户的密码表。
- `password`：用户的密码，MD5 加密
- `bcrypt_password`：用户密码经过 bcrypt 加密后的密码。

## user_phone_number 表
该表是用户的电话表。
- `format_number`：完整格式的电话号码，包括国家代码的，如 +86 13825239448
- `number_carrier`：电话所属的运营商
- `number_type`：手机还是固定电话

## user_role 表
该表是用户在工作站所承担的角色，不同的角色有不同的权限。  
- `role_id`：角色类型的 id。

## user_role_district_qc_center 表
该表是用户行政质控中心的表  
`role_id`：用户在所属行政质控中心中所承担的角色 id
- `district_qc_center_id`：用户所属行政质控中心的 id

## user_role_mtc_qc_center 表
该表是医联体质控中心的表
- `role_id`：用户在所属医联体质控中心中所承担的角色 id
- `mtc_qc_center_id`：用户所属医联体质控中心的 id

## role_authority 表
该表存储角色所拥有的权限，一个角色很可能有多个权限。
- `role_info_id`：角色类型 id
- `authority_info_id`：角色拥有的权限类型 id

## role_district_qc_center 表
该表存储角色对应的行政质控中心信息，与 user_role_district_qc_center 表所对应。
- `role_id`：用户在行政质控中心承担的角色
- `district_qc_center_id`：用户所属行政质控中心的 id

## role_mtc_qc_center 表
该表是医联体质控中心的表，存储用户所在的医联体质控中心以及在其中的角色，与 user_role_mtc_qc_center 表所对应。
- `mtc_qc_center_id`：用户所属医联体质控中心的 id

## role_info 表
角色表，该表存储了所有角色的信息。
- `role_name`：角色名称
- `application_id`：该角色所属系统的 id，有工作站、云 PACS、云质控、北美兽用等系统
- `is_default`：该角色是否是所属系统的默认角色

## role_hospital 表
该表存储角色在系统中所属医院科室等信息。
- `role_id`：角色 id
- `hospital_id`：医院 id
- `department_id`：科室 id

## role_user_hospital 表
该表是用户在云PACS 等系统上的角色，这个与医院科室是关联的，与工作站对应的表 user_role 要区分开。


## authority_info 表
该表是权限表，存储各类权限，一种权限对应一个功能。
- `id`：权限 id
- `authority_name`：权限名称
- `service_info_id`：权限所对应的微服务项目 id，也可以认为是系统 id，因为每个系统对应一个微服务
- `description`：描述权限所对应的功能
- `module_name`：对应后台管理系统中用户组权限中权限列表的分类，如用户、设备这几类。


## hospital_login_lock_rule 表
该表存储各医院登录错误时锁定规则，与 user_login_lock_info 表很像。
- `hospital_id`：医院 id
- `department_id`：科室 id
- `login_error_times`：规定的最大登录失败次数，失败次数达到该次数时锁定
- `lock_time`：锁定的时间，单位：分钟

## hospital_password_rule 表
该表存储各医院所要求的密码规则，是否需要大小写字母、数字、特殊字符、最小长度等。
- `effective_time`：密码的有效期，过了这个有效期就需要重新设置密码

## route_info 表
该表是路由表，存储各路由的信息。
- `route_id`：路由标识
- `route_name`：路由名称，如 /api/uniqc/login/district-qc-center
- `request_method`：请求的方法，GET、POST、PUT、DELETE
- `route_match_pattern`：路由匹配模式，带有路径参数：正则表达式；不带路径参数：与route_name相同'，如 /api/uniqc/urgent-value-evaluation/misdiagnosis/submit/[0-9]*
- `authority_name`：权限名称，对应 authority_info 表中的权限名
- `is_open`：是否为开放接口，0 不开放，1 开放
- `application_id`：路由所属应用，1 华声云、2 云 PACS、3 云客服、4 后台管理、5 前置机、6 云质控、7 行政质控中心、8 医联体质控中心


## flyway_schema_history 表
- `installed_rank`：Flyway中的一个特殊字段，用于确定哪些迁移已经被应用，哪些尚未被应用
- `version`：数据库版本
- `description`：更新的原因
- `type`：更新的方式，SQL 还是 JDBC
- `script`：更新的代码脚本，SQL 更新方式对应的是 sql 文件，JDBC 方式对应的是 db/migration 中文件
- `checksum`：校验和，数据迁移时通过校验和判断代码脚本是否发生变更
- `installed_by`：发起数据迁移的对象
- `installed_on`：更新的时间
- `execution_time`：执行脚本的时间
- `sucess`：更新是否成功，1 成功，0 不成功