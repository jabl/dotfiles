;; First, some problems with emacs<->gnutls interaction
;; https://github.com/nicferrier/elmarmalade/issues/55
;; (if (fboundp 'gnutls-available-p)
;;     (fmakunbound 'gnutls-available-p))
;; (setq tls-program '("gnutls-cli --tofu -p %p %h")
;;       imap-ssl-program '("gnutls-cli --tofu -p %p %s")
;;       smtpmail-stream-type 'starttls
;;       starttls-extra-arguments '("--tofu")
;;       )
;; (setq package-check-signature nil)

;; Setup package repositories
(require 'package)
(setq package-archives '(("gnu" . "https://elpa.gnu.org/packages/")
                         ("melpa" . "https://melpa.org/packages/")
;                         ("melpa-stable" . "https://stable.melpa.org/packages/")
                         ("org" . "http://orgmode.org/elpa/")))
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
(package-initialize)

;; Default dir for extra .el files
(add-to-list 'load-path (expand-file-name "~/.emacs.d/lisp") t)

;; Make sure necessary packages are installed
(setq my-packages
      '(paredit))

;; Iterate on packages and install missing ones
(dolist (pkg my-packages)
  (unless (package-installed-p pkg)
    (package-install pkg)))

;; Misc
(require 'generic-x)
(column-number-mode t)
(setq inhibit-splash-screen t)
(show-paren-mode t)
(setq require-final-newline t)

;; Tabs vs spaces (spaces, of course!)
(setq c-basic-offset 4)
(setq-default indent-tabs-mode nil)

; uniquify not default on 24.3 (Ubuntu 14.04)
(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward-angle-brackets)

;; Mac OS X

;; To reduce Emacs pinky, set cmd keys to control in System
;; Preferences -> Keyboard -> modifier keys.  Then the problem is that
;; ALT (option key in mac-jargon) is also needed to type characters
;; like {} on European keyboards. For this, map the left option key
;; to meta, and leave the right as-is. Note: This works only for the
;; GUI Emacs. In the terminal, the terminal.app catches the alt keys
;; before Emacs gets to interpret them.
(when (eq system-type 'darwin)
  (setq mac-option-modifier 'meta
   mac-right-option-modifier nil))


;; Various file formats..
; Markdown-mode (not automatic unless installed via elpa)
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))


;; Programming stuff

;; Lisp

;; paredit
(autoload 'enable-paredit-mode "paredit" "Turn on pseudo-structural editing of Lisp code." t)
(add-hook 'emacs-lisp-mode-hook       #'enable-paredit-mode)
(add-hook 'eval-expression-minibuffer-setup-hook #'enable-paredit-mode)
(add-hook 'ielm-mode-hook             #'enable-paredit-mode)
(add-hook 'lisp-mode-hook             #'enable-paredit-mode)
(add-hook 'lisp-interaction-mode-hook #'enable-paredit-mode)
(add-hook 'scheme-mode-hook           #'enable-paredit-mode)

;; slime
;(add-hook 'slime-repl-mode-hook #'enable-paredit-mode)
;(add-hook 'slime-mode-hook #'enable-paredit-mode)
;; Stop SLIME's REPL from grabbing DEL,
;; which is annoying when backspacing over a '('
;; (defun override-slime-repl-bindings-with-paredit ()
;;   (paredit-mode +1)
;;   (define-key slime-repl-mode-map
;;     (read-kbd-macro paredit-backward-delete-key) nil))
;; (add-hook 'slime-repl-mode-hook 'override-slime-repl-bindings-with-paredit)

;; (setq inferior-lisp-program (executable-find "sbcl"))

;; ;; (add-hook 'slime-repl-mode-hook #'company-mode)
;; (require 'slime-autoloads)
;; (slime-setup '(slime-fancy slime-company))

;; Makefiles needs tabs
;(add-hook 'makefile-mode-hook (lambda () (setq-local indent-line-function 'my-makefile-indent-line)))
;(add-hook 'makefile-mode-hook (lambda () (setq-local indent-tabs-mode t)))


;; C
(setq c-default-style "linux")

; Use GNU style for C code when contributing to GCC
(defun maybe-gnu-style ()
  (when (and buffer-file-name
             (string-match "gfortran" buffer-file-name))
    (c-set-style "gnu")
    (setq indent-tabs-mode t)))

(add-hook 'c-mode-hook 'maybe-gnu-style)

;; Fortran
; Spaces for Fortran
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

;; https://www.emacswiki.org/emacs/DeadKeys
(require 'iso-transl)
