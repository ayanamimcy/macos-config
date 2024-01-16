;;; custom-post.el --- user customization file    -*- lexical-binding: t no-byte-compile: t -*-
;;; Commentary:
;;;       Add or change the configurations in custom.el, then restart Emacs.
;;;       Put your own configurations in custom-post.el to override default configurations.
;;; Code:

;; Set org-roam-directory to org/roam
(setq org-roam-directory (file-truename (format "%s/%s" centaur-org-directory "roam")))
;; Disable tool, menu, and scrollbars. Doom is designed to be keyboard-centric,
;; so these are just clutter (the scrollbar also impacts performance). Whats
;; more, the menu bar exposes functionality that Doom doesn't endorse.
;;
;; I am intentionally not calling `menu-bar-mode', `tool-bar-mode', and
;; `scroll-bar-mode' because they do extra and unnecessary work that can be more
;; concisely and efficiently expressed with these six lines:
(push '(menu-bar-lines . 0)   default-frame-alist)
(push '(tool-bar-lines . 0)   default-frame-alist)
(push '(vertical-scroll-bars) default-frame-alist)
;; And set these to nil so users don't have to toggle the modes twice to
;; reactivate them.
(setq menu-bar-mode nil
      tool-bar-mode nil
      scroll-bar-mode nil)

;; install load env var package
(use-package load-env-vars
  :init
  (load-env-vars "~/.env")
  (exec-path-from-shell-initialize))

;; config smart-input-switch
(use-package sis
  :ensure t
  :init
  (defun sis-custom-set-ism-to-jp ()
   ;; set sis-ism-lazyman-config to english and japanese
   (interactive)
   (setq sis-other-source "com.apple.inputmethod.Kotoeri.RomajiTyping.Japanese"))

  (defun sis-custom-set-ism-to-chi ()
   ;; set sis-ism-lazyman-config to english and chinese
   (interactive)
   (setq sis-other-source "com.apple.inputmethod.SCIM.ITABC"))
  ;; enable the /cursor color/ mode
  (sis-global-cursor-color-mode t)
  ;; enable the /respect/ mode
  (sis-global-respect-mode t)
  ;; enable the /context/ mode for all buffers
  (sis-global-context-mode t)
  ;; enable the /inline english/ mode for all buffers
  (sis-global-inline-mode t)
  :config
  ;; For MacOS
  (sis-ism-lazyman-config
   ;; english input method
   "com.apple.keylayout.ABC"
   ;; other langurage input method
   "com.apple.inputmethod.SCIM.ITABC")
  ;;(setq sis-do-set
  ;;      (lambda(source) (start-process "set-input-source" nil "macism" source "50000")))
  )

(provide 'custom-post)
;;; custom-post.el ends here
