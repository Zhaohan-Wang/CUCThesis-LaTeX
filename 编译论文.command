#!/bin/bash
# 中传毕业论文模板 - 一键编译脚本
# 双击此文件即可在终端中编译 paper.tex

# 切换到脚本所在目录（这样双击时无论从哪里运行都能找到论文）
cd "$(dirname "$0")"

echo "=========================================="
echo "  中传毕业论文模板 - 开始编译"
echo "=========================================="
echo ""

# 完整编译流程：xelatex -> biber -> xelatex -> xelatex
echo "[1/4] 第一次 XeLaTeX 编译..."
xelatex -interaction=nonstopmode paper.tex > /dev/null 2>&1

echo "[2/4] 运行 Biber 处理参考文献..."
biber paper > /dev/null 2>&1

echo "[3/4] 第二次 XeLaTeX 编译..."
xelatex -interaction=nonstopmode paper.tex > /dev/null 2>&1

echo "[4/4] 第三次 XeLaTeX 编译..."
xelatex -interaction=nonstopmode paper.tex 2>&1 | tail -20

echo ""
if [ -f "paper.pdf" ]; then
  echo "=========================================="
  echo "  编译完成！已生成 paper.pdf"
  echo "=========================================="
  # 可选：自动打开 PDF（取消下面一行注释即可）
  # open paper.pdf
else
  echo "编译可能有问题，请查看上方输出。"
fi

echo ""
read -p "按回车键关闭此窗口..."
