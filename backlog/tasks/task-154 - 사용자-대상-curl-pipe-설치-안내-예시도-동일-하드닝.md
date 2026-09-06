---
id: TASK-154
title: 사용자 대상 curl-pipe 설치 안내 예시도 동일 하드닝
status: To Do
assignee: []
created_date: '2026-09-06 01:01'
labels: []
milestone: m-18
dependencies: []
type: task
ordinal: 227000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
readme.md의 curl -fsSL https://raw.githubusercontent.com/amosQP/langtoolchain/main/install.sh | sh 예시(21, 58행)와 uninstall 예시(163행), install.sh 헤더 주석(4, 11행)의 curl -fsSL 예시, uninstall.sh 헤더 주석(4행)의 curl -fsSL 예시에 동일하게 --proto '=https' --proto-redir '=https' --tlsv1.2 플래그를 추가한다. 이 curl 호출들은 사용자가 터미널에 직접 복붙하는 텍스트라 SonarCloud가 스캔하는 실행 코드가 아니고, 실제로 이슈로 잡히지도 않았다 — 하지만 TASK-153과 동일한 -L(리다이렉트 추적) 패턴이고, 오히려 이쪽이 curl | sh로 바로 실행되는 진입점이라 무결성 검증 장치가 전혀 없어 보안적으로 더 민감하다. 사용자가 '3가지 모두 적용'으로 이 범위까지 명시적으로 승인함.
<!-- SECTION:DESCRIPTION:END -->
