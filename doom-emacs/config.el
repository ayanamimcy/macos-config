;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "chenyangm"
      user-mail-address "ayanamimcy@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-unicode-font' -- for unicode glyphs
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!
(setq doom-font (font-spec :family "Menlo" :size 13 :weight 'semi-light)
      doom-unicode-font (font-spec :family "monospace"))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
;;(setq doom-theme 'doom-one)
(setq doom-theme 'doom-solarized-light)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/Documents/org/")


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;; 配置eglot的javahook
(use-package! eglot-java
    :hook (java-mode . eglot-java-mode))

;; org模式相关的配置信息
(use-package! org
  :init
  (add-hook 'org-mode-hook #'valign-mode))

;; org-roam相关的配置
(use-package! org-roam
  :after org
  :config
  ;; 配置org-roam的性能到最高
  (setq org-roam-db-gc-threshold most-positive-fixnum)
  ;; 自动同步数据库
  (org-roam-db-autosync-mode))

;; org-roam-ui 相关的配置
(use-package! websocket
    :after org-roam)

(use-package! org-roam-ui
    :after org-roam ;; or :after org
;;         normally we'd recommend hooking orui after org-roam, but since org-roam does not have
;;         a hookable mode anymore, you're advised to pick something yourself
;;         if you don't care about startup time, use
;;  :hook (after-init . org-roam-ui-mode)
    :config
    (setq org-roam-ui-sync-theme t
          org-roam-ui-follow t
          org-roam-ui-update-on-save t
          org-roam-ui-open-on-start t))

;; smart-input-switch相关的配置信息
(use-package! sis
  :init

  (defun sis-custom-set-ism-to-jp ()
    ;; set sis-ism-lazyman-config to english and japanese
    (interactive)
    (setq sis-other-source "com.apple.inputmethod.Kotoeri.RomajiTyping.Japanese"))

  (defun sis-custom-set-ism-to-chi ()
    ;; set sis-ism-lazyman-config to english and chinese
    (interactive)
    (setq sis-other-source "com.apple.inputmethod.SCIM.ITABC"))

  :config
  ;; For MacOS
  (sis-ism-lazyman-config
       ;; english input method
       "com.apple.keylayout.ABC"
       ;; other langurage input method
       "com.apple.inputmethod.SCIM.ITABC")
  (setq sis-do-set
      (lambda(source) (start-process "set-input-source" nil "macism" source "50000")))
  ;; enable the /cursor color/ mode
  ;;(sis-global-cursor-color-mode t)
  ;; enable the /respect/ mode
  (sis-global-respect-mode t)
  ;; enable the /context/ mode for all buffers
  (sis-global-context-mode t)
  ;; enable the /inline english/ mode for all buffers
  (sis-global-inline-mode t))

;;配置bingai相关的配置信息
(use-package! aichat
  :config
  ;;配置bingai的cookie信息
  (setq aichat-bingai-cookies-file "~/.config/bingcookie.json")
  (setq aichat-http-backend 'url)
  (setq aichat-bingai-conversation-style 'creative)
  ;;配置bingai的创建链接的信息
  ;;(setq aichat-bingai--create-conversation-url "https://www.bing.com/turing/conversation/create")
  )


;;(add-hook! 'java-mode-hook 'eglot-java-mode)
;; 优化中文输入速度
(setq inhibit-compacting-font-caches t)
;; 减小doomemacs输入快捷键的延迟
(setq which-key-idle-delay 0.2)
(setq which-key-idle-secondary-delay 0.01)
