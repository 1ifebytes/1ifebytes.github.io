---
title: "用 Hugo + GitHub Pages 搭建个人博客"
description: "从零开始，10分钟搭建一个免费、快速、好看的个人博客"
date: 2025-04-13
slug: hugo-github-pages-blog
categories:
  - 技术
tags:
  - Hugo
  - GitHub Pages
  - 博客搭建
---

## 为什么选 Hugo？

个人博客的技术选型其实不难想，核心需求就三点：

1. **免费托管** — GitHub Pages 完美解决
2. **写作体验好** — Markdown 就够了
3. **加载够快** — 静态站点，CDN 加速

Hugo 是目前最快的静态站点生成器，构建速度以毫秒计，主题生态也非常丰富。

## 技术栈一览

| 组件 | 选择 | 原因 |
|------|------|------|
| 框架 | Hugo | 速度极快，Go 驱动 |
| 主题 | Stack | 美观，支持深色模式 |
| 托管 | GitHub Pages | 免费，自定义域名 |
| CI/CD | GitHub Actions | 自动构建部署 |

## 核心配置

```toml
baseURL = "https://1ifebytes.github.io"
title = "Lifebytes"
theme = "hugo-theme-stack"
```

## 写作工作流

1. 在 `content/post/` 下新建文件夹
2. 创建 `index.md`，写好 front matter
3. 提交推送到 GitHub
4. Actions 自动构建并部署，几分钟后上线

就这么简单。

## 小结

博客搭建从来不是重点，**持续写作才是**。技术栈选好了，剩下的就交给时间。
