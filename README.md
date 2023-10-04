# 주제: 지역별 생활폐기물 현황 분석

## 사용한 기술
- 언어: Python
- RDB: mysql(AWS RDS)
- 분석: matplotlib, pandas, seaborn, numpy, scipy

## 발표자료
https://docs.google.com/presentation/d/1hABXeKkpYN_hCG8XYs-6Jznr-U8220AZZT0lpReLpHU/edit?usp=sharing

### 실행하기 전에
- 라이브러리 설치
```
pip install -r requirements.txt
```
- db property 파일 설정: DB 접속은 config.ini 파일로 설정했습니다. git에 연동하지 않은 파일이므로, 다음과 같은 형태로 생성이 필요합니다.
```
[dev]
host = 
port = 
user = 
password = 
database = 
```
- 파일명이나 경로, 형식을 수정하고 싶다면 코드의 이 부분을 참고해 주세요. (ipynb 파일의 최상단, import 아랫부분에 있습니다.)
```
config = configparser.ConfigParser()
config.read('../config.ini')
dev = config['dev']
```
- 테이블 생성과 데이터 입력 작업시간을 줄이고 싶다면 mysqldump한 yun_project.sql 파일을 사용해 주세요.
- 덮어쓸 새 데이터베이스에 접속 후
```
source yun_project.sql
```

### 특이사항
- seaborn, matplotlib 스타일 설정 시 한글 폰트가 자주 깨지는 이슈가 있었습니다.
- 라이브러리 간 버전 충돌이 예상되나, 이슈를 아직 해결하지 못했습니다. (코드 수정 시 에러 발생)
- (ubuntu 20.04 기준) 다음과 같이 matplotlib의 캐시를 삭제 후 라이브러리를 다시 import하면 한글이 정상 출력됩니다.
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