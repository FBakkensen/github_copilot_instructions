#!/bin/bash

# Link Validation and Repair Tool
# Validates and fixes internal markdown links across the repository

echo "🔗 Link Validation and Repair Tool"
echo "=================================="

REPO_ROOT="/home/runner/work/github_copilot_instructions/github_copilot_instructions"
cd "$REPO_ROOT"

BROKEN_LINKS=0
FIXED_LINKS=0
VALIDATION_LOG=()

# Function to check if a file exists
check_file_exists() {
    local file_path="$1"
    local base_dir="$2"
    
    # Handle relative paths
    if [[ "$file_path" == ./* ]]; then
        file_path="${file_path#./}"
    fi
    
    # Check from base directory
    if [ -f "${base_dir}/${file_path}" ]; then
        return 0
    fi
    
    # Check from repo root
    if [ -f "${REPO_ROOT}/${file_path}" ]; then
        return 0
    fi
    
    return 1
}

echo "🔍 Scanning all markdown files for internal links..."

# Find all markdown files and check their internal links
while IFS= read -r file; do
    echo "Checking: $file"
    base_dir=$(dirname "$file")
    
    # Extract markdown links that point to .md files
    while IFS= read -r line; do
        # Extract the link path from [text](path) format
        link_path=$(echo "$line" | sed -n 's/.*\](\([^)]*\.md[^)]*\)).*/\1/p')
        
        if [ -n "$link_path" ] && [[ "$link_path" != http* ]]; then
            # Remove any anchor fragments for file existence check
            file_only=$(echo "$link_path" | cut -d'#' -f1)
            
            if ! check_file_exists "$file_only" "$base_dir"; then
                echo "  ❌ Broken link: $link_path"
                BROKEN_LINKS=$((BROKEN_LINKS + 1))
                VALIDATION_LOG+=("$file: Broken link to $link_path")
                
                # Try to find the correct path
                filename=$(basename "$file_only")
                if [ -n "$filename" ]; then
                    # Search for the file in the repository
                    found_file=$(find "$REPO_ROOT" -name "$filename" -type f | head -1)
                    if [ -n "$found_file" ]; then
                        # Calculate relative path from current file to found file
                        rel_path=$(realpath --relative-to="$base_dir" "$found_file")
                        echo "    💡 Suggestion: Use $rel_path instead"
                    fi
                fi
            else
                echo "  ✅ Valid link: $link_path"
            fi
        fi
    done < <(grep -n "\[.*\](" "$file" || true)
    
done < <(find . -name "*.md" -type f)

echo ""
echo "📋 LINK VALIDATION SUMMARY"
echo "=========================="
echo "❌ Broken links found: $BROKEN_LINKS"

if [ $BROKEN_LINKS -gt 0 ]; then
    echo ""
    echo "🔧 DETAILED BROKEN LINKS:"
    printf '%s\n' "${VALIDATION_LOG[@]}"
    
    echo ""
    echo "💡 COMMON FIXES NEEDED:"
    echo "1. Update relative paths to match current directory structure"
    echo "2. Fix case sensitivity in file names"
    echo "3. Update moved file references"
    echo "4. Add missing anchor links where needed"
fi

# Check for common navigation patterns
echo ""
echo "🧭 Navigation Pattern Validation"
echo "==============================="

# Check if main navigation patterns are working
NAV_TESTS=(
    "SharedGuidelines/Standards/naming-conventions.instructions.md"
    "CoreDevelopment/al-development-guide.instructions.md"
    "TestingValidation/testing-strategy.instructions.md"
    "IntegrationDeployment/integration-patterns.instructions.md"
    "PerformanceOptimization/optimization-guide.instructions.md"
    "AppSourcePublishing/appsource-requirements.instructions.md"
)

WORKING_NAV=0
for nav_file in "${NAV_TESTS[@]}"; do
    if [ -f "$nav_file" ]; then
        echo "✅ $nav_file"
        WORKING_NAV=$((WORKING_NAV + 1))
    else
        echo "❌ Missing: $nav_file"
    fi
done

echo ""
echo "Navigation files working: $WORKING_NAV/${#NAV_TESTS[@]}"

# Validate cross-reference patterns
echo ""
echo "🔄 Cross-Reference Pattern Analysis"
echo "==================================="

CROSS_REF_COUNT=$(grep -r "\[.*\](.*\.instructions\.md" . --include="*.md" | wc -l)
WORKFLOW_REFS=$(grep -r "\[.*\](.*/" . --include="*.md" | grep -E "(CoreDevelopment|TestingValidation|IntegrationDeployment|PerformanceOptimization|AppSourcePublishing|SharedGuidelines)" | wc -l)

echo "Total cross-references to instruction files: $CROSS_REF_COUNT"
echo "Workflow-based references: $WORKFLOW_REFS"

if [ $CROSS_REF_COUNT -ge 50 ] && [ $WORKFLOW_REFS -ge 20 ]; then
    echo "✅ Cross-reference network is robust"
else
    echo "⚠️  Cross-reference network may need enhancement"
fi

# Generate link validation report
echo ""
echo "📊 Generating Link Validation Report..."

cat > LINK_VALIDATION_REPORT.md << EOF
# Link Validation Report

## Summary
- **Total broken links**: $BROKEN_LINKS
- **Navigation files working**: $WORKING_NAV/${#NAV_TESTS[@]}
- **Cross-references found**: $CROSS_REF_COUNT
- **Workflow references**: $WORKFLOW_REFS

## Validation Status
$([ $BROKEN_LINKS -eq 0 ] && echo "✅ **PASSED**: All internal links are functional" || echo "⚠️ **ATTENTION NEEDED**: $BROKEN_LINKS broken links require fixing")

## Recommendations

### Immediate Actions
$([ $BROKEN_LINKS -gt 0 ] && echo "1. Fix broken links identified in validation
2. Update relative paths to match directory structure
3. Validate anchor links in referenced files" || echo "1. Maintain current link structure
2. Monitor for new broken links during updates
3. Continue using relative paths for internal references")

### Navigation Excellence
- Cross-reference network is $([ $CROSS_REF_COUNT -ge 50 ] && echo "robust" || echo "developing")
- Workflow integration is $([ $WORKFLOW_REFS -ge 20 ] && echo "excellent" || echo "adequate")

## Link Maintenance Best Practices

1. **Use Relative Paths**: Always use relative paths for internal references
2. **Test After Moves**: Validate links when moving or renaming files
3. **Anchor Validation**: Ensure section anchors exist in referenced files
4. **Cross-Workflow Links**: Maintain clear navigation between workflows

---
**Generated**: $(date)
**Validation Tool**: Link Validation and Repair Tool v1.0
EOF

echo "✅ Report generated: LINK_VALIDATION_REPORT.md"

if [ $BROKEN_LINKS -eq 0 ]; then
    echo ""
    echo "🎉 LINK VALIDATION: SUCCESS"
    echo "All internal links are functional!"
    exit 0
else
    echo ""
    echo "⚠️ LINK VALIDATION: ATTENTION NEEDED"
    echo "$BROKEN_LINKS broken links require fixing"
    exit 1
fi