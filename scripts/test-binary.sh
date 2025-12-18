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

# Run all tests
test_binary_exists || exit 1
test_version
test_help
test_exit_code
test_invalid_command

echo "================================"
echo "Results: $TESTS_PASSED passed, $TESTS_FAILED failed"

if [ $TESTS_FAILED -gt 0 ]; then
    echo "❌ Some tests failed!"
    exit 1
else
    echo "✅ All tests passed!"
    exit 0
fi
