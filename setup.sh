#!/bin/bash
# ================================================
# Lifebytes Blog 一键初始化脚本
# 运行方式：chmod +x setup.sh && ./setup.sh
# ================================================

set -e

BLOG_DIR=$(pwd)
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

echo ""
echo "🚀 Lifebytes Blog 初始化脚本"
echo "================================"

# ---- 1. 检查 Hugo 是否安装 ----
echo ""
echo "📦 检查 Hugo 安装状态..."
if command -v hugo &>/dev/null; then
  echo -e "${GREEN}✓ Hugo 已安装: $(hugo version | head -1)${NC}"
else
  echo -e "${YELLOW}⚠ Hugo 未安装，正在安装...${NC}"
  if [[ "$OSTYPE" == "darwin"* ]]; then
    if command -v brew &>/dev/null; then
      brew install hugo
    else
      echo -e "${RED}请先安装 Homebrew: https://brew.sh${NC}"
      exit 1
    fi
  elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    sudo apt-get update && sudo apt-get install -y hugo
  else
    echo -e "${RED}请手动安装 Hugo: https://gohugo.io/installation/${NC}"
    exit 1
  fi
  echo -e "${GREEN}✓ Hugo 安装完成${NC}"
fi

# ---- 2. 检查 Git 是否安装 ----
echo ""
echo "📦 检查 Git 安装状态..."
if command -v git &>/dev/null; then
  echo -e "${GREEN}✓ Git 已安装: $(git --version)${NC}"
else
  echo -e "${RED}✗ Git 未安装，请先安装 Git: https://git-scm.com${NC}"
  exit 1
fi

# ---- 3. 初始化 Git 仓库 ----
echo ""
echo "📁 初始化 Git 仓库..."
if [ ! -d ".git" ]; then
  git init
  echo -e "${GREEN}✓ Git 仓库初始化完成${NC}"
else
  echo -e "${GREEN}✓ Git 仓库已存在${NC}"
fi

# ---- 4. 添加 Stack 主题（Git Submodule）----
echo ""
echo "🎨 安装 Stack 主题..."
if [ ! -d "themes/hugo-theme-stack/.git" ]; then
  mkdir -p themes
  git submodule add https://github.com/CaiJimmy/hugo-theme-stack themes/hugo-theme-stack
  echo -e "${GREEN}✓ Stack 主题安装完成${NC}"
else
  echo -e "${GREEN}✓ Stack 主题已存在${NC}"
fi

# ---- 5. 本地预览测试 ----
echo ""
echo "🔍 测试本地构建..."
if hugo --quiet 2>/dev/null; then
  echo -e "${GREEN}✓ 博客构建成功${NC}"
  rm -rf public resources
else
  echo -e "${YELLOW}⚠ 构建有警告，但通常可以正常运行${NC}"
fi

# ---- 6. 提交初始代码 ----
echo ""
echo "💾 提交初始代码到 Git..."
git add .
git commit -m "🎉 Initial blog setup with Hugo + Stack theme" 2>/dev/null || \
  echo -e "${YELLOW}⚠ 没有新内容需要提交${NC}"
echo -e "${GREEN}✓ 代码提交完成${NC}"

# ---- 7. 提示连接 GitHub ----
echo ""
echo "================================"
echo -e "${GREEN}🎉 本地初始化完成！${NC}"
echo ""
echo -e "${YELLOW}接下来请在 GitHub 完成以下步骤：${NC}"
echo ""
echo "  1️⃣  在 GitHub 创建名为 '1ifebytes.github.io' 的仓库"
echo "     👉 https://github.com/new"
echo "     ⚠  仓库名必须完全匹配你的用户名 + .github.io"
echo ""
echo "  2️⃣  将本地代码推送到 GitHub："
echo "     git remote add origin https://github.com/1ifebytes/1ifebytes.github.io.git"
echo "     git branch -M main"
echo "     git push -u origin main"
echo ""
echo "  3️⃣  在 GitHub 仓库设置 Pages："
echo "     Settings → Pages → Source 选择 'GitHub Actions'"
echo ""
echo "  4️⃣  等待 1-2 分钟，访问："
echo -e "     ${GREEN}https://1ifebytes.github.io${NC}"
echo ""
echo "  📝 以后写新文章，只需："
echo "     在 content/post/ 新建文件夹，创建 index.md"
echo "     git add . && git commit -m '新文章' && git push"
echo ""
echo "================================"
echo ""
echo "🔴 想先本地预览？运行："
echo "   hugo server -D"
echo "   然后访问 http://localhost:1313"
echo ""
