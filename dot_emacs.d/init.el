;;; init.el --- initialization file for GNU Emacs 29  -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:

(setq user-full-name "Keisuke Nishida")
(setq user-mail-address "keisuke.nishida@gmail.com")

;;; Language

(set-language-environment "Japanese")
(prefer-coding-system 'utf-8)

(set-face-attribute 'default nil :family "monaco" :height 120)
(set-fontset-font (frame-parameter nil 'font)
                  'japanese-jisx0208
                  '("Hiragino Kaku Gothic ProN" . "iso10646-1"))
(set-fontset-font (frame-parameter nil 'font)
                  'japanese-jisx0212
                  '("Hiragino Kaku Gothic ProN" . "iso10646-1"))
(set-fontset-font (frame-parameter nil 'font)
                  'mule-unicode-0100-24ff
                  '("monaco" . "iso10646-1"))

(add-to-list 'face-font-rescale-alist
             '(".*Hiragino Kaku Gothic ProN.*" . 1.2))

;;; Theme

(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(load custom-file)

(setq default-frame-alist '((font . "0xProto Nerd Font")))
(setq initial-frame-alist
      '((width . 100)
        (height . 67)
        (ns-appearance . dark)
        (ns-transparent-titlebar . t)
        (vertical-scroll-bars . nil)
        (internal-border-width . 0)))

(add-to-list 'custom-theme-load-path
             (expand-file-name "themes/emacs-color-theme-solarized" user-emacs-directory))
(load-theme 'solarized t)

;;; Customize

(setq default-directory "~/")
(setq inhibit-startup-message t)
(setq electric-indent-mode nil)

(put 'upcase-region 'disabled nil)
(put 'narrow-to-region 'disabled nil)

(setq ns-command-modifier (quote meta))
(setq ns-alternate-modifier (quote meta))

(setq abbrev-file-name (expand-file-name "abbrev.el" user-emacs-directory))
(quietly-read-abbrev-file)

(setq backup-directory-alist '(("" . "/tmp/emacs-backup")))

;;; Global key bindings

(global-set-key (kbd "C-h") 'backward-delete-char-untabify)
(global-set-key (kbd "C-S-k") 'bury-buffer)
(global-set-key (kbd "C-,") 'next-error)
(global-set-key (kbd "C-.") "\e^\C-n")
(global-set-key (kbd "C-'") 'ispell-word)
(global-set-key (kbd "C->") 'string-rectangle)
(global-set-key (kbd "C-<") "\C-p\C-f\C-xrd\C-n")

(global-set-key (kbd "C-x C-h") 'help-command)
(global-set-key (kbd "C-x C-j") 'skk-mode)
(global-set-key (kbd "C-x C-l") "\C-xb")
(global-set-key (kbd "C-x C-o") 'other-window)
(global-set-key (kbd "C-x C-d")
  (lambda () (interactive) (dired default-directory)))
(global-set-key (kbd "C-x C-u")
  (lambda () (interactive)
    (upcase-region (save-excursion (forward-symbol -1) (point)) (point))))
(global-set-key (kbd "C-x e") 'edit-picture)
(global-set-key (kbd "C-x g") 'goto-line)
(global-set-key (kbd "C-x u") 'revert-buffer)
(global-set-key (kbd "C-x %") 'query-replace-regexp)
(global-set-key (kbd "C-x a e") 'edit-abbrevs)
(global-set-key (kbd "C-x a u") 'unexpand-abbrev)

(global-set-key (kbd "C-M-q") 'fill-paragraph)
(global-set-key (kbd "M-m") 'call-last-kbd-macro)
(global-set-key (kbd "M-n") 'forward-page)
(global-set-key (kbd "M-p") 'backward-page)
(global-set-key (kbd "M-]") 'end-of-buffer)
(global-set-key (kbd "M-[") 'beginning-of-buffer)

(define-key help-map (kbd "C-a") 'apropos)
(define-key help-map (kbd "C-f") 'find-function)
(define-key help-map (kbd "C-k") 'find-function-on-key)
(define-key help-map (kbd "C-v") 'find-variable)

(define-key minibuffer-local-map (kbd "C-p") 'previous-history-element)
(define-key minibuffer-local-map (kbd "C-n") 'next-history-element)
(define-key minibuffer-local-map (kbd "C-u") "\C-a\C-k")

(define-key mode-specific-map "," "\C-xe\C-c.")
(define-key mode-specific-map "b" "\C-xb*scratch*")
(define-key mode-specific-map "e" "\C-x\C-f/~/.local/share/chezmoi/")
(define-key mode-specific-map "g" 'grep-find)
(define-key mode-specific-map "m" 'compile)
(define-key mode-specific-map "s" 'shell)
(define-key mode-specific-map "u" 'find-file-at-point)

(defalias 'scroll-up-some-lines "\C-u2\C-v")
(defalias 'scroll-down-some-lines "\C-u2\ev")

;;; package

(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(exec-path-from-shell-initialize)

;;; magit

(use-package magit
  :defer t
  :init
  (bind-keys :map mode-specific-map
             ("c" . magit-status))
  :config
  (bind-keys :map magit-mode-map
             ("M-1" . nil)
             ("M-2" . nil)
             ("M-3" . nil)
             ("M-4" . nil)))

;;; view

(use-package view
  :defer t
  :config
  (bind-keys :map view-mode-map
             ("j" . scroll-up-some-lines)
             ("k" . scroll-down-some-lines)))

;;; local

(load (expand-file-name "local.el" user-emacs-directory))

;;; init.el ends here
