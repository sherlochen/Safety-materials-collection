# 公开数据集与工具清单（数据闭环 + SOTIF 场景库）

## 1) 公开数据集（场景挖掘与回归集构建）

- nuScenes（多传感器 3D 场景）
  - http://www.nuscenes.com/
- Waymo Open Dataset（含 Motion/scenario 任务）
  - https://waymo.com/open/about/
- Argoverse 2（高密度交互场景）
  - https://www.argoverse.org/av2.html
- BDD100K（大规模多天气/昼夜视频）
  - https://doc.bdd100k.com/download.html
- ApolloScape（高分辨率场景理解）
  - https://github.com/ApolloScapeAuto/dataset-api
- comma2k19（轨迹与车道相关研究）
  - https://github.com/commaai/comma2k19

说明：公开数据集用于补充覆盖与算法基线，不能替代自有量产闭环数据。

## 2) 场景与仿真工具

- CARLA + ScenarioRunner（支持 OpenSCENARIO）
  - https://scenario-runner.readthedocs.io/
- CommonRoad（规划与场景基准）
  - https://www.ce.cit.tum.de/cps/software/commonroad/
- Scenic（概率式场景描述与生成）
  - http://arxiv.org/abs/1809.09310

## 3) 标准化交换与建模

- ASAM OpenSCENARIO
  - https://www.asam.net/standards/detail/openscenario
- ASAM OpenODD
  - https://www.asam.net/standards/detail/openodd/
- ASAM OpenLABEL
  - https://www.asam.net/standards/detail/openlabel/

## 4) 使用建议（避免常见误区）

- 先定“风险优先级”再扩数据，不要先追求数据规模。
- 公开数据集用于“预训练和泛化验证”，自有闭环数据用于“安全门禁”。
- 场景工具链尽量统一标准格式，降低跨平台迁移成本。
