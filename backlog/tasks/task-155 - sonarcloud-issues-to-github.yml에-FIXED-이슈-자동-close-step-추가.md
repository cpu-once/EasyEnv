---
id: TASK-155
title: sonarcloud-issues-to-github.yml에 FIXED 이슈 자동-close step 추가
status: In Progress
assignee: []
created_date: '2026-09-06 01:32'
updated_date: '2026-09-06 01:35'
labels: []
milestone: m-19
dependencies: []
references:
  - decision-18
  - .github/workflows/sonarcloud-issues-to-github.yml
type: task
ordinal: 228000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
decision-18 구현 스토리. 기존 '발행' step(label:sonarcloud로 이미 있음)은 그대로 두고, 그 다음에 'close 처리' step을 추가한다. 대상: 방금 확인된 GitHub Issue #7(S6506, SonarCloud에서는 이미 status=CLOSED/resolution=FIXED)이 실제 성공 기준 — 이 이슈가 자동으로 close되면 구현이 맞다는 증거다.
<!-- SECTION:DESCRIPTION:END -->
