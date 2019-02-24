;; ESS (Emacs Speaks Statistics, for R integration)
;; http://ess.r-project.org/index.php?Section=home
;(require 'ess-site)
;; disable underscore substitution (to ' <- ' )
;(ess-toggle-underscore nil)
(setq-default abbrev-mode t)
(setenv "LC_CTYPE" "en_US.UTF-8")

;; Set the PYTHONPATH based on a virtualenv (maybe?)
(setenv "PYTHONPATH" (shell-command-to-string "find ${VIRTUAL_ENV} -name 'site-packages' | xargs echo -n"))

(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
;;(when (memq window-system '(mac ns))
;;  (exec-path-from-shell-initialize))
(package-initialize)

(elpy-enable)
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)
(package-initialize)


;; Standard Jedi.el setting
;(add-hook 'python-mode-hook 'jedi:setup)
;(setq jedi:complete-on-dot t)
(require 'python-environment)
; use IPython
(setq python-shell-interpreter "ipython")
(setq-default py-which-bufname "IPython")

; switch to the interpreter after executing code
(setq py-shell-switch-buffers-on-execute-p t)
(setq py-switch-buffers-on-execute-p t)
(setq py-smart-indentation t)

(setq ropemacs-enable-shortcuts nil)
(setq ropemacs-local-prefix "C-c C-p")
(setq ropemacs-enable-autoimport 't)
;; https://bitbucket.org/agr/ropemacs/src
;(pymacs-load "ropemacs" "rope-")
(setq ropemacs-enable-shortcuts nil)
(setq ropemacs-local-prefix "C-c C-p")
(setq ropemacs-enable-autoimport 't)
;; activate minor whitespace mode when in python mode
(add-hook 'python-mode-hook 'whitespace-mode)
(global-flycheck-mode)

(setq-default indent-tabs-mode nil)
(setq tab-width 4)

;; Ansible
;; https://github.com/k1LoW/emacs-ansible
;; https://github.com/lunaryorn/ansible-doc.el
(add-hook 'yaml-mode-hook '(lambda () (ansible 1)))
(add-hook 'yaml-mode-hook #'ansible-doc-mode)

(set-input-method 'latin-9-prefix)
(global-set-key (kbd "C-x C-l") (lambda () (interactive) (toggle-input-method 'greek)))

;; Vagrant key-bindings
(global-set-key (kbd "C-x v s") 'vagrant-status)
(global-set-key (kbd "C-x v p") 'vagrant-provision)
(global-set-key (kbd "C-x v u") 'vagrant-up)
(global-set-key (kbd "C-x v h") 'vagrant-halt)
(global-set-key (kbd "C-x v r") 'vagrant-reload)
(global-set-key (kbd "C-x v D") 'vagrant-destroy)
(global-set-key (kbd "C-x v t") 'vagrant-tramp-term)

;; Magit (http://magit.vc/)
(global-set-key (kbd "C-x g") 'magit-status)
(global-set-key (kbd "C-x M-g") 'magit-dispatch-popup)
(setq magit-diff-paint-whitespace-lines t)
(setq magit-diff-highlight-trailing t)

;; Define new 'next/previous-buffer' commands that skip the
;; *Asterisk* buffers

(defun previous-buffer-nostar ()
  "previous-buffer, skip *Asterisk* buffers"
  (interactive)
  (previous-buffer)
  (when (string= "*Pymacs*" (buffer-name))
      (previous-buffer))
  (when (string= "*Messages*" (buffer-name))
      (previous-buffer)))

(global-set-key [remap previous-buffer] 'previous-buffer-nostar)
(global-set-key (kbd "M-[") 'previous-buffer)

(require 'virtualenvwrapper)
(venv-initialize-interactive-shells) ;; if you want interactive shell support
(venv-initialize-eshell) ;; if you want eshell support
(setq venv-location "/home/caleb/.virtualenvs/")

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
;(autoload 'markdown-mode "~/.emacs.d/markdown-mode/markdown-mode.el" "Major mode for editing Markdown files" t)
(setq auto-mode-alist (cons '("\\.md" . markdown-mode) auto-mode-alist))
;; brew install pandoc
(setq markdown-command "/usr/local/bin/pandoc")
(setq skeleton-pair nil)

;; http://www.jesshamrick.com/2012/09/18/emacs-as-a-python-ide/
; don't show the startup screen
(setq inhibit-startup-screen t)
; don't show the menu bar
(menu-bar-mode nil)

(load-file "~/.emacs.d/fill-column-indicator.el")
;(define-globalized-minor-mode
; global-fci-mode fci-mode (lambda () (fci-mode 1)))
;(global-fci-mode t)
;(setq fci-rule-width 1)
;(setq fci-rule-color "lightgrey")
;(setq fci-rule-character-color "lightgrey")
;(setq fci-rule-character ?|)

(show-paren-mode 1) ; turn on paren match highlighting
(setq show-paren-style 'expression) ; highlight entire bracket expression
(column-number-mode 1) ; show cursor's column
(global-visual-line-mode 1) ; 1 for on, 0 for off.

;; Reverse colors for the border to have nicer line
(set-face-inverse-video-p 'vertical-border nil)
(set-face-background 'vertical-border (face-background 'default))

;; Set symbol for the border
; https://www.reddit.com/r/emacs/comments/3u0d0u/how_do_i_make_the_vertical_window_divider_more/cxbth2e
(set-face-background 'vertical-border "gray")
(set-face-foreground 'vertical-border (face-background 'vertical-border))

(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)
(setq-default word-wrap t)

;http://ruslanspivak.com/2010/09/27/keep-track-of-whitespaces-and-column-80-overflow/
;; nuke trailing whitespaces when writing to a file
(add-hook 'write-file-hooks 'delete-trailing-whitespace)

;; display only tails of lines longer than X columns, tabs and
;; trailing whitespaces
(setq whitespace-line-column 79
      whitespace-style '(tabs trailing lines-tail))

;(global-set-key (kbd "M-p") 'flycheck-previous-error)
;(global-set-key (kbd "M-n") 'flycheck-next-error)
(global-set-key (kbd "M-p") 'flymake-goto-prev-error)
(global-set-key (kbd "M-n") 'flymake-goto-next-error)

;; don't make me write 'yes' to confirm
(defalias 'yes-or-no-p 'y-or-n-p)
(load-file "~/.emacs.d/quick-yes.el")

;; M-w to kill current buffer
(global-set-key (kbd "M-/") 'kill-this-buffer)

;; neotree
(add-to-list 'load-path "~/.emacs.d/neotree")
(require 'neotree)
(global-set-key (kbd "C-x t") 'neotree-toggle)

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

; don't show the startup screen
(setq inhibit-startup-screen t)
; don't show the tool bar
(require 'tool-bar)
(tool-bar-mode nil)
; number of characters until the fill column
;(setq fill-column 80)

; column indicator/marker
;(require 'column-marker)

(require 'auto-complete)
(add-to-list 'auto-mode-alist '("\\.j2\\'" . jinja2-mode))

;; easy keys to split window. Key based on ErgoEmacs keybinding
(global-set-key (kbd "M-2") 'delete-other-windows) ; expand current pane
(global-set-key (kbd "M-4") 'split-window-horizontally) ; split pane top/bottom
(global-set-key (kbd "M-5") 'split-window-vertically)
(global-set-key (kbd "M-3") 'delete-window) ; close current pane
(global-set-key (kbd "M-s") 'other-window) ; cursor to other pane

;; SQL mode for Cassandra's CQL
(add-to-list 'auto-mode-alist '("\\.cql\\'" . sql-mode))

;; auto-java-complete
;(add-to-list 'load-path "~/.emacs.d/auto-java-complete/")
;(require 'ajc-java-complete-config)
;(add-hook 'java-mode-hook 'ajc-java-complete-mode)
;(add-hook 'find-file-hook 'ajc-4-jsp-find-file-hook)

;; search word at cursor
;; http://www.emacswiki.org/emacs/SearchAtPoint
(global-set-key (kbd "C-*") 'evil-search-symbol-forward)
(global-set-key (kbd "C-#") 'evil-search-symbol-backward)

(add-hook 'java-mode-hook (lambda ()
                            (setq c-basic-offset 4
                                  tab-width 4
                                  indent-tabs-mode nil)))
(defun jdee-custom-configs ()
  (local-set-key (kbd "C-c m") 'jdee-make)
  )

;; add to hook
(add-hook 'jdee-mode-hook 'jdee-custom-configs)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(jdee-compiler (quote ("javac")))
 '(jdee-global-classpath (quote ("." "~/dev/junit.jar" "~/dev/learning_java")))
 '(package-selected-packages
   (quote
    (diminish ivy discover yafolding powershell company-terraform flycheck-color-mode-line flycheck-demjsonlint flycheck-golangci-lint flycheck-gometalinter flycheck-gradle jedi-direx flycheck-pycheckers osx-clipboard go-guru gotest go-playground go-imports omnisharp use-package zenburn-theme yari yaml-mode volatile-highlights virtualenvwrapper vagrant-tramp vagrant solarized-theme scss-mode sass-mode rainbow-mode rainbow-delimiters pytest pylint pyimport pyfmt projectile paredit neotree mouse+ markdown-mode magit jinja2-mode jdee javaimp javadoc-lookup java-snippets java-imports inf-ruby haskell-mode groovy-mode go-autocomplete gist flycheck-pyflakes fill-column-indicator expand-region ensime elpy dockerfile-mode docker django-mode deft column-marker coffee-mode clojure-mode auctex ansible-doc ansible go-mode))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(setq jdee-server-dir "~/.emacs.d")

(require 'rainbow-delimiters)
(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)

(global-set-key (kbd "M-e") 'electric-indent-mode)

(put 'upcase-region 'disabled nil)
(global-set-key (kbd "M-u") 'upcase-region)

;; Scala
(require 'sbt-mode)

(defun paste-to-osx (text &optional push)
  (interactive)
  (let ((process-connection-type nil))
    (let ((proc (start-process "pbcopy" "*Messages*" "pbcopy")))
      (process-send-string proc text)
      (process-send-eof proc))))


;; golang
(setq interprogram-cut-function 'paste-to-osx)
;;(setq interprogram-paste-function 'copy-from-osx)

(defun set-exec-path-from-shell-PATH ()
  (let ((path-from-shell (replace-regexp-in-string
                          "[ \t\n]*$"
                          ""
                          (shell-command-to-string "$SHELL --login -i -c 'echo $PATH'"))))
    (setenv "PATH" path-from-shell)
    (setq eshell-path-env path-from-shell) ; for eshell users
    (setq exec-path (split-string path-from-shell path-separator))))

(when window-system (set-exec-path-from-shell-PATH))
(setenv "GOPATH" "/Users/caleb/go")

(add-to-list 'exec-path "/Users/tleyden/Development/gocode/bin")

(defun auto-complete-for-go ()
  (auto-complete-mode 1))
(add-hook 'go-mode-hook 'auto-complete-for-go)

(with-eval-after-load 'go-mode
   (require 'go-autocomplete))

;; Define function to call when go-mode loads
(defun my-go-mode-hook ()
  (add-hook 'before-save-hook 'gofmt-before-save) ; gofmt before every save
  (setq gofmt-command "goimports")                ; gofmt uses invokes goimports
  (if (not (string-match "go" compile-command))   ; set compile command default
      (set (make-local-variable 'compile-command)
           "go build -v && go test -v"))

  ;; guru settings
  (go-guru-hl-identifier-mode)                    ; highlight identifiers

  ;; Key bindings specific to go-mode
  (local-set-key (kbd "M-.") 'godef-jump)         ; Go to definition
  (local-set-key (kbd "M-*") 'pop-tag-mark)       ; Return from whence you came
  (local-set-key (kbd "M-p") 'compile)            ; Invoke compiler
  (local-set-key (kbd "M-P") 'recompile)          ; Redo most recent compile cmd
  (local-set-key (kbd "M-]") 'next-error)         ; Go to next error (or msg)
  (local-set-key (kbd "M-[") 'previous-error)     ; Go to previous error or msg

  ;; Misc go stuff
  (auto-complete-mode 1))                         ; Enable auto-complete mode

;; Connect go-mode-hook with the function we just defined
(add-hook 'go-mode-hook 'my-go-mode-hook)

(require 'company-terraform)
(company-terraform-init)
(add-hook 'after-init-hook 'global-company-mode)

;; Ensure the go specific autocomplete is active in go-mode.
(with-eval-after-load 'go-mode
   (require 'go-autocomplete)
)
(global-set-key (kbd "M-g p") 'go-playground)
(global-set-key (kbd "M-p") 'go-playground-exec)
(global-set-key (kbd "M-=") "\C-[xalign-regexp\C-m=\C-m")
(osx-clipboard-mode +1)
; (defadvice align-regexp (around align-regexp-with-spaces)
;   "Never use tabs for alignment."
; )
;(ad-activate 'align-regexp)

(global-set-key (kbd "M-=") "\C-[xalign-regexp\C-m=\C-m")
(global-set-key (kbd "M-\\") 'comment-region)
(global-set-key (kbd "M-|") 'uncomment-region)

;; https://www.emacswiki.org/emacs/BackupDirectory
(setq backup-directory-alist
          `((".*" . ,temporary-file-directory)))
    (setq auto-save-file-name-transforms
          `((".*" ,temporary-file-directory t)))

(message "Deleting old backup files...")
(let ((week (* 60 60 24 7))
      (current (float-time (current-time))))
  (dolist (file (directory-files temporary-file-directory t))
    (when (and (backup-file-name-p file)
               (> (- current (float-time (nth 5 (file-attributes file))))
                  week))
      (message "%s" file)
      (delete-file file))))

(require 'company-terraform)
(company-terraform-init)
(add-hook 'after-init-hook 'global-company-mode)

(define-skeleton tf-var
  "Insert a terraform variable with defaults"
  "Insert terraform variable named: "
  "variable \"" str "\" {\n"
  "  description = \""   "\"\n"
  "  default = \"\"\n"
  "  type = \"\"\n"
  "}\n")
(add-hook 'terraform-mode-hook '(lambda () (local-set-key (kbd "C-c v") 'tf-var)))

(global-set-key (kbd "M-/") (kbd "\C-x k\C-m"))

(require 'discover)
(global-discover-mode 1)
(global-set-key (kbd "C-c w") 'yafolding-discover)
(define-key yafolding-mode-map (kbd "C-c C-f") 'yafolding-toggle-element)

(setq which-key-mode 1)
;(ivy-mode 1)

(provide 'emacs)
;;; emacs ends here
