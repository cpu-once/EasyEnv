---
id: TASK-155.1
title: 'close-step 핵심 로직: key 추출 -> SonarCloud 재조회 -> 조건부 close'
status: To Do
assignee: []
created_date: '2026-09-06 01:33'
labels: []
dependencies: []
parent_task_id: TASK-155
type: task
ordinal: 229000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
gh issue list --repo "${{ github.repository }}" --label sonarcloud --state open으로 열린 이슈를 순회. 각 이슈 본문에서 기존 발행 로직이 심어둔 '**SonarCloud 이슈 key**: `<key>`' 패턴을 grep/sed로 추출(예: grep -oE '이슈 key\*\*: `[^`]+`' | 뒤에서 백틱 안쪽만 뽑기). key 추출이 안 되면(사람이 본문을 고쳤거나 패턴이 없는 경우) 그 이슈는 조용히 skip — decision-18이 명시한 '추측으로 닫지 않는다' 제약. 추출된 key로 https://sonarcloud.io/api/issues/search?organization=amosqp&componentKeys=amosQP_langtoolchain&issues=<key> 조회(공개 API, 이 프로젝트는 public repo라 SONAR_TOKEN 없이도 됨 — 기존 fetch step과 동일 패턴). 응답의 status가 CLOSED거나 resolution이 FIXED/WONTFIX/FALSE-POSITIVE 등 해소된 상태면 대상으로 표시.
<!-- SECTION:DESCRIPTION:END -->
