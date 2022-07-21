# Refactoring Kubeboard 

## 리팩토링 하려는 것

1. Helm Chart (진행중)
```
[as-is]
tpl 문법을 사용하지 않고, 모든 값을 values.yaml에서 직접 가져오는 방식으로 사용

[to-be]
tpl 문법 적용
확장성 및 관리의 편의성을 위한 멀티 헬름차트, 라이브러리 차트 도입
```

2. Terraform (진행중)
```
[as-is]
쿠버네티스 생성은 cloudfomation을 이용하였고, 나머지는 직접 콘솔로 생성

[to-be]
쿠버네티스 및 다른 리소스도 테라폼으로 생성
테라폼 모듈레포를 생성해서, 불러오는 방식 고려중 
```

3. Github Actions (진행중)
```
[as-is]
기존에는 브랜치 전략없이, 바로 배포되도록 함 

[to-be]
브랜치 전략을 적용하고, dev,prod 환경 별로 구분
environment secret을 사용하고, aws 액세스의 경우 assume role 도입 / IAM Trust relationship 적용 
깃헙액션 모듈레포 생성해서, 모듈 만들고 불러오는 방식 적용 예정 
```

4. kubeboard 확장에 대한 고민
```
[as-is]
기존에는 external dns 도입 안되어 있었음 .
현재 워커노드에 할당되는 파드들은 EFS를 PV,PVC로 사용함 
WAF만 사용
네이밍 컨벤션 적용 안되어있음 

[to-be]
external dns 에 대해 고민 (도입의 필요성 있을 지)
EFS를 사용할 지 RDS 로 바꿀 지 
  1) python 코드 개선 필요 
  2) 테라폼으로 생성 
  3) private vpc내에 있는 파드가 RDS에 액세스할 수 있도록 
  4) 파드 내에 RDS에 액세스할 수 있는 크레덴셜 키 hashicorp vault를 적용하기(?)
CF + WAF 로 적용할 지 
네이밍 컨벤션 적용

```
