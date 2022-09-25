# Data Science Docker Korean (한글 버전)

## 개요

TensorFlow 2.9.1 의 [tensorflow/tensorflow:2.9.1-gpu-jupyter](https://hub.docker.com/layers/tensorflow/tensorflow/2.9.1-gpu-jupyter/images/sha256-6345c1f2eaaf7b8efc9b8ec7f62869e6490db80e07ae5b856d5c16b48146daae?context=explore)의 도커를 베이스로 확장하여 GPU 전용 Docker파일(gpu.Dockerfile)을 구성하였습니다. 

TensorFlow에서 유지보수하고 있는 `2.9.1-gpu-jupyter` 도커의 경우 한글 형태소 분석기나 한글폰트, 그 밖에 PyTorch를 비롯한 여러 머신러닝/딥러닝 라이브러리가 제외되어 있기 때문에 필요한 라이브러리를 추가 설치하고 의존성에 문제가 없는지 확인한 후 배포하는 작업을 진행하고 있습니다.

본 Repository를 만들게 된 계기는 안정적으로 업데이트 되고 있는 `tensorflow/tensorflow-gpu-jupyter`에 기반하여 한글 폰트, 한글 자연어처리 패키지(konlpy), 형태소 분석기(mecab), Timezone 등의 설정을 추가하여 별도의 한글 관련 패키지와 설정을 해줘야 하는 번거로움을 줄이기 위함입니다.

- **GPU** 버전 도커 **Hub** 주소: [teddylee777/docker-kaggle-ko](https://hub.docker.com/repository/docker/teddylee777/docker-kaggle-ko)
- **CPU** 버전 도커 **Hub** 주소: [teddylee777/docker-kaggle-ko-cpu](https://hub.docker.com/repository/docker/teddylee777/docker-kaggle-ko-cpu)
- **GitHub** 주소: [github.com/teddylee777/datascience-docker-ko](https://github.com/teddylee777/datascience-docker-ko)

**추가 패키지 요청은 issue 를 통해 요청해 주세요! 검토 후 반영 혹은 미반영시 사유를 남기도록 하겠습니다.**



## 테스트된 도커 환경

- OS: Ubuntu18.04
- GPU: RTX3090 x 2way
- CUDA: 11.2
- Python (anaconda): 3.7.10



## 추가 설치된 항목과 Python 패키지

- apt 패키지 인스톨러 **카카오 mirror 서버** 추가
- 나눔폰트, D2Coding 폰트 설치
- matplotlib 에 나눔폰트, D2Coding 폰트 추가
- mecab 형태소 분석기 설치 및 파이썬 패키지 설치
- [konlpy](https://konlpy-ko.readthedocs.io/ko/v0.4.3/): 한국어 정보처리를 위한 파이썬 패키지
- [py-hanspell](https://github.com/ssut/py-hanspell): 네이버 맞춤법 검사기를 이용한 파이썬용 한글 맞춤법 검사 라이브러리
- [soynlp](https://github.com/lovit/soynlp): 한국어 자연어처리를 위한 파이썬 라이브러리
- [soyspacing](https://github.com/lovit/soyspacing): 띄어쓰기 오류 교정 라이브러리
- [KR-WordRank](https://github.com/lovit/KR-WordRank)비지도학습 방법으로 한국어 텍스트에서 단어/키워드를 자동으로 추출하는 라이브러리
- `jupyter_notebook_config.py` : Jupyter Notebook 설정 파일 추가



## 설치된 주요 라이브러리

```
catboost                     1.0.6
fastai                       2.7.7
fbprophet                    0.7.1
gensim                       4.2.0
huggingface-hub              0.8.1
hyperopt                     0.2.7
jupyter                      1.0.0
keras                        2.9.0
Keras-Preprocessing          1.1.2
konlpy                       0.6.0
lightgbm                     3.3.2
MarkupSafe                   2.1.1
matplotlib                   3.5.2
mecab-python                 0.996-ko-0.9.2
mlxtend                      0.20.0
notebook                     6.4.12
numpy                        1.21.6
opencv-python                4.6.0.66
optuna                       2.10.1
pandas                       1.3.5
pip                          22.1.2
plotly                       5.9.0
PyMySQL                      1.0.2
scikit-learn                 1.0.2
scipy                        1.7.3
seaborn                      0.11.2
spacy                        3.4.0
SQLAlchemy                   1.4.39
tensorboard                  2.9.1
tensorflow                   2.9.1
tensorflow-datasets          4.6.0
torch                        1.10.1+cu111
torchaudio                   0.10.1+rocm4.1
torchvision                  0.11.2+cu111
transformers                 4.20.1
wandb                        0.12.21
xgboost                      2.0.0.dev0
```



## 실행 방법

### STEP 1: Docker가 사전에 설치되어 있어야 합니다.

도커의 설치 및 사용법에 대하여 궁금하신 분들은 [Docker를 활용하여 딥러닝/머신러닝 환경 구성하기](https://teddylee777.github.io/linux/docker%EB%A5%BC-%ED%99%9C%EC%9A%A9%ED%95%98%EC%97%AC-%EB%94%A5%EB%9F%AC%EB%8B%9D-%ED%99%98%EA%B2%BD%EA%B5%AC%EC%84%B1.md) 글을 참고해 주세요.

```bash
# step 1: apt-get 업데이트
sudo apt-get update

# step 2: 이전 버젼 제거
sudo apt-get remove docker docker-engine docker.io

# step 3: 도커(Docker) 설치 
sudo apt install docker.io

# step 4: 도커 서비스 시작
sudo systemctl start docker
sudo systemctl enable docker

# step 5: 잘 설치 되어있는지 버젼 체크
docker --version
```



### STEP 2: 도커 이미지 pull 하여 서버 실행

- `--rm`: 도커가 종료될 때 컨테이너 삭제
- `-it`: 인터랙티브 TTY 모드 (디폴트로 설정)
- `-d`: 도커를 백그라운드로 실행
- `-p`: 포트 설정. **local 포트:도커 포트**
- `-v`: local 볼륨 마운트. **local 볼륨:도커 볼륨**
- `--name`: 도커의 별칭(name) 설정



**DockerHub에서 이미지 다운로드**

DockerHub에 미리 빌드된 이미지를 다운로드 받은 후 실행합니다. (스트레스가 없다는 것이 장점입니다. 다만, 다운로드 시간은 오래 걸립니다.)



> jupyter notebook 서버 실행, port는 8888번 포트 사용

```bash
docker run --runtime nvidia --rm -it -p 8888:8888 teddylee777/docker-kaggle-ko:latest
```



> jupyter notebook 서버 실행, 로컬 volume 마운트

```bash
docker run --runtime nvidia --rm -it -p 8888:8888 -v /data/jupyter_data:/home/jupyter teddylee777/docker-kaggle-ko:latest
```


> 도커를 background에서 실행

```bash
docker run --runtime nvidia --rm -itd -p 8888:8888 teddylee777/docker-kaggle-ko:latest
```



> bash shell 진입

```bash
docker run --runtime nvidia --rm -it -p 8888:8888 teddylee777/docker-kaggle-ko:latest /bin/bash
```


**[참고]**

`jupyter_notebook_config.py` 을 기본 값으로 사용하셔도 좋지만, 보안을 위해서 **비밀번호 설정**은 해주시는 것이 좋습니다.

**비밀번호 설정** 방법, **방화벽 설정** 방법은 [Docker를 활용하여 딥러닝/머신러닝 환경 구성하기](https://teddylee777.github.io/linux/docker%EB%A5%BC-%ED%99%9C%EC%9A%A9%ED%95%98%EC%97%AC-%EB%94%A5%EB%9F%AC%EB%8B%9D-%ED%99%98%EA%B2%BD%EA%B5%AC%EC%84%B1.md) 글의 STEP 5, 7을 참고해 주세요.



## .bashrc에 단축 커멘드 지정

`~/.bashrc`의 파일에 아래 커멘드를 추가하여 단축키로 Docker 실행

**GPU**

```bash
kjupyter{
    docker run --runtime nvidia --rm -itd -p 8888:8888 -v /data/jupyter_data:/home/jupyter --name dl-ko teddylee777/docker-kaggle-ko
}
```

>  터미널에 다음과 같이 입력하여 도커 실행

```bash
kjupyter
```



## 설치 완료 후 테스트

`test.ipynb` 파일을 실행하여 잘 설치가 되었는지 확인할 수 있습니다.



> NVIDIA

```bash
!nvidia-smi
```

> TensorFlow

```python
import tensorflow as tf

print(f'tf.__version__: {tf.__version__}')

gpus = tf.config.experimental.list_physical_devices('GPU')
print(gpus)
```

> PyTorch

```python
import torch

print(f'torch.__version__: {torch.__version__}')

print(f'GPU 사용여부: {torch.cuda.is_available()}')
gpu_count = torch.cuda.device_count()
print(f'GPU count: {gpu_count}')
if gpu_count > 0:
    print(f'GPU name: {torch.cuda.get_device_name(0)}')
```

> 한글 자연어처리 패키지

```python
from konlpy.tag import Okt, Kkma, Hannanum

sample_sentence = '아버지가방에들어가신다.'

okt = Okt()
print(f'okt: {okt.pos(sample_sentence)}')

kkma = Kkma()
print(f'kkma: {okt.pos(sample_sentence)}')

hannanum = Hannanum()
print(f'hannanum: {hannanum.pos(sample_sentence)}')
```

> Mecab 설치 확인

```python
from konlpy.tag import Mecab

sample_sentence = '아버지가방에들어가신다.'

mecab = Mecab()
print(f'mecab: {mecab.pos(sample_sentence)}')
```

> 머신러닝 패키지

```python
import sklearn
import lightgbm
import xgboost

print(f'lightgbm: {lightgbm.__version__}\nxgboost: {xgboost.__version__}\nsklearn: {sklearn.__version__}')
```

> XGBoost (CPU & GPU 속도 비교)

```python
import time
from sklearn.datasets import make_regression
from xgboost import XGBRegressor

def model_test(model_name, model):
    x, y = make_regression(n_samples=100000, n_features=100)
    
    start_time = time.time()
    model.fit(x, y)
    end_time = time.time()
    return f'{model_name}: 소요시간: {(end_time - start_time)} 초'

xgb = XGBRegressor(n_estimators=1000, 
                   learning_rate=0.01, 
                   subsample=0.8, 
                   colsample_bytree=0.8,
                   objective='reg:squarederror', 
                  )

print(model_test('xgb (cpu)', xgb))

xgb = XGBRegressor(n_estimators=1000, 
                   learning_rate=0.01, 
                   subsample=0.8, 
                   colsample_bytree=0.8,
                   objective='reg:squarederror', 
                   tree_method='gpu_hist')

print(model_test('xgb (gpu)', xgb))
```

```
xgb (cpu): 소요시간: 35.86732840538025 초
xgb (gpu): 소요시간: 6.682094573974609 초
```
