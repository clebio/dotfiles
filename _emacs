;; ESS (Emacs Speaks Statistics, for R integration)
;; http://ess.r-project.org/index.php?Section=home
;(require 'ess-site)
;; disable underscore substitution (to ' <- ' )
;(ess-toggle-underscore nil)
(menu-bar-mode -1)

(setq-default abbrev-mode t)

;; Magit
(global-set-key (kbd "C-x g") 'magit-status)
(global-set-key (kbd "C-x M-g") 'magit-dispatch-popup)

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
(setq jedi:complete-on-dot t)
(autoload 'jedi:setup "jedi" nil t)

(require 'python-environment)

(defun previous-buffer-nostar ()
  "previous-buffer, skip *Asterisk* buffers"
  (interactive)
  (previous-buffer)
  (when (string= "*Pymacs*" (buffer-name))
      (previous-buffer))
  (when (string= "*scratch*" (buffer-name))
      (previous-buffer))
  (when (string= "*Messages*" (buffer-name))
      (previous-buffer)))

(require 'flycheck)
(global-flycheck-mode)
(add-hook 'after-init-hook #'global-flycheck-mode)
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
(global-set-key (kbd "M-]") 'previous-buffer)

(defun next-buffer-nostar ()
  "next-buffer, skip *Asterisk* buffers"
  (interactive)
  (next-buffer)
  (when (string= "*Messages*" (buffer-name))
      (next-buffer))
  (when (string= "*Pymacs*" (buffer-name))
      (next-buffer)))
(global-set-key [remap next-buffer] 'next-buffer-nostar)
(global-set-key (kbd "M-[") 'next-buffer)

;(require 'quack)
(autoload 'markdown-mode "~/.emacs.d/markdown-mode/markdown-mode.el" "Major mode for editing Markdown files" t)
(setq auto-mode-alist (cons '("\\.md" . markdown-mode) auto-mode-alist))

;(load "~/.emacs.d/pymacs.el")
;(require 'pymacs)
;(load-file "~/.emacs.d/emacs-for-python/epy-init.el")
(setq skeleton-pair nil)

;; http://kwbeam.com/index.html
;(load-file ".emacs.d/python-mode/python-mode.el")
;(require 'python-mode)

;; https://bitbucket.org/agr/ropemacs/src
;(pymacs-load "ropemacs" "rope-")
(setq ropemacs-enable-shortcuts nil)
(setq ropemacs-local-prefix "C-c C-p")
(setq ropemacs-enable-autoimport 't)

;; http://www.jesshamrick.com/2012/09/18/emacs-as-a-python-ide/
; Use ipython as python interpreter
(setq-default py-shell-name "ipython")
(setq-default py-which-bufname "IPython")
; don't show the startup screen
(setq inhibit-startup-screen t)
; don't show the menu bar
(menu-bar-mode nil)
; number of characters until the fill column
(setq fill-column 79)

(load-file "~/.emacs.d/fill-column-indicator.el")
(define-globalized-minor-mode
 global-fci-mode fci-mode (lambda () (fci-mode 1)))
;(global-fci-mode t)
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

;; don't make me write 'yes' to confirm
(defalias 'yes-or-no-p 'y-or-n-p)
(load-file "~/.emacs.d/quick-yes.el")

;; C-w to kill current buffer
;(global-set-key [(control w)] 'kill-this-buffer)

;; neotree
(add-to-list 'load-path "~/.emacs.d/neotree")
(require 'neotree)
(global-set-key (kbd "C-t") 'neotree-toggle)

;; window navigation
(windmove-default-keybindings)
(global-set-key (kbd "M-h") 'windmove-left)
(global-set-key (kbd "M-l") 'windmove-right)
(global-set-key (kbd "M-k") 'windmove-up)
(global-set-key (kbd "M-j") 'windmove-down)

;; SCM utils
(defun mechanics ()
  (interactive)
  (run-scheme
    "/home/caleb/scmutils/mit-scheme/bin/scheme --library /home/caleb/scmutils/mit-scheme/lib"
  ))

;; paredit
;; http://www.emacswiki.org/ParEdit
;(autoload 'enable-paredit-mode "paredit" "Turn on pseudo-structural editing of Lisp code." t)
;(add-hook 'emacs-lisp-mode-hook       #'enable-paredit-mode)
;(add-hook 'eval-expression-minibuffer-setup-hook #'enable-paredit-mode)
;(add-hook 'ielm-mode-hook             #'enable-paredit-mode)
;(add-hook 'lisp-mode-hook             #'enable-paredit-mode)
;(add-hook 'lisp-interaction-mode-hook #'enable-paredit-mode)
;(add-hook 'scheme-mode-hook           #'enable-paredit-mode)

(defvar electrify-return-match
  "[\]}\)\"]"
  "If this regexp matches the text after the cursor, do an \"electric\"
  return.")

(defun electrify-return-if-match (arg)
  "If the text after the cursor matches `electrify-return-match' then
  open and indent an empty line between the cursor and the text.  Move the
  cursor to the new line."
  (interactive "P")
  (let ((case-fold-search nil))
    (if (looking-at electrify-return-match)
	(save-excursion (newline-and-indent)))
    (newline arg)
    (indent-according-to-mode)))

(global-set-key (kbd "RET") 'electrify-return-if-match)

;; rainbow delimiters (http://www.emacswiki.org/emacs/RainbowDelimiters)
(require 'rainbow-delimiters)
(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)

(defun go-mode-setup ()
    (go-eldoc-setup))
(add-hook 'go-mode-hook 'go-mode-setup)
(require 'auto-complete-config)
(require 'go-autocomplete)
