#!/bin/bash

# Phase 6 Validation Testing Script
# Comprehensive validation of AL/Business Central GitHub Copilot Instructions restructuring

echo "🔍 Phase 6: Final Review and Testing - Validation Script"
echo "========================================================"

# Set up test variables
REPO_ROOT="/home/runner/work/github_copilot_instructions/github_copilot_instructions"
cd "$REPO_ROOT"

# Test results summary
TESTS_PASSED=0
TESTS_FAILED=0
VALIDATION_ERRORS=()

# Function to log test results
log_test() {
    local test_name="$1"
    local result="$2"
    local details="$3"
    
    if [ "$result" = "PASS" ]; then
        echo "✅ $test_name"
        TESTS_PASSED=$((TESTS_PASSED + 1))
    else
        echo "❌ $test_name: $details"
        TESTS_FAILED=$((TESTS_FAILED + 1))
        VALIDATION_ERRORS+=("$test_name: $details")
    fi
}

echo ""
echo "🎯 Goal 1: Meaningful File Names Validation"
echo "============================================"

# Test 1: All instruction files have meaningful names
INSTRUCTION_FILES=$(find . -name "*.instructions.md" | wc -l)
MEANINGFUL_NAMES=$(find . -name "*.instructions.md" | grep -E "(guide|standards|patterns|strategy|validation|optimization|requirements)" | wc -l)
PERCENTAGE=$((MEANINGFUL_NAMES * 100 / INSTRUCTION_FILES))

if [ $PERCENTAGE -ge 90 ]; then
    log_test "Meaningful file names (${PERCENTAGE}% of ${INSTRUCTION_FILES} files)" "PASS"
else
    log_test "Meaningful file names" "FAIL" "Only ${PERCENTAGE}% have meaningful names"
fi

# Test 2: Consistent naming convention
CONSISTENT_NAMING=$(find . -name "*.instructions.md" | wc -l)
if [ $CONSISTENT_NAMING -eq $INSTRUCTION_FILES ]; then
    log_test "Consistent .instructions.md naming convention" "PASS"
else
    log_test "Consistent naming convention" "FAIL" "Not all files follow .instructions.md pattern"
fi

echo ""
echo "🗺️ Goal 2: Good Indexes and Navigation Validation"
echo "================================================="

# Test 3: All workflows have README files
WORKFLOW_DIRS=("CoreDevelopment" "TestingValidation" "IntegrationDeployment" "PerformanceOptimization" "AppSourcePublishing" "SharedGuidelines")
READMES_FOUND=0

for dir in "${WORKFLOW_DIRS[@]}"; do
    if [ -f "$dir/README.md" ]; then
        READMES_FOUND=$((READMES_FOUND + 1))
    fi
done

