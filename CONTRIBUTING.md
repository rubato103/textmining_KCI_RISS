# 기여 가이드 (Contributing Guide)

한국어 | [English](#english-version)

프로젝트에 기여해 주셔서 감사합니다! 이 문서는 효과적인 기여를 위한 가이드라인을 제공합니다.

## 목차

- [행동 강령](#행동-강령)
- [시작하기](#시작하기)
- [개발 환경 설정](#개발-환경-설정)
- [기여 방법](#기여-방법)
- [코딩 스타일](#코딩-스타일)
- [테스트](#테스트)
- [Pull Request 프로세스](#pull-request-프로세스)
- [커밋 메시지 가이드](#커밋-메시지-가이드)

## 행동 강령

### 우리의 약속

모든 참여자에게 괴롭힘 없는 환경을 제공하기 위해 노력합니다. 다음을 존중해주세요:

- 서로 다른 관점과 경험을 존중
- 건설적인 비판을 우아하게 수용
- 커뮤니티에 최선인 것에 집중
- 다른 커뮤니티 구성원에 대한 공감 표시

## 시작하기

1. **Repository Fork**: GitHub에서 repository를 fork하세요
2. **Clone**: Fork한 repository를 로컬에 clone하세요
   ```bash
   git clone https://github.com/YOUR-USERNAME/textmining_KCI_RISS.git
   cd textmining_KCI_RISS
   ```
3. **Upstream 설정**: 원본 repository를 upstream으로 추가하세요
   ```bash
   git remote add upstream https://github.com/rubato103/textmining_KCI_RISS.git
   ```

## 개발 환경 설정

### 자동 설정 (권장)

```r
source("setup.R")
```

### 수동 설정

1. **필수 패키지 설치**:
   ```r
   packages <- c("readxl", "dplyr", "tidyr", "stringr", "parallel",
                 "stm", "ggplot2", "wordcloud", "reticulate",
                 "testthat", "lintr", "covr")
   install.packages(packages)
   ```

2. **Python 환경**:
   ```bash
   pip install kiwipiepy
   ```

3. **개발 도구**:
   ```r
   install.packages(c("devtools", "roxygen2", "pkgdown"))
   ```

## 기여 방법

### 버그 리포트

버그를 발견하셨나요? [Issues](https://github.com/rubato103/textmining_KCI_RISS/issues)에서 다음 정보와 함께 보고해주세요:

- **명확한 제목**: 문제를 간결하게 설명
- **재현 단계**: 버그를 재현하는 방법
- **예상 동작**: 어떻게 작동해야 하는지
- **실제 동작**: 실제로 어떻게 작동하는지
- **환경 정보**: R 버전, OS, 패키지 버전 등
- **스크린샷**: 가능한 경우

### 기능 제안

새로운 기능을 제안하고 싶으신가요?

1. [Issues](https://github.com/rubato103/textmining_KCI_RISS/issues)에서 기능 제안 생성
2. 제안의 배경과 사용 사례 설명
3. 커뮤니티 피드백 대기
4. 승인 후 구현 시작

### 코드 기여

1. **브랜치 생성**:
   ```bash
   git checkout -b feature/your-feature-name
   # 또는
   git checkout -b fix/your-bug-fix
   ```

2. **변경사항 구현**:
   - 코드 작성
   - 테스트 추가
   - 문서 업데이트

3. **로컬 테스트**:
   ```r
   testthat::test_dir("tests/testthat")
   ```

4. **커밋**:
   ```bash
   git add .
   git commit -m "feat: Add new feature"
   ```

5. **Push**:
   ```bash
   git push origin feature/your-feature-name
   ```

6. **Pull Request 생성**

## 코딩 스타일

### R 코드

본 프로젝트는 다음 스타일 가이드를 따릅니다:

#### 네이밍 규칙

```r
# 함수명: snake_case
standardize_data <- function(data) { }

# 변수명: snake_case
user_input <- readline()

# 상수: UPPER_SNAKE_CASE
CRAN_MIRRORS <- c("https://cran.rstudio.com/")

# 파일명: snake_case
# 00_utils.R, 01_data_loading.R
```

#### 들여쓰기 및 공백

```r
# 2칸 들여쓰기 사용
if (condition) {
  do_something()
}

# 연산자 주위 공백
x <- 1 + 2
result <- function(a, b)

# 쉼표 뒤 공백
c(1, 2, 3)
```

#### 주석

```r
# 한 줄 주석은 # 뒤 공백

#' Roxygen2 문서화
#'
#' @param data 데이터프레임
#' @return 처리된 데이터
#' @export
process_data <- function(data) {
  # 구현...
}
```

#### 최대 줄 길이

- 최대 120자 (권장 80자)

### 테스트 코드

```r
test_that("함수가 올바르게 동작한다", {
  # Arrange
  input_data <- data.frame(...)

  # Act
  result <- my_function(input_data)

  # Assert
  expect_equal(result$column, expected_value)
  expect_true(nrow(result) > 0)
})
```

## 테스트

### 테스트 실행

```r
# 모든 테스트 실행
testthat::test_dir("tests/testthat")

# 특정 파일 테스트
testthat::test_file("tests/testthat/test-utils.R")
```

### 테스트 커버리지

```r
# 커버리지 확인
covr::package_coverage()

# 대화형 리포트
covr::report()
```

### 테스트 작성 가이드

- 모든 새로운 함수에 테스트 추가
- 엣지 케이스 커버
- 의미 있는 테스트 이름 사용
- Arrange-Act-Assert 패턴 사용

## Pull Request 프로세스

### 체크리스트

Pull Request를 제출하기 전에 확인하세요:

- [ ] 코드가 스타일 가이드를 따르는가?
- [ ] 모든 테스트가 통과하는가?
- [ ] 새로운 기능에 테스트를 추가했는가?
- [ ] 문서를 업데이트했는가?
- [ ] 커밋 메시지가 규칙을 따르는가?
- [ ] CHANGELOG를 업데이트했는가? (해당하는 경우)

### PR 템플릿

```markdown
## 변경 내용
<!-- 무엇을 변경했는지 간결하게 설명 -->

## 변경 이유
<!-- 왜 이 변경이 필요한지 설명 -->

## 테스트 방법
<!-- 변경사항을 어떻게 테스트할 수 있는지 -->

## 관련 Issue
<!-- Issue 번호 참조: Closes #123 -->

## 스크린샷 (해당하는 경우)
<!-- 시각적 변경이 있다면 스크린샷 추가 -->

## 체크리스트
- [ ] 테스트 추가/업데이트
- [ ] 문서 업데이트
- [ ] 코드 스타일 확인
```

### 리뷰 프로세스

1. **자동 검사**: CI/CD가 자동으로 테스트 실행
2. **코드 리뷰**: 메인테이너가 코드 검토
3. **피드백**: 필요시 수정 요청
4. **승인**: 모든 검사 통과 후 병합

## 커밋 메시지 가이드

### 형식

```
<type>(<scope>): <subject>

<body>

<footer>
```

### Type

- `feat`: 새로운 기능
- `fix`: 버그 수정
- `docs`: 문서 변경
- `style`: 코드 스타일 변경 (포맷팅, 세미콜론 등)
- `refactor`: 리팩토링
- `test`: 테스트 추가/수정
- `chore`: 빌드 프로세스, 도구 설정 등

### 예시

```
feat(dtm): Add compound word normalization from CSV

- Load compound mappings from external CSV file
- Add fallback to default mappings
- Update documentation

Closes #45
```

## 문서화

### Roxygen2

모든 내보내는 함수에 Roxygen2 문서 추가:

```r
#' 데이터 표준화
#'
#' KCI 및 RISS 데이터를 표준 형식으로 변환합니다.
#'
#' @param data 원본 데이터프레임
#' @param verbose 로그 출력 여부 (기본값: TRUE)
#' @return 표준화된 데이터프레임
#' @examples
#' \dontrun{
#' data <- read_excel("data.xlsx")
#' standardized <- standardize_data(data)
#' }
#' @export
standardize_data <- function(data, verbose = TRUE) {
  # ...
}
```

### README 업데이트

새로운 기능을 추가했다면 README.md를 업데이트하세요:

- 기능 설명
- 사용 예시
- 관련 설정

## 질문이나 도움이 필요하신가요?

- **Issue**: [GitHub Issues](https://github.com/rubato103/textmining_KCI_RISS/issues)
- **Email**: rubato103@dodaseo.cc
- **Discussion**: [GitHub Discussions](https://github.com/rubato103/textmining_KCI_RISS/discussions)

## 라이선스

본 프로젝트에 기여함으로써, 귀하는 기여 내용이 프로젝트와 동일한 라이선스(학술 및 교육용 라이선스) 하에 배포되는 것에 동의합니다.

---

# English Version

Thank you for contributing to this project! This document provides guidelines for effective contribution.

## Table of Contents

- [Code of Conduct](#code-of-conduct)
- [Getting Started](#getting-started-1)
- [Development Setup](#development-setup)
- [How to Contribute](#how-to-contribute)
- [Coding Style](#coding-style-1)
- [Testing](#testing-1)
- [Pull Request Process](#pull-request-process-1)
- [Commit Message Guidelines](#commit-message-guidelines)

## Code of Conduct

### Our Pledge

We strive to provide a harassment-free environment for all participants. Please respect:

- Different viewpoints and experiences
- Gracefully accepting constructive criticism
- Focusing on what is best for the community
- Showing empathy towards other community members

## Getting Started

1. **Fork the Repository**: Fork the repository on GitHub
2. **Clone**: Clone your forked repository locally
   ```bash
   git clone https://github.com/YOUR-USERNAME/textmining_KCI_RISS.git
   cd textmining_KCI_RISS
   ```
3. **Set Upstream**: Add the original repository as upstream
   ```bash
   git remote add upstream https://github.com/rubato103/textmining_KCI_RISS.git
   ```

## Development Setup

### Automated Setup (Recommended)

```r
source("setup.R")
```

### Manual Setup

1. **Install Required Packages**:
   ```r
   packages <- c("readxl", "dplyr", "tidyr", "stringr", "parallel",
                 "stm", "ggplot2", "wordcloud", "reticulate",
                 "testthat", "lintr", "covr")
   install.packages(packages)
   ```

2. **Python Environment**:
   ```bash
   pip install kiwipiepy
   ```

3. **Development Tools**:
   ```r
   install.packages(c("devtools", "roxygen2", "pkgdown"))
   ```

## How to Contribute

### Bug Reports

Found a bug? Report it in [Issues](https://github.com/rubato103/textmining_KCI_RISS/issues) with:

- **Clear Title**: Concisely describe the issue
- **Steps to Reproduce**: How to reproduce the bug
- **Expected Behavior**: What should happen
- **Actual Behavior**: What actually happens
- **Environment**: R version, OS, package versions
- **Screenshots**: If applicable

### Feature Suggestions

Want to suggest a new feature?

1. Create a feature request in [Issues](https://github.com/rubato103/textmining_KCI_RISS/issues)
2. Explain the background and use cases
3. Wait for community feedback
4. Start implementation after approval

### Code Contributions

1. **Create Branch**:
   ```bash
   git checkout -b feature/your-feature-name
   # or
   git checkout -b fix/your-bug-fix
   ```

2. **Implement Changes**:
   - Write code
   - Add tests
   - Update documentation

3. **Test Locally**:
   ```r
   testthat::test_dir("tests/testthat")
   ```

4. **Commit**:
   ```bash
   git add .
   git commit -m "feat: Add new feature"
   ```

5. **Push**:
   ```bash
   git push origin feature/your-feature-name
   ```

6. **Create Pull Request**

## Coding Style

### R Code

This project follows these style guidelines:

#### Naming Conventions

```r
# Function names: snake_case
standardize_data <- function(data) { }

# Variable names: snake_case
user_input <- readline()

# Constants: UPPER_SNAKE_CASE
CRAN_MIRRORS <- c("https://cran.rstudio.com/")

# File names: snake_case
# 00_utils.R, 01_data_loading.R
```

#### Indentation and Spacing

```r
# Use 2-space indentation
if (condition) {
  do_something()
}

# Spaces around operators
x <- 1 + 2
result <- function(a, b)

# Space after comma
c(1, 2, 3)
```

#### Comments

```r
# Single-line comments with space after #

#' Roxygen2 documentation
#'
#' @param data Data frame
#' @return Processed data
#' @export
process_data <- function(data) {
  # Implementation...
}
```

#### Maximum Line Length

- Maximum 120 characters (80 recommended)

### Test Code

```r
test_that("function works correctly", {
  # Arrange
  input_data <- data.frame(...)

  # Act
  result <- my_function(input_data)

  # Assert
  expect_equal(result$column, expected_value)
  expect_true(nrow(result) > 0)
})
```

## Testing

### Running Tests

```r
# Run all tests
testthat::test_dir("tests/testthat")

# Test specific file
testthat::test_file("tests/testthat/test-utils.R")
```

### Test Coverage

```r
# Check coverage
covr::package_coverage()

# Interactive report
covr::report()
```

### Test Writing Guidelines

- Add tests for all new functions
- Cover edge cases
- Use meaningful test names
- Follow Arrange-Act-Assert pattern

## Pull Request Process

### Checklist

Before submitting a Pull Request, verify:

- [ ] Code follows style guide?
- [ ] All tests pass?
- [ ] Added tests for new features?
- [ ] Updated documentation?
- [ ] Commit messages follow guidelines?
- [ ] Updated CHANGELOG? (if applicable)

### PR Template

```markdown
## Changes
<!-- Briefly describe what was changed -->

## Reason
<!-- Explain why this change is needed -->

## Testing
<!-- How to test the changes -->

## Related Issue
<!-- Reference issue number: Closes #123 -->

## Screenshots (if applicable)
<!-- Add screenshots for visual changes -->

## Checklist
- [ ] Added/updated tests
- [ ] Updated documentation
- [ ] Checked code style
```

### Review Process

1. **Automated Checks**: CI/CD runs tests automatically
2. **Code Review**: Maintainers review code
3. **Feedback**: Requested changes if needed
4. **Approval**: Merged after all checks pass

## Commit Message Guidelines

### Format

```
<type>(<scope>): <subject>

<body>

<footer>
```

### Type

- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation changes
- `style`: Code style changes (formatting, semicolons, etc.)
- `refactor`: Refactoring
- `test`: Adding/modifying tests
- `chore`: Build process, tool configuration, etc.

### Example

```
feat(dtm): Add compound word normalization from CSV

- Load compound mappings from external CSV file
- Add fallback to default mappings
- Update documentation

Closes #45
```

## Documentation

### Roxygen2

Add Roxygen2 documentation for all exported functions:

```r
#' Standardize Data
#'
#' Converts KCI and RISS data to standard format.
#'
#' @param data Original data frame
#' @param verbose Log output (default: TRUE)
#' @return Standardized data frame
#' @examples
#' \dontrun{
#' data <- read_excel("data.xlsx")
#' standardized <- standardize_data(data)
#' }
#' @export
standardize_data <- function(data, verbose = TRUE) {
  # ...
}
```

### README Updates

If you add new features, update README.md with:

- Feature description
- Usage examples
- Related configuration

## Questions or Need Help?

- **Issues**: [GitHub Issues](https://github.com/rubato103/textmining_KCI_RISS/issues)
- **Email**: rubato103@dodaseo.cc
- **Discussion**: [GitHub Discussions](https://github.com/rubato103/textmining_KCI_RISS/discussions)

## License

By contributing to this project, you agree that your contributions will be distributed under the same license as the project (Academic and Educational Use License).
