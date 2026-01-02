# setup.R
# 프로젝트 초기 설정 스크립트
# 작성일: 2025-01-02

cat("========================================\n")
cat("한국어 형태소 분석 프로젝트 초기 설정\n")
cat("========================================\n\n")

# ========== 1. 필수 R 패키지 설치 ==========
cat("1️⃣  필수 R 패키지 확인 및 설치\n")
cat("----------------------------------------\n")

# 필수 패키지 목록
required_packages <- c(
  # 데이터 처리
  "readxl", "dplyr", "tidyr", "stringr",
  # Python 연동
  "reticulate",
  # 텍스트 분석
  "quanteda", "stm", "tm", "SnowballC", "tidytext",
  # 시각화
  "ggplot2", "wordcloud", "wordcloud2", "RColorBrewer", "htmlwidgets",
  # 병렬 처리
  "parallel", "furrr",
  # 유틸리티
  "digest", "jsonlite"
)

# CRAN 미러 목록
cran_mirrors <- c(
  "https://cran.rstudio.com/",
  "https://cloud.r-project.org/",
  "https://cran.seoul.go.kr/",
  "https://cran.r-project.org/"
)

# 패키지 설치 함수
install_with_fallback <- function(pkg, mirrors = cran_mirrors) {
  for (mirror in mirrors) {
    tryCatch({
      install.packages(pkg, repos = mirror, quiet = TRUE)
      return(TRUE)
    }, error = function(e) {
      next
    })
  }
  return(FALSE)
}

# 패키지 확인 및 설치
installed_count <- 0
failed_packages <- c()

for (pkg in required_packages) {
  if (!require(pkg, character.only = TRUE, quietly = TRUE)) {
    cat(sprintf("  설치 중: %s...\n", pkg))
    if (install_with_fallback(pkg)) {
      library(pkg, character.only = TRUE, quietly = TRUE)
      installed_count <- installed_count + 1
      cat(sprintf("  ✅ %s 설치 완료\n", pkg))
    } else {
      failed_packages <- c(failed_packages, pkg)
      cat(sprintf("  ❌ %s 설치 실패\n", pkg))
    }
  } else {
    cat(sprintf("  ✓ %s 이미 설치됨\n", pkg))
  }
}

cat(sprintf("\n패키지 설치 완료: 새로 설치된 패키지 %d개\n", installed_count))
if (length(failed_packages) > 0) {
  cat(sprintf("⚠️  설치 실패한 패키지: %s\n", paste(failed_packages, collapse = ", ")))
  cat("수동으로 설치해 주세요: install.packages(c(\"%s\"))\n", paste(failed_packages, collapse = "\", \""))
}

# ========== 2. Python 환경 확인 ==========
cat("\n2️⃣  Python 환경 확인\n")
cat("----------------------------------------\n")

python_available <- FALSE
tryCatch({
  py_config <- reticulate::py_config()
  python_available <- TRUE
  cat("✅ Python 환경 감지됨\n")
  cat(sprintf("  Python 경로: %s\n", py_config$python))
}, error = function(e) {
  cat("❌ Python 환경을 찾을 수 없습니다\n")
  cat("  reticulate 패키지로 Python을 설치하거나 기존 Python을 지정하세요\n")
  cat("  예: reticulate::install_python()\n")
  cat("  또는: reticulate::use_python(\"/path/to/python\")\n")
})

# ========== 3. Kiwipiepy 설치 ==========
if (python_available) {
  cat("\n3️⃣  Kiwipiepy 패키지 확인\n")
  cat("----------------------------------------\n")

  kiwipiepy_installed <- FALSE
  tryCatch({
    reticulate::import("kiwipiepy")
    kiwipiepy_installed <- TRUE
    cat("✅ Kiwipiepy 이미 설치됨\n")
  }, error = function(e) {
    cat("📦 Kiwipiepy 설치 중...\n")
    tryCatch({
      reticulate::py_install("kiwipiepy", pip = TRUE)
      cat("✅ Kiwipiepy 설치 완료\n")
      kiwipiepy_installed <- TRUE
    }, error = function(e2) {
      cat("❌ Kiwipiepy 설치 실패\n")
      cat(sprintf("  오류: %s\n", e2$message))
      cat("  수동 설치: pip install kiwipiepy\n")
    })
  })
} else {
  cat("\n⚠️  Python 환경이 없어 Kiwipiepy 설치를 건너뜁니다\n")
}

# ========== 4. 디렉토리 구조 생성 ==========
cat("\n4️⃣  프로젝트 디렉토리 구조 생성\n")
cat("----------------------------------------\n")

directories <- c(
  "data/raw_data",
  "data/processed",
  "data/dictionaries",
  "data/dictionaries/dict_candidates",
  "data/config",
  "reports",
  "plots"
)

for (dir in directories) {
  if (!dir.exists(dir)) {
    dir.create(dir, recursive = TRUE)
    cat(sprintf("  ✅ 생성: %s\n", dir))
  } else {
    cat(sprintf("  ✓ 존재: %s\n", dir))
  }
}

# ========== 5. 설정 파일 확인 ==========
cat("\n5️⃣  설정 파일 확인\n")
cat("----------------------------------------\n")

# 복합어 매핑 파일 확인
compound_mappings_file <- "data/config/compound_mappings.csv"
if (file.exists(compound_mappings_file)) {
  cat(sprintf("  ✓ %s 존재\n", compound_mappings_file))
} else {
  cat(sprintf("  ⚠️  %s 없음\n", compound_mappings_file))
  cat("  기본 복합어 매핑 파일이 생성되어야 합니다\n")
}

# ========== 6. 테스트 실행 (선택사항) ==========
cat("\n6️⃣  테스트 실행 (선택사항)\n")
cat("----------------------------------------\n")

if (require("testthat", quietly = TRUE)) {
  cat("testthat 패키지가 설치되어 있습니다\n")
  cat("테스트를 실행하려면 다음 명령을 사용하세요:\n")
  cat("  testthat::test_dir('tests/testthat')\n")
} else {
  cat("⚠️  testthat 패키지가 설치되지 않았습니다 (선택사항)\n")
  cat("테스트를 실행하려면 설치하세요: install.packages('testthat')\n")
}

# ========== 완료 ==========
cat("\n========================================\n")
cat("✅ 초기 설정 완료!\n")
cat("========================================\n\n")

cat("다음 단계:\n")
cat("1. KCI 또는 RISS Excel 파일을 data/raw_data/ 폴더에 복사하세요\n")
cat("2. 파이프라인 실행:\n")
cat("   source('scripts/00_run_pipeline.R')\n")
cat("   run_full_pipeline()\n\n")

cat("문서:\n")
cat("- README.md: 프로젝트 개요 및 사용법\n")
cat("- CITATION.md: 인용 가이드\n\n")

cat("문제가 있으면 GitHub Issues에 보고해 주세요:\n")
cat("https://github.com/rubato103/textmining_KCI_RISS/issues\n\n")