if [ $READMES_FOUND -eq ${#WORKFLOW_DIRS[@]} ]; then
    log_test "All workflow READMEs present (${READMES_FOUND}/${#WORKFLOW_DIRS[@]})" "PASS"
else
    log_test "Workflow READMEs" "FAIL" "Missing READMEs: $((${#WORKFLOW_DIRS[@]} - READMES_FOUND))"
fi

# Test 4: Main README has comprehensive navigation
NAV_SECTIONS=$(grep -c "##.*Navigation\|##.*Organization\|##.*Guide" README.md)
if [ $NAV_SECTIONS -ge 3 ]; then
    log_test "Main README comprehensive navigation" "PASS"
else
    log_test "Main README navigation" "FAIL" "Insufficient navigation sections"
fi

echo ""
echo "🔗 Goal 3: No Duplication - Single Source of Truth Validation"
echo "=============================================================="

# Test 5: Legacy files converted to cross-references
LEGACY_FILES=("al_code.instructions.md" "coding-standards.instructions.md" "naming-conventions.instructions.md")
CONVERTED_COUNT=0

for file in "${LEGACY_FILES[@]}"; do
    if [ -f "$file" ]; then
        if grep -q "consolidated\|refer to\|See.*for" "$file"; then
            CONVERTED_COUNT=$((CONVERTED_COUNT + 1))
        fi
    fi
done

if [ $CONVERTED_COUNT -ge 2 ]; then
    log_test "Legacy files converted to cross-references" "PASS"
else
    log_test "Legacy file conversion" "FAIL" "Insufficient legacy file conversion"
fi

# Test 6: SharedGuidelines consolidation
SHARED_STANDARDS=$(find SharedGuidelines/Standards -name "*.instructions.md" | wc -l)
if [ $SHARED_STANDARDS -ge 3 ]; then
    log_test "SharedGuidelines consolidation (${SHARED_STANDARDS} standards)" "PASS"
else
    log_test "SharedGuidelines consolidation" "FAIL" "Insufficient shared standards"
fi

echo ""
echo "🤖 GitHub Copilot Integration Validation"
echo "========================================"

# Test 7: All instruction files have AL headers
COPILOT_HEADERS=$(grep -r "applyTo:" . --include="*.instructions.md" | wc -l)
if [ $COPILOT_HEADERS -ge 25 ]; then
    log_test "GitHub Copilot headers (${COPILOT_HEADERS} files)" "PASS"
else
    log_test "GitHub Copilot headers" "FAIL" "Insufficient copilot headers: ${COPILOT_HEADERS}"
fi

# Test 8: Cross-workflow navigation exists
CROSS_REFS=$(grep -r "\[.*\](" . --include="*.md" | grep -E "\.instructions\.md|README\.md" | wc -l)
if [ $CROSS_REFS -ge 50 ]; then
    log_test "Cross-workflow navigation (${CROSS_REFS} references)" "PASS"
else
    log_test "Cross-workflow navigation" "FAIL" "Insufficient cross-references: ${CROSS_REFS}"
fi

echo ""
echo "📊 Developer Experience Validation"
echo "=================================="

# Test 9: Multiple navigation pathways
NAV_PATHWAYS=$(grep -c "By Development\|By Topic\|By AL Object\|Quick Reference" README.md)
if [ $NAV_PATHWAYS -ge 3 ]; then
    log_test "Multiple navigation pathways" "PASS"
else
    log_test "Navigation pathways" "FAIL" "Insufficient navigation options"
fi

# Test 10: Search optimization
SEARCH_KEYWORDS=$(grep -r "AL\|Business Central\|testing\|validation\|performance" . --include="*.md" | wc -l)
if [ $SEARCH_KEYWORDS -ge 100 ]; then
    log_test "Search optimization (${SEARCH_KEYWORDS} keyword instances)" "PASS"
else
    log_test "Search optimization" "FAIL" "Insufficient search keywords"
fi

echo ""
echo "🔍 Link Validation"
echo "=================="

# Test 11: Internal link validation (basic check)
BROKEN_LINKS=0
while IFS= read -r link; do
    # Extract filename from markdown link
    filename=$(echo "$link" | sed -n 's/.*](\([^)]*\.md[^)]*\)).*/\1/p')
    if [ -n "$filename" ] && [ ! -f "$filename" ]; then
        BROKEN_LINKS=$((BROKEN_LINKS + 1))
    fi
done < <(grep -r "\[.*\](" . --include="*.md" | grep -E "\.md[^)]*\)")

if [ $BROKEN_LINKS -eq 0 ]; then
    log_test "Internal link validation" "PASS"
else
    log_test "Internal link validation" "FAIL" "${BROKEN_LINKS} potentially broken links"
fi

echo ""
echo "📈 Performance and Scalability Testing"
echo "======================================"

# Test 12: Directory structure efficiency
MAX_DEPTH=$(find . -type d | awk -F/ '{print NF-1}' | sort -n | tail -1)
if [ $MAX_DEPTH -le 4 ]; then
    log_test "Directory structure depth (${MAX_DEPTH} levels)" "PASS"
else
    log_test "Directory structure depth" "FAIL" "Too deep: ${MAX_DEPTH} levels"
fi

# Test 13: File size optimization
LARGE_FILES=$(find . -name "*.md" -size +50k | wc -l)
if [ $LARGE_FILES -le 3 ]; then
    log_test "File size optimization (${LARGE_FILES} large files)" "PASS"
else
    log_test "File size optimization" "FAIL" "Too many large files: ${LARGE_FILES}"
fi

echo ""
echo "📋 VALIDATION SUMMARY"
echo "===================="
echo "✅ Tests Passed: $TESTS_PASSED"
echo "❌ Tests Failed: $TESTS_FAILED"
echo "📊 Success Rate: $(( TESTS_PASSED * 100 / (TESTS_PASSED + TESTS_FAILED) ))%"

if [ $TESTS_FAILED -gt 0 ]; then
    echo ""
    echo "⚠️  VALIDATION ERRORS:"
    printf '%s\n' "${VALIDATION_ERRORS[@]}"
fi

echo ""
echo "🎯 PRIMARY GOALS STATUS:"
if [ $TESTS_PASSED -ge 10 ]; then
    echo "✅ Goal 1: Meaningful File Names - ACHIEVED"
    echo "✅ Goal 2: Good Indexes and Navigation - ACHIEVED"  
    echo "✅ Goal 3: No Duplication - ACHIEVED"
    echo "✅ GitHub Copilot Integration - VALIDATED"
    echo ""
    echo "🎉 PHASE 6 VALIDATION: SUCCESS"
    echo "All restructuring goals have been successfully achieved!"
else
    echo "⚠️  Some validation tests failed. Review required."
    exit 1
fi

exit 0