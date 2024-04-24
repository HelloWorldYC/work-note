---
title: 初识DDD
---

- [什么是 DDD？](#什么是-ddd)
- [DDD 中的一些概念](#ddd-中的一些概念)
  - [DP](#dp)
    - [DP 的定义](#dp-的定义)
    - [DP 的优点](#dp-的优点)
    - [使用 Domain Primitive 的三原则](#使用-domain-primitive-的三原则)
    - [Domain Primitive 和 DDD 里 Value Object 的区别](#domain-primitive-和-ddd-里-value-object-的区别)
    - [Domain Primitive 和 Data Transfer Object 的区别](#domain-primitive-和-data-transfer-object-的区别)
    - [什么情况下应该用 Domain Primitive](#什么情况下应该用-domain-primitive)
  - [Entity、BO、VO、PO、DTO、POJO](#entitybovopodtopojo)
    - [VO](#vo)
    - [PO](#po)
    - [Entity](#entity)
    - [DTO](#dto)
    - [DAO](#dao)
    - [BO](#bo)
    - [POJO](#pojo)
    - [DO](#do)


# 什么是 DDD？

领域设计（Domain-Driven Design，简称DDD）是一种软件开发方法论，旨在帮助开发者更好地理解和解决复杂业务领域中的问题。它强调将业务需求和软件设计紧密结合，以更好地反映现实世界的业务逻辑和流程。

DDD 的核心思想包括：

1. **领域模型**：在 DDD 中，关注点集中在对业务领域的建模上。通过与领域专家密切合作，开发团队尝试将业务逻辑、概念和流程映射到软件中，形成一个清晰而强大的领域模型。

2. **通用语言**：DDD 强调在开发团队和领域专家之间建立共同的通用语言。这有助于消除沟通障碍，确保所有人都理解并使用相同的术语和概念。

3. **限界上下文**：DDD 将复杂的业务领域分解为多个限界上下文（Bounded Contexts），每个上下文都有其自己的领域模型和语言。这有助于减少复杂性，使团队能够更好地处理复杂的业务逻辑。

4. **领域驱动设计模式**：DDD 提供了一系列设计模式和实践，用于解决常见的领域建模和设计问题。这些模式包括实体（Entity）、值对象（Value Object）、聚合（Aggregate）、仓储（Repository）等。

5. **持续演化**：DDD 鼓励软件系统的持续演化和迭代开发。随着对业务领域的理解不断深入和变化，领域模型也应该随之演化和改进。

总的来说，领域设计是一种帮助开发团队更好地理解和解决复杂业务领域中问题的方法论，它强调建立通用语言、领域模型和限界上下文，以及持续演化和迭代开发的思想。



# DDD 中的一些概念

## DP

### DP 的定义
Domain Primitive，是一个在特定领域里，拥有精准定义的、可自我验证的、拥有行为的 Value Object。

- DP 是一个传统意义上的Value Object，拥有 Immutable 的特性。
- DP 是一个完整的概念整体，拥有精准定义。
- DP 使用业务域中的原生语言。
- DP 可以是业务域的最小组成部分、也可以构建复杂组合。

### DP 的优点
1. 接口的清晰度更高。  
2. 数据验证和错误处理更合理简洁。  
3. 业务代码的清晰度更高。  
4. 测试复杂度更低，可测试性更高。
5. 将隐含的概念显性化。
6. 整体安全性大大提高。 
7. Immutability 不可变。
8. 线程安全。

### 使用 Domain Primitive 的三原则  
- 让隐性的概念显性化
- 让隐性的上下文显性化
- 封装多对象行为

### Domain Primitive 和 DDD 里 Value Object 的区别
Domain Primitive 是 Value Object 的进阶版，在原始 VO 的基础上要求每个 DP 拥有概念的整体，而不仅仅是值对象。在 VO 的 Immutable 基础上增加了 Validity 和行为。  

### Domain Primitive 和 Data Transfer Object 的区别
|  |  DTO  |  DP  |  
|--- | --- | --- |
| 功能 | 数据传输 属于技术细节 | 代表也业务域中的概念 |
| 数据的关联 | 只是一堆数据放在一起 不一定有关联度 | 数据之间的高相关性 |
| 行为 | 无行为 | 丰富的行为和业务逻辑 | 

### 什么情况下应该用 Domain Primitive
常见的 DP 使用场景包括：  
- 有格式限制的 `String`：比如 `Name`、`PhoneNumber`、`OrderNumber`、`ZipCode`、`Address`等。
- 有限制的 `Integer`：比如 `OrderId`（>0），`Percentage`（0-100%），`Quantity`（>=0）等。
- 可枚举的 `int` ：比如 `Status`（一般不用 `Enum` 因为反序列化问题）。
- `Double` 或 `BigDecimal`：一般用到的 `Double` 或 `BigDecimal` 都是有业务含义的，比如 `Temperature`、`Money`、`Amount`、`ExchangeRate`、`Rating` 等。
- 复杂的数据结构：比如 `Map<String`, `List<Integer>>` 等，尽量能把 `Map` 的所有操作包装掉，仅暴露必要行为。



## Entity、BO、VO、PO、DTO、POJO

### VO
Value Object：值对象。  
通常用于业务层之间的数据传递，由 new 创建，由 GC 回收。   
Restfule 使用 VO，针对 View 显示，在 Web 上传递。用一个 VO 对象对应整个界面的值。  

### PO
Persistant Object：持久层对象。最形象的理解就是一个 PO 就是数据库中的一条记录。   
对应数据库中表的字段，与数据库打交道。  
PO 中应该不包含任何对数据库的操作。  
VO 和 PO，都是属性加上属性的 get 和 set 方法，虽然看起来没什么不同，但是代表的含义不一样。   

### Entity
实体，和 PO 的功能类似，和数据表一一对应，一个实体一张表。   

### DTO
Data Transfer Object：数据传输对象。用于数据对象的一个转化，比如展示层与服务层之间的数据传输对象。    
例如，在一张表里面有多个字段，而页面只需要展示其中某几个字段，这时就用到了 DTO。一来它可以提高数据传输的速度（减少了传输字段），二来通过 DTO 的转化，就隐藏了后端表的结构，更加安全。   

### DAO
Data Access Object：数据访问对象。  
主要用来封装对数据的访问，注意，是对数据的访问，不是对数据库的访问。   
此对象用于访问数据库。通常和 PO 结合使用，DAO 中包含了各种数据库的操作方法。通过它的方法，结合 PO  对数据库进行相关的操作。夹在业务逻辑与数据库资源中间。配合 VO，提供数据库的 CRUD 操作。  

### BO 
Business Object：业务对象。   
BO 把业务逻辑封装为一个对象。可以理解为多个 PO 的结合。  

### POJO 
Plain Ordinary Java Object：简单无规则 Java 对象。  
纯的传统意义的 Java 对象，最基本的 Java Bean 只有属性加上属性的 get 和 set 方法。   
可以转化为 PO、DTO、VO，比如 POJO 在传输过程中就是 DTO。   

### DO 
Domain Object：领域对象，就是从现实世界中抽象出来的有形或无形的业务实体。  
DO 具有一些不应该让展示层知道的数据；比如对于一个 getUser 方法来说，本质上它永远不应该返回用户的密码，因此 UserInfo 至少比 User 少一个 Password 的数据。  