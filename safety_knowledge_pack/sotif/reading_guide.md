# 预期功能安全（SOTIF）资料整理

## 1) 核心标准

- ISO 21448:2022 Road vehicles - Safety of the intended functionality
  - 官方入口：https://www.iso.org/standard/77490.html
  - 适用：尤其面向依赖感知与理解能力的 ADAS/AD 场景。
- ISO/PAS 21448:2019（历史版本）
  - 官方入口：https://www.iso.org/standard/70939.html

## 2) SOTIF 的核心问题

- 功能无故障，但在某些场景下“能力不足”导致风险。
- 典型来源：
  - 传感器性能边界（雨雪雾、逆光、污染、遮挡）
  - 场景覆盖不足（corner case）
  - 算法泛化不足与不确定性估计不足

## 3) 工程实践方法

- 场景驱动：构建 ODD 与场景库，覆盖已知安全关键场景。
- 未知发现：仿真 + 实车 + 回归数据闭环发现 unknown unsafe scenarios。
- 验证策略：将“已知安全场景充分性”和“未知风险发现效率”并行考核。

## 4) 与 FuSa 分工

- FuSa：处理随机硬件故障与系统性失效引发的风险。
- SOTIF：处理预期功能定义或性能不足引发的风险。
- 联合安全论证：最终在同一个车辆级 Safety Case 收敛。
