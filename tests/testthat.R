# This file is part of the standard setup for testthat.
# It is recommended that you do not modify it.
#
# Where should you do additional test configuration?
# Learn more about the roles of various files in:
# * https://r-pkgs.org/tests.html
# * https://testthat.r-lib.org/reference/test_package.html#special-files

library(testthat)

# Source utility functions for testing
test_dir <- "testthat"
test_check_env <- new.env(parent = globalenv())

# Load project utilities
source("scripts/00_utils.R", local = test_check_env)
source("scripts/00_config.R", local = test_check_env)

# Run tests
test_check("textmining_KCI_RISS")
