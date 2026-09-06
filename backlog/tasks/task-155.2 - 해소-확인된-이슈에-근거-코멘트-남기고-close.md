---
id: TASK-155.2
title: 해소 확인된 이슈에 근거 코멘트 남기고 close
status: To Do
assignee: []
created_date: '2026-09-06 01:33'
labels: []
dependencies:
  - TASK-155.1
parent_task_id: TASK-155
type: task
ordinal: 230000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
TASK-155.1에서 CLOSED/resolved로 확인된 각 GitHub Issue에 대해 gh issue comment로 해소 근거(SonarCloud status/resolution, 재조회 시각)를 남긴 뒤 gh issue close 실행. 커밋 메시지/코멘트 문구는 기존 발행 로직의 톤(한국어, '~파이프라인으로 자동 발행' 식 안내문)과 맞춘다. shellcheck -s sh로 새로 추가되는 인라인 셸 블록 검사(기존 발행 step과 동일한 set -eu 하에서 동작해야 함 — 한 이슈 처리 실패가 나머지 이슈 처리를 중단시키지 않도록 개별 이슈 루프 안에서의 실패는 continue 처리).
<!-- SECTION:DESCRIPTION:END -->
