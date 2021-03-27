# :hospital: 뇌졸증 환자 예측

<center><img src="https://user-images.githubusercontent.com/55734436/112008591-f6e51500-8b68-11eb-9a6e-1023414cae56.png" width="600" height="400"></center>


### :question: 분석 필요 이유
세계 보건기구 (WHO)에 따르면 뇌졸중은 전 세계적으로 두 번째 주요 사망 원인으로 전체 사망의 약 11 %를 차지한다고 합니다.  

### :exclamation: 분석 목표
해당 데이터셋은 성별, 나이, 흡연 등 다양한 변수들이 존재합니다. 이 변수를 바탕으로 뇌졸증에 걸릴 가능성을 예측하는것이 프로젝트의 목표입니다.
http://www.drunion.co.kr/official.php/home/info/2028

### :paperclip: 데이터 링크
https://www.kaggle.com/fedesoriano/stroke-prediction-dataset

### 데이터 설명
|**변수**|**설명**|
|:---:|---:|
|id|고유 식별자|
|gender|성별|
|age|나이|
|hypertension|고혈압 여부|
|heart_disease|심장병 여부|
|ever_married|결혼 여부|
|work_type|일 타입|
|Residence_type|거주지 타입|
|avg_glucose_level|평균 포도당 수준|
|bmi|체질량 지수|
|smoking_status|흡연 여부|
|stroke|뇌졸증 여부|


### 분석

### 데이터 전처리
<img src="https://user-images.githubusercontent.com/55734436/112086914-68a47980-8bd0-11eb-888c-e8b89490ab2d.png" width="400" height="400">

알려지지 않은 값들이 Unknown 으로 존재 이 값을 결측치로 인식하도록 결측치로 처리가 필요하다.

<img src="https://user-images.githubusercontent.com/55734436/112087738-dbfabb00-8bd1-11eb-88a8-44b16a80b3ac.png" width="400" height="400">

결측치들을 이제 제대로 인식함. 이제 이 결측치들을 어떻게 처리할지 생각을 해봐야 한다.
이 분석은 해당 커널들을 참고하여 진행하였습니다.

https://www.kaggle.com/reminho/stroke-prediction-xgb-acc-0-98-f1-0-84
