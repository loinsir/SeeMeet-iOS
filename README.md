<img src = "" width="750">  <br>

#  씨밋 - SeeMeet
> **약속부터 만남까지, 더 가까운 우리 사이 SeeMeet** <br>
>
> SOPT 29th APP JAM <br>
> 프로젝트 기간 : 2021.1.3 ~ 

<br>

<br>

##  SeeMeet iOS Contributors
 <img src="https://user-images.githubusercontent.com/46644241/124632766-97b0d380-debf-11eb-9ec7-734b282cbc5d.png" width="500"> | <img src="https://user-images.githubusercontent.com/73978827/149061946-7c63b407-19f7-439a-a1fe-03a7fd883a88.jpeg" width="500"> | <img src="https://user-images.githubusercontent.com/73978827/149061994-d141a321-93be-409e-b14b-5cd7237a399f.jpeg" width="500"> | 
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

### 

<br>
<br>

<br>


---
