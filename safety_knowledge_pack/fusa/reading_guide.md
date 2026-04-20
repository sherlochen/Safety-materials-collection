# 功能安全（FuSa）资料整理

## 1) 核心标准

- ISO 26262（2018, 全12部分）
  - 官方入口：https://www.iso.org/publication/PUB200262.html
  - 适用：量产道路车辆（不含轻便摩托车）E/E 系统功能安全全生命周期。
- GB/T 34590（2022, 全12部分）
  - 标准入口：https://std.samr.gov.cn/
  - 说明：对 ISO 26262:2018 的本土化采用与调整。

## 2) 建议重点学习章节

- Part 2：功能安全管理（组织流程、角色职责、独立性）
- Part 3：概念阶段（HARA、ASIL 分配、安全目标）
- Part 4/5/6：系统、硬件、软件开发 V 模型
- Part 8：支持过程（配置管理、变更管理、工具置信度）
- Part 9：ASIL 分解与安全分析（FTA、FMEDA、DFA 等）

## 3) 典型工件清单

- Item Definition
- HARA 与 Safety Goals
- Functional Safety Concept / Technical Safety Concept
- System/Hardware/Software Safety Requirements
- Safety Case（含验证、确认与发布证据）

## 4) 与智能驾驶结合要点

- 车辆级安全目标需覆盖横向、纵向与最小风险策略（MRM）。
- 对感知/规划链路中的“故障导致风险”归入 FuSa 闭环管理。
- 与 SOTIF 联动：先区分“故障引发”还是“功能充分性不足引发”。
