---
id: TASK-155.3
title: '실제 GitHub Actions에서 수동 트리거 후 이슈 #7 close 확인 (e2e 증거)'
status: To Do
assignee: []
created_date: '2026-09-06 01:33'
labels: []
dependencies:
  - TASK-155.2
parent_task_id: TASK-155
type: task
ordinal: 231000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
gh workflow run sonarcloud-issues-to-github.yml --repo amosQP/langtoolchain으로 수동 트리거 후 gh run watch <run-id> --exit-status로 완료 확인. 최종 증거: gh issue view 7 --repo amosQP/langtoolchain로 상태가 OPEN -> CLOSED로 바뀌었는지, 코멘트가 달렸는지 확인. 이게 통과해야 이 마일스톤(m-19) 전체를 Done으로 옮길 수 있다 — 로컬 셸 로직 테스트만으로는 실제 gh CLI 권한/워크플로 permissions(issues: write) 조합까지 검증되지 않음.
<!-- SECTION:DESCRIPTION:END -->
