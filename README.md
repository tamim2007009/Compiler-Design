# Compiler Design Project Suite

A comprehensive collection of compiler design implementations showcasing lexical analysis, parsing, and code generation techniques using **Flex** (lexical analyzer generator) and **Bison** (LALR parser generator).

## 📋 Table of Contents

- [Project Overview](#project-overview)
- [Final Project](#final-project)
- [Laboratory Assignments](#laboratory-assignments)
- [Technologies Used](#technologies-used)
- [Project Structure](#project-structure)
- [Getting Started](#getting-started)
- [Compilation & Execution](#compilation--execution)

---

## 📌 Project Overview

This repository contains academic implementations of compiler design concepts, progressing from basic lexical analysis to a fully functional calculator compiler. Each component demonstrates fundamental compiler theory principles including tokenization, syntax analysis, and semantic evaluation.

### Key Concepts Covered
- **Lexical Analysis**: Tokenization and pattern matching using regular expressions
- **Syntax Analysis**: Context-free grammar and parser generation using LALR(1) parsing
- **Semantic Analysis**: Symbol table management and expression evaluation
- **Error Handling**: Graceful error management including division by zero detection

---

## 🎯 Final Project: Expression Evaluator Compiler

### Overview
A fully-functional calculator compiler that evaluates mathematical expressions with variable assignment, operator precedence, and a runtime symbol table.

### Features
✅ **Variable Assignment**: Store and retrieve variable values (e.g., `a = 5`, `b = 11`)  
✅ **Arithmetic Operations**: Supports `+`, `-`, `*`, `/` with proper precedence  
✅ **Parenthetical Expressions**: Full support for nested parentheses  
✅ **Unary Negation**: Handles negative numbers and negation operator  
✅ **Error Handling**: Division by zero detection and reporting  
✅ **Symbol Table**: Maintains a 26-element array for lowercase letter variables  
✅ **File I/O**: Reads from `input.txt` and writes results to `output.txt`

### Technical Architecture

#### Components

**1. Lexer (tamim.l)**
- Scans input character-by-character
- Recognizes tokens: integers, variables (a-z), operators, delimiters
- Ignores whitespace
- Compiled with Flex to generate `lex.yy.c`

**2. Parser (tamim.y)**
- Defines context-free grammar with LALR(1) parsing
- Handles operator precedence (`%left`, `%right` declarations)
- Performs semantic evaluation during parsing
- Symbol table: `int sym[26]` for variable values 0-25 (a-z)
- Compiled with Bison to generate `tamim.tab.c` and `tamim.tab.h`

**3. Main Program**
- Redirects standard I/O to files
- Invokes parser via `yyparse()`
- Manages file lifecycle and error reporting

### Grammar Specification

```
program     → program statement '\n' | ε
statement   → expression | VARIABLE '=' expression
expression  → INTEGER | VARIABLE | expression '+' expression
            | expression '-' expression | expression '*' expression
            | expression '/' expression | '-' expression %prec UMINUS
            | '(' expression ')'
```

### Operator Precedence & Associativity
```
%left '+' '-'           // Addition/Subtraction (left-associative)
%left '*' '/'           // Multiplication/Division (left-associative)
%right UMINUS           // Unary Minus (right-associative)
```

### Sample Input & Output

**input.txt:**
```
a=5
b=11
(2+9)-3*9 + a + b
```

**output.txt:**
```
Assigned: a = 5
Assigned: b = 11
Result: -7
```

### Build Instructions (Final Project)

```bash
make -f makefile final
```

**Makefile commands:**
```makefile
bison -d tamim.y         # Generate parser (tamim.tab.c, tamim.tab.h)
flex tamim.l             # Generate lexer (lex.yy.c)
gcc tamim.tab.c lex.yy.c # Link into executable (a.exe)
./a.exe                  # Execute compiled program
```

**Manual compilation:**
```bash
bison -d tamim.y
flex tamim.l
gcc tamim.tab.c lex.yy.c -o calculator
./calculator              # Reads input.txt, writes output.txt
```

### File Structure (Final Project)
```
Final Project/
├── tamim.l              # Lexer specification
├── tamim.y              # Parser specification  
├── input.txt            # Sample input expressions
├── makefile             # Build automation
├── output.txt           # Generated output (after execution)
├── lex.yy.c             # Generated lexer (created by flex)
├── tamim.tab.c          # Generated parser (created by bison)
├── tamim.tab.h          # Parser header (created by bison)
└── a.exe                # Executable (created by gcc)
```

---

## 🔬 Laboratory Assignments

### Lab 1: Introduction

**Location:** `Lab_1/intro`

Basic introduction to compiler design concepts and tooling setup.

---

### Lab 2: Longest String Finder

**Location:** `lab_2/labtask.l`

**Objective:** Implement a Flex lexical analyzer that identifies and extracts the longest string from input.

**Features:**
- Pattern matching within quotes (`'...'`)
- String comparison and length tracking
- Output formatting and result reporting

**Usage:**
```bash
flex labtask.l
gcc lex.yy.c -o longest
./longest
# Input: " A quick brown 'fox' jumps 'over' the 'lazy' dog"
# Output: Longest word: 'quick'
```

---

### Lab Assignment: Lexical Analysis of Custom Language

**Location:** `lab assignment/`

**Objective:** Build a lexical analyzer for a custom domain-specific language (DSL) with Bengali-inspired keywords.

**Features:**
- **Keyword Recognition**: Supports custom keywords (`jodi`, `najodi`, `repeatUntil`, `cycle`, `func`)
- **Token Classification**: Identifies operators, keywords, identifiers, comments
- **Comment Handling**: Single-line (`//`) and multi-line (`/* */`) comments
- **Statistics Generation**: Counts and reports:
  - Keywords encountered
  - Variables/identifiers declared
  - Operators used

**Supported Language Elements:**

| Category | Examples |
|----------|----------|
| Data Types | `inti`, `floati`, `doublei`, `booli`, `stringi`, `chari`, `arrayi` |
| Keywords | `jodi` (if), `najodi` (else), `repeatUntil` (while), `cycle` (for), `func` (function) |
| Arithmetic Ops | `add`, `sub`, `mul`, `div`, `mod` |
| Logical Ops | `and`, `or`, `not` |
| Comparison Ops | `eq`, `neq`, `lt`, `le`, `gt`, `ge` |
| Assignment Ops | `assign`, `addassign`, `subassign`, `mulassign`, `divassign` |
| Bitwise Ops | `andbit`, `orbit`, `xorbit`, `notbit`, `shl`, `shr` |
| Increment/Decrement | `inc`, `dec` |

**Sample Input (in.txt):**
```
// Single line comment
inti a;
floati b, c;
add a b;
eq a b;
jodi (a eq b) {
    cycle;
}
```

**Expected Output (out.txt):**
```
Single line comment-> // Single line comment
if statement-> jodi
else statement-> najodi
while statement-> repeatUntil
for statement-> cycle
function statement-> func
hello Tamim!
keyword : 5
variable : 3
Operator : 2
```

**Build Instructions:**
```bash
flex tamim.l
gcc lex.yy.c -o analyzer
./analyzer              # Reads in.txt, writes out.txt
```

---

## 🛠️ Technologies Used

| Tool | Version | Purpose |
|------|---------|---------|
| **Flex** | Latest | Lexical Analyzer Generator |
| **Bison** | Latest | LALR Parser Generator |
| **GCC** | Latest | C Compiler |
| **Make** | Latest | Build Automation |
| **C** | C99/C11 | Implementation Language |

### Platform Support
- ✅ Windows (MinGW/GCC)
- ✅ Linux (GCC)
- ✅ macOS (GCC/Clang)

---

## 📁 Project Structure

```
Compiler-Design/
├── README.md                           # This file
├── Final Project/                      # Main deliverable - Calculator Compiler
│   ├── tamim.l                         # Lexer specification
│   ├── tamim.y                         # Parser/AST specification
│   ├── input.txt                       # Sample input
│   ├── makefile                        # Build rules
│   └── [Generated files during build]
├── lab assignment/                     # Custom language lexer
│   ├── tamim.l                         # DSL lexical analyzer
│   ├── in.txt                          # Sample DSL code
│   └── out.txt                         # Analysis output
├── lab_2/                              # String processing
│   └── labtask.l                       # Longest string finder
└── Lab_1/                              # Introduction
    └── intro                           # Startup materials
```

---

## 🚀 Getting Started

### Prerequisites
```bash
# Windows (with MinGW)
choco install flex bison mingw-w64

# macOS (with Homebrew)
brew install flex bison

# Linux (Debian/Ubuntu)
sudo apt-get install flex bison build-essential

# Linux (Fedora/RHEL)
sudo dnf install flex bison gcc
```

### Verify Installation
```bash
flex --version
bison --version
gcc --version
```

---

## 🔧 Compilation & Execution

### Final Project (Calculator Compiler)

#### Quick Build (Using Make)
```bash
cd "Final Project"
make -f makefile final
```

#### Step-by-Step Compilation
```bash
cd "Final Project"

# 1. Generate parser code
bison -d tamim.y
# Creates: tamim.tab.c, tamim.tab.h

# 2. Generate lexer code
flex tamim.l
# Creates: lex.yy.c

# 3. Compile and link
gcc tamim.tab.c lex.yy.c -o calculator

# 4. Run (ensure input.txt exists in same directory)
./calculator

# 5. View results
cat output.txt
```

#### Cleanup
```bash
make -f makefile clean
```

---

### Lab Assignment (Lexical Analyzer)

```bash
cd "lab assignment"
flex tamim.l
gcc lex.yy.c -o analyzer
./analyzer              # Reads in.txt, writes out.txt
cat out.txt
```

---

### Lab 2 (String Finder)

```bash
cd lab_2
flex labtask.l
gcc lex.yy.c -o finder
./finder
# Then enter: " A quick brown 'fox' jumps 'over' the 'lazy' dog"
```

---

## 📊 Learning Outcomes

Upon completing this project suite, you will understand:

1. **Lexical Analysis**
   - Regular expressions and pattern matching
   - Token classification and extraction
   - Whitespace and comment handling

2. **Syntax Analysis**
   - Context-free grammars (CFG)
   - LALR(1) parsing technique
   - Shift/reduce conflict resolution
   - Operator precedence declaration

3. **Semantic Analysis**
   - Symbol table design and management
   - Abstract syntax tree (AST) concepts
   - Runtime evaluation and type checking
   - Error detection and reporting

4. **Compiler Construction**
   - Multi-phase compilation pipeline
   - Integration of lexer and parser
   - Code generation and optimization
   - Build automation

---

## 📝 Notes & Observations

### Design Decisions

1. **Symbol Table**: Simple array-based implementation (`int sym[26]`) for lowercase variables
   - Sufficient for educational purposes
   - O(1) lookup time
   - Extension: Could implement hash table for production use

2. **Parser Attributes**: Uses single `int` values for expression results
   - Simplifies AST representation
   - Sufficient for integer arithmetic
   - Extension: Could support floating-point or multi-type expressions

3. **Error Handling**: Basic error reporting via `yyerror()`
   - Division by zero detection
   - Unknown character rejection
   - Extension: Could add line number tracking and detailed diagnostics

4. **File I/O**: Hardcoded file paths for batch processing
   - Suitable for automated testing
   - Extension: Could add command-line argument parsing

---

## 🔍 Troubleshooting

| Issue | Solution |
|-------|----------|
| Flex command not found | Install flex: `choco install flex` (Windows) or `brew install flex` (macOS) |
| Bison command not found | Install bison: `choco install bison` (Windows) or `brew install bison` (macOS) |
| GCC compilation error | Ensure `-d` flag used with bison: `bison -d tamim.y` creates header file |
| No output file generated | Check that `input.txt` exists in working directory |
| Division by zero warning | This is handled gracefully; output will be 0 and error message displayed |
| Makefile not recognized | Windows: use `make -f makefile final` (specify filename explicitly) |

---

## 📚 References

- [Flex Documentation](https://westes.github.io/flex/manual/)
- [Bison Manual](https://www.gnu.org/software/bison/manual/)
- [The Dragon Book](https://en.wikipedia.org/wiki/Compilers:_Principles,_Techniques,_and_Tools) - Aho, Lam, Sethi, Ullman
- [Compiler Design: Theory, Analysis, and Generation](https://www.amazon.com/Compiler-Design-Analysis-Generation-Puntambekar/dp/8184319893) - Puntambekar

---

## 👤 Author

**Tamim**

---

## 📄 License

This project is provided for educational purposes as part of a compiler design course.

---

## ✉️ Contact & Support

For questions or clarifications regarding this project, please refer to the course materials or contact your instructor.

---

**Last Updated:** April 2026  
**Project Status:** ✅ Complete & Documented