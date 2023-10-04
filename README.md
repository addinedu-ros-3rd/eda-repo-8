# 지역별 생활폐기물 현황 분석
<br>

## 프로젝트 기간
- 2023.09.06 ~ 2023.09.12 (7일)
<br>

## 팀 구성
- 1인 프로젝트
<br>

## 분석 목적
### 1. 지역별 가구 특성과 생활 폐기물 발생 양상의 상관관계 여부 확인
### 2. 상관이 있다면 그 정도를 상관계수 및 그 신뢰성(p-value)로 확인
<br><br>

## 구성도
<p align="center">
  <img src="https://github.com/addinedu-amr-4th/eda-repo-8/assets/86283716/81162e0b-479b-482b-afc8-537be77bc4b5)"/>
</p>

## ER Diagram
![image](https://github.com/YunOh21/eda_project/assets/86283716/980fba7a-ce66-4711-abcb-2de25cbb5ecd)

## 데이터 전처리: pandas
![image](https://github.com/YunOh21/eda_project/assets/86283716/a64944a1-d44a-49a4-a233-d5f1c546a560)

## 시각화: seaborn
![image](https://github.com/YunOh21/eda_project/assets/86283716/7d39d52a-c42a-4fb7-97fa-5cf10ef6f291)

## 공분산, 상관계수, p-value 계산: numpy, scipy
![image](https://github.com/YunOh21/eda_project/assets/86283716/e3f1c1a7-c158-43ca-aee9-47f9af81ac91)

### 실행하려면
- 라이브러리 설치
```
pip install -r requirements.txt
```
- db property 파일 설정: DB 접속은 config.ini 파일로 설정했습니다. git에 연동하지 않았으므로, 다음과 같은 형태로 생성이 필요합니다.
```
[dev]
host = 
port = 
user = 
password = 
database = 
```
- 파일 생성 후, 2가지 방법 중 택1
  1. src/00_01.create_table.ipynb 실행
  2. yun_project.sql 파일(mysqldump) 사용
      - 덮어쓸 새 데이터베이스에 접속 후
      ```
      source yun_project.sql
      ```
- 파일명이나 경로, 형식을 수정하고 싶다면 코드의 이 부분을 참고해 주세요. (ipynb 파일의 최상단, import 아랫부분에 있습니다.)
```
config = configparser.ConfigParser()
config.read('../config.ini')
dev = config['dev']
```

### 발표자료
https://docs.google.com/presentation/d/1hABXeKkpYN_hCG8XYs-6Jznr-U8220AZZT0lpReLpHU/edit#slide=id.p

### 분석 도구
- 언어: Python
- RDB: mysql(AWS RDS)
- 라이브러리: matplotlib, pandas, seaborn, numpy, scipy
    - matplotlib, pandas, seaborn을 사용해 산점도와 회귀 직선을 그렸습니다.
    - numpy와 scipy를 사용해 상관계수와 p-value를 구했습니다.
- 자료
    - 2021년 전국 생활폐기물 통계
    - 2022년 인구총조사

### 특이사항
- seaborn, matplotlib 스타일 설정 시 한글 폰트가 자주 깨지는 이슈가 있었습니다. 라이브러리 간 버전 충돌로 보입니다.
- 코드 수정 시 다시 발생할 수 있으며, (ubuntu 20.04 기준) matplotlib의 캐시를 삭제 후 라이브러리를 다시 import하면 한글이 정상 출력됩니다.
```
rm -rf ~/.cache/matplotlib/*
```

### 통계자료 출처
- 통계청<br>
https://kosis.kr/statHtml/statHtml.do?orgId=101&tblId=DT_1PL1502&conn_path=I2

- 자원순환정보시스템(환경청 및 전국 지자체 자료 모음)<br>
https://www.recycling-info.or.kr/rrs/stat/envStatDetail.do?menuNo=M13020201&pageIndex=1&bbsId=BBSMSTR_000000000002&s_nttSj=KEC005&nttId=1296&searchBgnDe=&searchEndDe=

- 국가물류통합정보센터(국가교통DB센터 KTDB 자료)<br>
https://www.nlic.go.kr/nlic/frghtRoad0010.action#

### 참고자료
- 특허청 화학생명기술심사국 고분자섬유심사과 세미나 자료<br>
https://www.kipo.go.kr/club/file.do?attachmentId=14189

- 그린피스 보고서<br>
https://www.greenpeace.org/korea/update/25774/report-disposable-korea-ver2/

- 통합데이터지도(한국지능정보사회진흥원)<br>
https://www.bigdata-map.kr/datastory/env/household-waste
