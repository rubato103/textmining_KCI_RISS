# Test suite for utility functions in 00_utils.R

# Load required libraries
library(testthat)

# Source the utilities
source("../../scripts/00_utils.R")

# ========== Test: Package Management Functions ==========

test_that("CRAN_MIRRORS is properly defined", {
  expect_true(exists("CRAN_MIRRORS"))
  expect_type(CRAN_MIRRORS, "character")
  expect_gte(length(CRAN_MIRRORS), 4)
  expect_true(all(grepl("^https://", CRAN_MIRRORS)))
})

# ========== Test: generate_hash_id ==========

test_that("generate_hash_id creates unique IDs", {
  # Create test data
  test_data <- data.frame(
    제목 = c("테스트 논문 1", "테스트 논문 2", "테스트 논문 3"),
    저자 = c("저자1", "저자2", "저자3"),
    stringsAsFactors = FALSE
  )

  # Generate IDs
  ids <- generate_hash_id(test_data)

  # Test ID format and uniqueness
  expect_length(ids, 3)
  expect_type(ids, "character")
  expect_true(all(grepl("^doc\\d{8}", ids)))
  expect_equal(length(unique(ids)), 3)
})

test_that("generate_hash_id handles missing columns gracefully", {
  # Data with no standard columns
  test_data <- data.frame(
    col1 = c("value1", "value2"),
    col2 = c("value3", "value4"),
    stringsAsFactors = FALSE
  )

  # Should still generate IDs (using row numbers)
  ids <- generate_hash_id(test_data)

  expect_length(ids, 2)
  expect_type(ids, "character")
})

test_that("generate_hash_id handles duplicate data correctly", {
  # Create data with potential duplicates
  test_data <- data.frame(
    제목 = c("동일 논문", "동일 논문", "다른 논문"),
    저자 = c("저자", "저자", "저자2"),
    stringsAsFactors = FALSE
  )

  ids <- generate_hash_id(test_data)

  # All IDs should still be unique (with suffix added for duplicates)
  expect_equal(length(unique(ids)), 3)
})

# ========== Test: validate_data ==========

test_that("validate_data correctly validates basic data structure", {
  # Valid data
  valid_data <- data.frame(
    doc_id = c("doc001", "doc002", "doc003"),
    text = c("text1", "text2", "text3"),
    stringsAsFactors = FALSE
  )

  # Suppress output for cleaner test results
  expect_output(
    result <- validate_data(valid_data, check_type = "basic"),
    "모든 검증 통과"
  )
  expect_true(result)
})

test_that("validate_data detects duplicate IDs", {
  # Data with duplicate doc_ids
  invalid_data <- data.frame(
    doc_id = c("doc001", "doc001", "doc003"),
    text = c("text1", "text2", "text3"),
    stringsAsFactors = FALSE
  )

  expect_output(
    result <- validate_data(invalid_data, check_type = "basic"),
    "검증 실패"
  )
  expect_false(result)
})

test_that("validate_data detects missing doc_id column", {
  # Data without doc_id
  invalid_data <- data.frame(
    id = c("001", "002", "003"),
    text = c("text1", "text2", "text3"),
    stringsAsFactors = FALSE
  )

  expect_output(
    result <- validate_data(invalid_data, check_type = "basic"),
    "검증 실패"
  )
  expect_false(result)
})

# ========== Test: ensure_packages ==========

test_that("ensure_packages returns status list", {
  # Test with a package that should already be installed
  skip_if_not_installed("testthat")

  # Suppress package loading messages
  suppressMessages(
    status <- ensure_packages("testthat")
  )

  expect_type(status, "list")
  expect_true("testthat" %in% names(status))
  expect_true(status$testthat %in% c("installed", "already_installed"))
})

# ========== Test: Data Standardization Functions ==========

test_that("standardize_data preserves data integrity", {
  # Create test data with various column names
  test_data <- data.frame(
    `논문 ID` = c("001", "002", "003"),
    `국문 초록` = c("한글 초록 1", "한글 초록 2", "한글 초록 3"),
    발행연도 = c("2023", "2024", "2025"),
    check.names = FALSE,
    stringsAsFactors = FALSE
  )

  # Standardize
  result <- standardize_data(test_data, verbose = FALSE)

  # Check that standard columns exist
  expect_true("doc_id" %in% names(result))
  expect_true("abstract" %in% names(result) || "국문 초록" %in% names(result))
  expect_true("pub_year" %in% names(result))

  # Check data preservation
  expect_equal(nrow(result), nrow(test_data))

  # doc_id should be first column
  expect_equal(names(result)[1], "doc_id")
})

test_that("standardize_data handles missing columns", {
  # Minimal data
  test_data <- data.frame(
    title = c("논문1", "논문2"),
    content = c("내용1", "내용2"),
    stringsAsFactors = FALSE
  )

  result <- standardize_data(test_data, verbose = FALSE)

  # Should have doc_id (generated)
  expect_true("doc_id" %in% names(result))
  expect_equal(nrow(result), 2)
})

# ========== Test: Configuration Functions ==========

test_that("PROJECT_CONFIG is properly initialized", {
  skip_if_not(exists("PROJECT_CONFIG"))

  expect_type(PROJECT_CONFIG, "list")
  expect_true("paths" %in% names(PROJECT_CONFIG))
  expect_true("file_patterns" %in% names(PROJECT_CONFIG))
  expect_true("defaults" %in% names(PROJECT_CONFIG))
})

# ========== Summary ==========

cat("\n")
cat("========================================\n")
cat("Unit Tests for Utility Functions\n")
cat("========================================\n")
cat("All tests completed. Check results above.\n")
cat("========================================\n\n")
