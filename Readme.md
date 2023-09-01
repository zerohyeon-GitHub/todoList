### Git Branch Rule

- main : 개발이 완료된 산출물이 저장될 공간
- develop : main 전에 검토를 하는 브랜치. 정상 동작 확인 후 main에 merge
- zero : 개인별 브랜치

---

### **Commit Type**

- Feat: 새로운 기능 구현
- Docs : 문서 수정 (README나 WIKI 등의 문서 개정)
- Add : 새로운 파일/라이브러리 추가 or Feat 이외의 부수적인 코드 추가.
- Fix : 버그, 오류 수정
- Style : 코드 포맷팅, 코드 변경이 없는 경우
- Del : 쓸모없는 라인/코드 삭제
- Move : 프로젝트 내 파일이나 코드의 이동
- Remove : 파일을 삭제하는 작업만 수행한 경우
- Refactor : 코드 리펙토링
- Rename : 파일 이름 변경
- MOD :  UI/Storyboard 수정한 경우

MVC
1. Model
- DataTodo : 저장 데이터 구조체
- DataManager : UserDefaults 저장 및 수정, 삭제
2. View
- Main.storyboard : UI 구성 Storyboard
- HomeView : URL Session을 구현하는 View
- TodoEditView : Todo List를 확인하고 수정하는 View
- CheckCompletePopup : 완료 List에서 상세정보를 표시하는 View
// TableViewCell
- ListTableViewCell : ListViewController에서 TableViewCell
- CompleteTableViewCell : CompleteViewController에서 TableViewCell
3. Controllers
- MainViewController : 메인화면에서 각화면으로 이동하는 버튼 구성
- ListViewController : TableView로 UserDefaults에 저장되어있는 데이터 표시
- AddTodoViewContrller : ListViewController에서 이동하는 화면으로 데이터 추가 화면
- CompleteViewController : 저장된 데이터에서 완료된 경우에만 데이터 표시. TableView로 표시
- HomeViewController : URLSession으로 이미지 불러오기

