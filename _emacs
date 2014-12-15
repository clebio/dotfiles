;; ESS (Emacs Speaks Statistics, for R integration)
;; http://ess.r-project.org/index.php?Section=home
;(require 'ess-site)
;; disable underscore substitution (to ' <- ' )
;(ess-toggle-underscore nil)
(menu-bar-mode -1)

;; Define new 'next/previous-buffer' commands that skip the
;; *Asterisk* buffers

(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
(package-initialize)
(add-hook 'python-mode-hook 'jedi:setup)
(require 'python-environment)

(defun previous-buffer-nostar ()
  "previous-buffer, skip *Asterisk* buffers"
  (interactive)
  (previous-buffer)
  (when (string= "*Pymacs*" (buffer-name))
      (previous-buffer))
  (when (string= "*Messages*" (buffer-name))
      (previous-buffer)))


(require 'virtualenvwrapper)
(venv-initialize-interactive-shells) ;; if you want interactive shell support
(venv-initialize-eshell) ;; if you want eshell support
(setq venv-location "/home/caleb/.virtualenvs/")

; use IPython
(setq python-shell-interpreter "ipython")

; switch to the interpreter after executing code
(setq py-shell-switch-buffers-on-execute-p t)
(setq py-switch-buffers-on-execute-p t)
(setq py-smart-indentation t)

(global-set-key [remap previous-buffer] 'previous-buffer-nostar)
(global-set-key (kbd "M-[") 'previous-buffer)

(defun next-buffer-nostar ()
  "next-buffer, skip *Asterisk* buffers"
  (interactive)
  (next-buffer)
  (when (string= "*Messages*" (buffer-name))
      (next-buffer))
  (when (string= "*Pymacs*" (buffer-name))
      (next-buffer)))
(global-set-key [remap next-buffer] 'next-buffer-nostar)
(global-set-key (kbd "M-]") 'next-buffer)

;(require 'quack)
(autoload 'markdown-mode "~/.emacs.d/markdown-mode/markdown-mode.el" "Major mode for editing Markdown files" t)
(setq auto-mode-alist (cons '("\\.md" . markdown-mode) auto-mode-alist))

(load "~/.emacs.d/pymacs.el")
(require 'pymacs)
;(load-file "~/.emacs.d/emacs-for-python/epy-init.el")
(setq skeleton-pair nil)

;; http://kwbeam.com/index.html
;(load-file ".emacs.d/python-mode/python-mode.el")
;(require 'python-mode)

;; https://bitbucket.org/agr/ropeacs/src
;(pymacs-load "ropemacs" "rope-")
;(setq ropemacs-enable-shortcuts nil)
;(setq ropemacs-local-prefix "C-c C-p")
;(setq ropemacs-enable-autoimport 't)

;; http://www.jesshamrick.com/2012/09/18/emacs-as-a-python-ide/
; Use ipython as python interpreter
(setq-default py-shell-name "ipython")
(setq-default py-which-bufname "IPython")
; don't show the startup screen
(setq inhibit-startup-screen t)
; don't show the menu bar
(menu-bar-mode nil)
; number of characters until the fill column
(setq fill-column 80)

(load-file "~/.emacs.d/fill-column-indicator.el")
(define-globalized-minor-mode
 global-fci-mode fci-mode (lambda () (fci-mode 1)))
(global-fci-mode t)
(show-paren-mode 1) ; turn on paren match highlighting
(setq show-paren-style 'expression) ; highlight entire bracket expression
(column-number-mode 1) ; show cursor's column
(global-visual-line-mode 1) ; 1 for on, 0 for off.

(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)
(setq-default word-wrap t)

;http://ruslanspivak.com/2010/09/27/keep-track-of-whitespaces-and-column-80-overflow/
;; nuke trailing whitespaces when writing to a file
(add-hook 'write-file-hooks 'delete-trailing-whitespace)

;; display only tails of lines longer than 80 columns, tabs and
;; trailing whitespaces
(setq whitespace-line-column 80
      whitespace-style '(tabs trailing lines-tail))

;; activate minor whitespace mode when in python mode
(add-hook 'python-mode-hook 'whitespace-mode)

(require 'neotree)
(global-set-key (kbd "C-t") 'neotree-toggle)

(load "~/.emacs.d/quick-yes.el")

(global-set-key (kbd "M-j") 'split-window-horizontally)
(global-set-key (kbd "M-h") 'split-window-vertically)
(global-set-key (kbd "M-o") 'other-window)

(global-set-key (kbd "M-g") 'goto-line)
