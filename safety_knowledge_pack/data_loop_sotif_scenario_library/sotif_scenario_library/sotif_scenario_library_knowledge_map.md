# SOTIF 场景库资料图谱（Scenario Library）

## 1) 场景库在 SOTIF 中的作用

SOTIF 核心是减少“无故障但功能不足”带来的不合理风险。场景库是识别、验证、回归这些风险的基础资产。

## 2) 场景分层方法（推荐）

- 功能场景（Functional Scenario）：自然语言描述
- 逻辑场景（Logical Scenario）：参数化变量与范围
- 具体场景（Concrete Scenario）：可执行测试用例

该分层用于从“需求”走到“可验证”。

## 3) 关键标准与方法资料

- ISO 21448:2022（SOTIF）
  - https://www.iso.org/standard/77490.html
- ISO 34502:2022（场景化安全评估框架）
  - https://www.iso.org/standard/78951.html
- ISO 34503:2023（ODD 规范）
  - https://www.iso.org/standard/78952.html
- UNECE VMAD（多支柱验证：仿真/封闭场地/实车/审计）
  - https://wiki.unece.org/spaces/trans/pages/60361611/Validation+Method+for+Automated+Driving+VMAD
- PEGASUS 项目（场景化验证方法）
  - https://www.dlr.de/en/ts/research-transfer/projects/pegasus

## 4) 场景库建设关键能力

- ODD 建模：场景必须绑定 ODD 边界
- 危险触发建模：触发条件、可观测征兆、失败结果
- 覆盖率体系：按道路类型、天气、交通参与者、交互复杂度
- 稀有场景挖掘：事故数据、接管数据、异常轨迹、对抗生成
- 跨平台执行：仿真平台、测试场地、实车回放一致性

## 5) 场景标准与互操作资料

- ASAM OpenSCENARIO（场景描述）
  - https://www.asam.net/standards/detail/openscenario
- ASAM OpenODD（ODD 标准化描述）
  - https://www.asam.net/standards/detail/openodd/
- ASAM OpenLABEL（场景标签与多传感器标注）
  - https://www.asam.net/standards/detail/openlabel/

## 6) 与数据闭环联动机制

- 量产事件 -> 自动抽取候选场景 -> 入库分级
- 新场景先进入“风险评估池”，通过后进入“回归基线池”
- 每次版本发布必须通过“高风险 SOTIF 场景池”门禁
- 发布后新增失效场景需在固定周期回流并更新场景池

## 7) 当前常见缺口（实践中高发）

- 场景库只做“数量增长”，缺少“风险权重”
- 场景文本定义与可执行脚本脱节
- 没有“未知场景发现效率”指标
- 场景变更缺乏版本化与可追溯治理
