<img src = "" width="750">  <br>

#  씨밋 - SeeMeet
> **약속부터 만남까지, 더 가까운 우리 사이 SeeMeet** <br>
>
> SOPT 29th APP JAM <br>
> 프로젝트 기간 : 2021.1.3 ~ 

<br>

<br>

##  SeeMeet iOS Contributors
 <img src="https://user-images.githubusercontent.com/46644241/124632766-97b0d380-debf-11eb-9ec7-734b282cbc5d.png" width="500"> | ![KakaoTalk_Photo_2022-01-12-23-24-01](https://user-images.githubusercontent.com/51031771/149158747-9d7343b9-932b-40c7-87fd-996a8db21ae3.jpeg) | ![KakaoTalk_Photo_2022-01-12-23-25-07](https://user-images.githubusercontent.com/51031771/149158516-134a88b5-d165-48f9-a231-d712ee093eab.jpeg) | 
 :---------:|:----------:|:---------:
 🍎 박익범 | 🍎 김인환 | 🍎 이유진 
 [swikkft](https://github.com/parkikbum) | [loinsir](https://github.com/loinsir) | [yujinnee](https://github.com/yujinnee)

<br>
<br>

## Development Environment and Using Library
- Development Environment
<p align="left">
<img src ="https://img.shields.io/badge/Swift-5.0-ff69b4">
<img src ="https://img.shields.io/badge/Xcode-13.2.1-yellow">
<img src ="https://img.shields.io/badge/iOS-15.2-orange">
<a href="https://www.instagram.com/seemeet_teeam_/">
      <img alt="Instagram: SeeMeet_Official" src="https://img.shields.io/badge/SeeMeetInstagram-9986ee" target="_blank" />
  </a>
  </p>

- Library

라이브러리 | 사용 목적 | Version
:---------:|:----------:|:---------:
 Alamofire | 서버 통신 | 5.4
 SnapKit | UI Layout | 5.0.0
 Then | code Support | -
 Kingfisher | 이미지 처리 | 6.0
 FSCalendar | 캘린더 | -

- framework

프레임워크 | 사용 목적 
:---------:|:----------:
 UIKit | &nbsp;

<br>
<br>

## Our Convention
<details>
 <summary> ⚡ Git Branch Convention </summary>
 <div markdown="1">       

 ---
 
 - **Branch Naming Rule**
    - Issue 작성 후 생성되는 번호와 Issue의 간략한 설명 등을 조합하여 Branch 이름 결정
    - `<Prefix>/<Issue_Number>-<Description>`
- **Commit Message Rule**
    - `[Prefix] : - <Description>`
- **Code Review Rule**
    - 리뷰를 합리적, 중립적으로 받아들이기 (무조껀 좋아 무조껀 싫어는 곤란합니다^^)
    - 반영이 어렵다면, 왜 어려운지 합리적인 이유를 대야 함
    - 모든 리뷰는 합리적 판단에 의거하여 한번 더 생각할 수 있는 기회가 될 수 있도록 함
   
 <br>

 </div>
 </details>

 <details>
 <summary> ⚡ Git Flow </summary>
 <div markdown="1">       

 ---
 
 ```
1. Issue 생성 : 담당자, 라벨(우선순위,담당자라벨), 프로젝트 연결 

2. 로컬에서 develop 최신화 : git pull (origin develop) 

3. feature Branch 생성⭐️ : git switch -c Prefix/IssueNumber-description 

4. Add - Commit - Push - Pull Request 의 과정을 거친다.
   ⚠️ commit template 사용하여 이슈번호쓰기 ex. [CHORE] : #12 - UIstyle 적용
   
5. Pull Request 작성 
 closed: #IssueNumber로 이슈 연결, 프로젝트 연결, 리뷰어 지정

5. Code Review 완료 → Pull Request 작성자가 develop Branch로 merge

6. 종료된 Issue와 Pull Request의 Label과 Project를 관리
```
   
 <br>

 </div>
 </details>

<details>
 <summary> ⚡ Naming Convention </summary>
 <div markdown="1">       

 ---
 
- 함수 : **lowerCamelCase** 사용하고 동사로 시작
- 변수, 상수 : **lowerCamelCase** 사용
- 클래스 : **UpperCamelCase** 사용
- 파일명 (약어사용)
    - ViewController → `VC`
    - TableViewCell → `TVC`
    - CollectionViewCell → `CVC`
 <br>

 </div>
 </details>

<details>
 <summary> ⚡ Foldering Convention </summary>
 <div markdown="1">       

 ---
<img src="https://user-images.githubusercontent.com/73978827/149062207-b483a532-6cea-4ddf-9270-dd1c89090022.png" width="500">

   
 <br>

 </div>
 </details>

## 구현한 부분

대분류 | 기능 | 구현 여부 | 담당자
:---------:|---------|:----------:|:---------:
 Auth | 스플래시 |O| -
 &nbsp; | 회원가입 |O| 박익범
  &nbsp; | 로그인 |O| 박익범
  메인뷰 | 메인뷰 컨텐츠 |O| 박익범
  &nbsp; | 마이페이지 |O| 박익범
  친구 | 친구목록 |O| 김인환
   &nbsp; | 친구관리 |O| 김인환
  캘린더| 캘린더뷰 |O| 김인환
 &nbsp; | 캘린더상세 데이터 |O| 김인환
  약속신청| 보낼친구검색 |O| 이유진
  &nbsp; | 약속내용설정 |O| 이유진
  &nbsp; | 약속기한설정 |O| 이유진
  약속리스트| 약속리스트 |O| 박익범
  &nbsp; | 받은약속/응답 |O| 박익범
  &nbsp; | 보낸약속/응답 |O| 박익범
   
<br>
<br>

<br>


---
