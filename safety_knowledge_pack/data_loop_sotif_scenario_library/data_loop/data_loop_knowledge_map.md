# 智驾数据闭环资料图谱（Data Loop）

## 1) 什么是智驾数据闭环

数据闭环是“路测/量产运行 -> 事件发现 -> 数据回传 -> 标注与治理 -> 训练与验证 -> 发布 -> 运行监控 -> 再回流”的持续改进系统。

目标不是“采集更多数据”，而是“更快发现安全风险并用最小数据修复风险”。

## 2) 闭环核心环节（建议最小链路）

- 运行数据采集：触发条件、日志策略、隐私与合规
- 事件挖掘：误检/漏检、急刹、接管、险情、ODD 越界
- 场景聚类与优先级：严重度 * 暴露率 * 可修复性
- 数据生产：抽帧、重建、多传感器对齐、标注质检
- 模型迭代：训练、回归、对比评估、A/B
- 安全门禁：SOTIF 关键场景阈值、回归红线
- 灰度与发布：分层发布、回滚、在线监控

## 3) 与安全体系的关系

- 与 FuSa：闭环用于发现“故障触发风险”和“监控策略失效”。
- 与 SOTIF：闭环用于发现“功能充分性不足”与未知危险场景。
- 与 AI Safety：闭环用于处理数据漂移、OOD 和模型退化。

## 4) 建议监控指标（KPI/KRI）

- 事件发现效率：每千公里安全相关事件数、首次发现时间
- 数据生产效率：从事件到可训练样本的周期（TAT）
- 模型改进效果：关键场景成功率提升、回归失败率
- 发布风险：灰度失败率、回滚触发率、严重事件率
- 运营健康度：ODD 外运行比例、人工接管率

## 5) 公开资料（优先官方/权威入口）

- NIST AI RMF（治理与持续风险管理）
  - https://www.nist.gov/itl/AI-risk-management-framework
- ISO/PAS 8800（汽车 AI 安全框架）
  - https://www.iso.org/standard/83303.html
- UL 4600（Safety Case 证据组织）
  - https://ulse.org/UL4600
- NVIDIA 闭环训练综述与场景生成实践（技术博客/研究）
  - https://research.nvidia.com/publication/2025-12_beyond-behavior-cloning-autonomous-driving-survey-closed-loop-training
  - https://developer.nvidia.com/blog/generating-ai-based-accident-scenarios-for-autonomous-vehicles/

## 6) 工程落地建议

- 按“问题驱动”建闭环，不按“数据规模驱动”建闭环。
- 建立统一事件编码体系（场景、失效模式、责任链）。
- 所有模型上线必须绑定“回归集 + SOTIF 高风险场景集”。
- 闭环平台必须支持“证据可追溯”，可直接进入 Safety Case。
