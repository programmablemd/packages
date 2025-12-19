#!/bin/bash
# Test script to validate Spry binary after compilation
# This script runs automatically after the binary is built to ensure it works correctly.

set -e

BINARY="${1:-./spry}"
TESTS_PASSED=0
TESTS_FAILED=0

echo "🧪 Testing Spry binary: $BINARY"
echo "================================"

# Test 1: Binary exists and is executable
test_binary_exists() {
    echo -n "Test 1: Binary exists and is executable... "
    if [ -x "$BINARY" ]; then
        echo "✅ PASS"
        ((TESTS_PASSED++)) || true
    else
        echo "❌ FAIL - Binary not found or not executable"
        ((TESTS_FAILED++)) || true
        return 1
    fi
}

# Test 2: --version returns version info
test_version() {
    echo -n "Test 2: --version flag works... "
    if $BINARY --version 2>&1 | grep -qE "v?[0-9]+\.[0-9]+\.[0-9]+"; then
        echo "✅ PASS"
        ((TESTS_PASSED++)) || true
    else
        echo "❌ FAIL - Version output not valid"
        ((TESTS_FAILED++)) || true
    fi
}

# Test 3: --help returns help info
test_help() {
    echo -n "Test 3: --help flag works... "
    if $BINARY --help 2>&1 | grep -qi "spry\|usage\|commands"; then
        echo "✅ PASS"
        ((TESTS_PASSED++)) || true
    else
        echo "❌ FAIL - Help output not valid"
        ((TESTS_FAILED++)) || true
    fi
}

# Test 4: Exit code is 0 for valid commands
test_exit_code() {
    echo -n "Test 4: Exit code is 0 for --help... "
    if $BINARY --help > /dev/null 2>&1; then
        echo "✅ PASS"
        ((TESTS_PASSED++)) || true
    else
        echo "❌ FAIL - Non-zero exit code"
        ((TESTS_FAILED++)) || true
    fi
}

# Test 5: Binary returns non-zero for invalid command
test_invalid_command() {
    echo -n "Test 5: Invalid command returns error... "
    if ! $BINARY invalid-command-xyz123 > /dev/null 2>&1; then
        echo "✅ PASS"
        ((TESTS_PASSED++)) || true
    else
        echo "⚠️ SKIP - May be valid behavior"
    fi
}

# Test 6: spry rb ls test_files/runbook-01.md (Strict output check)
test_rb_ls() {
    echo -n "Test 6: spry rb ls test_files/runbook-01.md... "
    
    # Store expected output (ignoring potential trailing spaces)
    cat > expected_ls.txt << 'EOF'
Name    DEPS    GRAPH    Args        DESCR                 ORIGIN            ENGINE                
------  ------  -------  ----------  --------------------  ----------------  ----------------------
task-1                               A demo task           runbook-01.md:1   1 Deno task           
task-2  task-3               CM      Another demo task     runbook-01.md:8   1 Deno task           
task-3                       CF G S  Another demo task     runbook-01.md:14  #!/usr/bin/env -S bash
task-4                     I         Show captured output  runbook-01.md:22  #!/usr/bin/env -S cat 
clean           special                                    runbook-01.md:32  1 Deno task
EOF

    # Get actual output, strip ANSI colors, compress whitespace
    $BINARY rb ls test_files/runbook-01.md 2>&1 | sed -E 's/\x1b\[[0-9;]*m//g; s/[[:space:]]+/ /g; s/^ //; s/ $//' > actual_ls.txt
    
    # Normalize expected too
    sed -E -i 's/[[:space:]]+/ /g; s/^ //; s/ $//' expected_ls.txt

    if diff -q expected_ls.txt actual_ls.txt > /dev/null; then
        echo "✅ PASS"
        ((TESTS_PASSED++)) || true
        rm -f expected_ls.txt actual_ls.txt
    else
        echo "❌ FAIL - Output mismatch"
        echo "--- Expected (normalized) ---"
        cat expected_ls.txt
        echo "--- Actual (normalized) ---"
        cat actual_ls.txt
        echo "----------------"
        ((TESTS_FAILED++)) || true
    fi
}

# Test 7: spry rb task task-1 test_files/runbook-01.md (Strict output check)
test_rb_run() {
    echo -n "Test 7: spry rb task task-1... "
    
    EXPECTED="task-1 successful"
    
    # Get actual output, strip ANSI colors, and normalize whitespace
    ACTUAL=$($BINARY rb task task-1 test_files/runbook-01.md 2>&1 | sed -E 's/\x1b\[[0-9;]*m//g; s/[[:space:]]+/ /g; s/^ //; s/ $//')
    
    if [ "$ACTUAL" = "$EXPECTED" ]; then
        echo "✅ PASS"
        ((TESTS_PASSED++)) || true
    else
        echo "❌ FAIL - Output mismatch"
        echo "--- Expected ---"
        echo "[$EXPECTED]"
        echo "--- Actual ---"
        echo "[$ACTUAL]"
        echo "----------------"
        ((TESTS_FAILED++)) || true
    fi
}

# Test 8: spry rb task task-3 test_files/runbook-01.md (with file capture check)
test_rb_task_3() {
    echo -n "Test 8: spry rb task task-3 and file capture... "
    
    # Cleanup previous runs
    rm -f task-3.txt
    
    EXPECTED_STDOUT="task-3 successful"
    EXPECTED_FILE_CONTENT="task-3 successful"
    
    # Get actual stdout, strip ANSI colors, and normalize whitespace
    ACTUAL_STDOUT=$($BINARY rb task task-3 test_files/runbook-01.md 2>&1 | sed -E 's/\x1b\[[0-9;]*m//g; s/[[:space:]]+/ /g; s/^ //; s/ $//')
    
    if [ "$ACTUAL_STDOUT" != "$EXPECTED_STDOUT" ]; then
        echo "❌ FAIL - STDOUT mismatch"
        echo "--- Expected ---"
        echo "[$EXPECTED_STDOUT]"
        echo "--- Actual ---"
        echo "[$ACTUAL_STDOUT]"
        ((TESTS_FAILED++)) || true
        return
    fi
    
    # Check if file was captured
    if [ ! -f "task-3.txt" ]; then
        echo "❌ FAIL - task-3.txt not generated"
        ((TESTS_FAILED++)) || true
        return
    fi
    
    # Verify file content
    ACTUAL_FILE_CONTENT=$(cat task-3.txt | sed -E 's/[[:space:]]+/ /g; s/^ //; s/ $//')
    if [ "$ACTUAL_FILE_CONTENT" != "$EXPECTED_FILE_CONTENT" ]; then
        echo "❌ FAIL - task-3.txt content mismatch"
        echo "--- Expected ---"
        echo "[$EXPECTED_FILE_CONTENT]"
        echo "--- Actual ---"
        echo "[$ACTUAL_FILE_CONTENT]"
        ((TESTS_FAILED++)) || true
        return
    fi
    
    echo "✅ PASS"
    ((TESTS_PASSED++)) || true
    rm -f task-3.txt
}

# Run all tests
test_binary_exists || exit 1
test_version
test_help
test_exit_code
test_invalid_command
test_rb_ls
test_rb_run
test_rb_task_3

echo "================================"
echo "Results: $TESTS_PASSED passed, $TESTS_FAILED failed"

if [ $TESTS_FAILED -gt 0 ]; then
    echo "❌ Some tests failed!"
    exit 1
else
    echo "✅ All tests passed!"
    exit 0
fi
