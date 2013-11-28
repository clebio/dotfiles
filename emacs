(require 'quack)
(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(quack-programs (quote ("scm" "bigloo" "csi" "csi -hygienic" "gosh" "gsi" "gsi ~~/syntax-case.scm -" "guile" "kawa" "mit-scheme" "mred -z" "mzscheme" "mzscheme -il r6rs" "mzscheme -il typed-scheme" "mzscheme -M errortrace" "mzscheme3m" "mzschemecgc" "rs" "scheme" "scheme48" "scsh" "sisc" "stklos" "sxi"))))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )
(autoload 'markdown-mode "~/.emacs.d/markdown-mode/markdown-mode.el" "Major mode for editing Markdown files" t) (setq auto-mode-alist (cons '("\\.md" . markdown-mode) auto-mode-alist))

(load-file "~/.emacs.d/python/epy-init.el")

;; http://kwbeam.com/index.html
(require 'python-mode)

(load-file "/usr/share/emacs/site-lisp/pymacs/pymacs.el")
(require 'pymacs)
;; https://bitbucket.org/agr/ropemacs/src
(pymacs-load "ropemacs" "rope-")
(setq ropemacs-enable-shortcuts nil)

;; http://www.jesshamrick.com/2012/09/18/emacs-as-a-python-ide/
; Use ipython as python interpreter
(setq-default py-shell-name "ipython")
(setq-default py-which-bufname "IPython")
; don't show the startup screen
(setq inhibit-startup-screen t)
; don't show the menu bar
(menu-bar-mode nil)
; number of characters until the fill column
(setq fill-column 70)
