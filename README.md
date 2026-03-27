# 📐 Jord – High-Performance Math Library (C++17 / C++20 Modules)

A lightweight, high-performance math library for C++ designed for **games, graphics, simulations, and other performance-critical applications**.  
Supports **SIMD acceleration** and flexible usage with either **C++17 headers** or **C++20 modules**.

---

## 🚀 Features

- SIMD-accelerated math operations  
  - **x86:** SSE2 / SSE4 / AVX  
  - **ARM:** NEON (where available)  
- 2D, 3D, and 4D **vector types** (`Vec2`, `Vec3`, `Vec4`)  
- Matrix operations (extendable)  
- Optional **header-only design**  
- Supports **C++17** (traditional includes) and **C++20 modules**  
- Minimal dependencies, fully self-contained  

---

## ⚙️ Requirements

- **C++17** or later  
- Compiler with SIMD support:
  - **x86:** GCC, Clang, MSVC with SSE2+  
  - **ARM:** Clang or GCC with NEON support  
- CPU supporting at least **SSE2** (x86) or **NEON** (ARM)  

---

## 🧩 Installation

1. Clone the repository:

```bash
git clone --recurse-submodules https://github.com/yourname/Jord.git