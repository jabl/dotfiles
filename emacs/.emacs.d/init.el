;; Setup package repositories
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)
(add-to-list 'package-archives
	     '("org" . "http://orgmode.org/elpa/") t)
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
(package-initialize)

;; Default dir for extra .el files
(add-to-list 'load-path (expand-file-name "~/.emacs.d/lisp") t)

;; Misc
(require 'generic-x)
(column-number-mode t)
(setq inhibit-splash-screen t)
(show-paren-mode t)
(setq require-final-newline t)

; uniquify not default on 24.3 (Ubuntu 14.04)
(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward-angle-brackets)

;; Mac OS X
;; This makes the cmd key meta, and makes typing {} work
;; (alt-shift-8/9)
(when (eq system-type 'darwin)
  (setq mac-command-modifier 'meta
	mac-option-modifier nil)
  )

;; Various file formats..
; Markdown-mode (not automatic unless installed via elpa)
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))


;; Programming stuff

;; C
(setq c-default-style "linux")

; Use GNU style for C code when contributing to GCC
(defun maybe-gnu-style ()
  (when (and buffer-file-name
             (string-match "gfortran" buffer-file-name))
    (c-set-style "gnu")))

(add-hook 'c-mode-hook 'maybe-gnu-style)

;; Fortran
; Use tabs by default, spaces for Fortran
(defun my-tabs-indent-setup ()
  (setq indent-tabs-mode nil))

(add-hook 'F90-mode-hook 'my-tabs-indent-setup)

;; Rust setup
(add-hook 'rust-mode-hook 'cargo-minor-mode)

(setq racer-cmd "~/.cargo/bin/racer") ;; Rustup binaries PATH
(setq racer-rust-src-path "~/Documents/rust/rust/src") ;; Rust source code PATH

(add-hook 'rust-mode-hook #'racer-mode)
(add-hook 'racer-mode-hook #'eldoc-mode)
(add-hook 'racer-mode-hook #'company-mode)
(add-hook 'flycheck-mode-hook #'flycheck-rust-setup)


;; UTF-8
;; Is this actually necessary on emacs >=24 anymore?
(setq locale-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(prefer-coding-system 'utf-8)
(set-language-environment 'UTF-8)
