# AI 安全资料整理（面向智能驾驶）

## 1) 汽车 AI 安全核心标准

- ISO/PAS 8800:2024 Road vehicles - Safety and artificial intelligence
  - 官方入口：https://www.iso.org/standard/83303.html
  - 定位：在汽车安全生命周期中对 AI/ML 元素提出安全要求框架。
- UL 4600（Autonomous Products Safety Case）
  - 参考入口：https://ulse.org/UL4600
  - 定位：强调“可审计安全论证（Safety Case）”和证据充分性。
- IEEE 2846-2022
  - 官方入口：https://standards.ieee.org/ieee/2846/10831
  - 定位：定义 ADS 安全相关模型中的合理假设边界。

## 2) 通用 AI 风险框架（可作为补充）

- NIST AI RMF 1.0
  - 官方入口：https://www.nist.gov/itl/AI-risk-management-framework
  - 可用于治理、风险识别、度量和持续管理的组织流程建设。
- EU AI Act（Regulation (EU) 2024/1689）
  - 官方文本：https://eur-lex.europa.eu/legal-content/EN/TXT/?uri=CELEX:32024R1689
  - 对高风险 AI 系统提出合规要求，可用于出口和跨区域合规参考。

## 3) 智能驾驶 AI 安全落地清单

- 数据安全：采集分布、标注质量、长尾场景覆盖、数据漂移监控。
- 模型安全：鲁棒性、置信度校准、OOD 检测、对抗风险评估。
- 系统安全：感知-规划-控制链路监测、降级策略、MRM 与驾驶员接管策略。
- 运行安全：在线监控、事件复盘、闭环 OTA 安全验证。

## 4) 建议交付物

- AI Safety Plan（角色、流程、准入门槛）
- Model Card + Data Card（训练/验证边界与限制）
- AI Hazard Analysis（含场景与模型失效模式）
- AI Safety Case（主张-论据-证据结构）
