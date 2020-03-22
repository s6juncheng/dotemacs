;; Main emacs config
;;
;; author: avsec 

;; load-your own packages and package-management functions

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(setq load-path (cons "~/.emacs.d/mylisp" load-path))
(load "~/.emacs.d/dot-emacs-config/package-management.el")

(load "~/.emacs.d/dot-emacs-config/elisp-functions.el")


;; TODO - make a function that I can just specify file name without load ...
;; (load "~/.emacs.d/dot-emacs-config/package-management.el")

;; install required packages
(install-package 'magit
		 'tabbar
		 'openwith 
		 'outline-magic
		 'color-theme-modern
		 'with-editor
		 'xterm-color
		 'yasnippet
		 ;; 'highlight-parentheses
		 ;; 'shell-command
		 ;; 'redo+   ;; doesn't work properly ... use lisp/redo.el instead
		 )
;; don't use yasnippet in a global mode
(yas-global-mode 0)

;; (setq gnuserv-frame (selected-frame))
;; start emacs server (if there is non running)
(require 'server)
(or (server-running-p)
    (server-start))

;; source .bashrc
(defun set-exec-path-from-shell-PATH ()
  (let ((path-from-shell (replace-regexp-in-string
                          "[ \t\n]*$"
                          ""
                          (shell-command-to-string "$SHELL --login -i -c 'echo $PATH'"))))
    (setenv "PATH" path-from-shell)
    (setq eshell-path-env path-from-shell) ; for eshell users
    (setq exec-path (split-string path-from-shell path-separator))))

(set-exec-path-from-shell-PATH)

;; show where the buffer ends
;; (setq default-indicate-empty-lines t)

;; --------------------------------------------
;; shell-script configuration
(load "~/.emacs.d/dot-emacs-config/shell-script.el")

;; --------------------------------------------
;; magit configuration
(load "~/.emacs.d/dot-emacs-config/magit.el")

;; --------------------------------------------
;; everything that has to do with terminal
(load "~/.emacs.d/dot-emacs-config/terminal.el")
;; --------------------------------------------

;; --------------------------------------------
;;require psvn
;;(require 'psvn)
(require 'tabbar)

;; toggle forward - come up with a good shortcut for it
;; (global-set-key (kbd "C-<right>") 'switch-to-next-buffer)
;; (global-set-key (kbd "C-<left>") 'switch-to-prev-buffer)
(tabbar-mode nil)
;; (menu-bar-mode 1)
(setq tabbar-home-button (quote (("[Home]") "[x]")))
;; (tabbar-install-faces)

;; --------------------------------------------
;; --------------------------------------------
;; home specific color theme & layout

;; requires M-x color-theme-modern
(load-theme 'subtle-hacker t t)
(enable-theme 'subtle-hacker)

;; layout
(load "~/.emacs.d/dot-emacs-config/layout.el")


;;----------------------------------------------------

;; get history functions & bookmarks & reopen killed filed with C-S-t
(load "~/.emacs.d/dot-emacs-config/history.el")

;;----------------------------------------------------
(load "~/.emacs.d/dot-emacs-config/auto-complete.el")

;;----------------------------------------------------

;;----------------------------------------------------
;; auctex load the config

(load "~/.emacs.d/dot-emacs-config/auctex-config.el")

;; spell checker
(load "~/.emacs.d/dot-emacs-config/spell-check.el")


;;----------------------------------------------------
;; ido ( for example for buffer switching ) 
					;(require 'ido)
					;(ido-mode t)

;;----------------------------------------------------
;; org mode, override C-tab
;;(load "~/.emacs.d/dot-emacs-config/org-config.el")

;;----------------------------------------------------

;; shortcut for uncomment region
;;(global-unset-key "\C-c\C-z")
;;(global-set-key "\C-c\C-z" 'uncomment-region)
(defun comment-or-uncomment-region-or-line ()
    "Comments or uncomments the region or the current line if there's no active region."
    (interactive)
    (let (beg end)
        (if (region-active-p)
            (setq beg (region-beginning) end (region-end))
            (setq beg (line-beginning-position) end (line-end-position)))
        (comment-or-uncomment-region beg end)))
(global-set-key (kbd "C-/")'comment-or-uncomment-region-or-line)

;; markdown & wiki & gnuplot mode
(load "~/.emacs.d/dot-emacs-config/markdown-wiki-gnuplot.el")


;; (autoload 'R-mode "ess-site.el" "ESS" t)
;; (add-to-list 'auto-mode-alist '("\\.R$" . R-mode))




;;---------------------------------------------------------------
;; ESS - load Emacs speaks statistics:
(load "~/.emacs.d/dot-emacs-config/ess.el")

;;---------------------------------------------------------------
;; elpy - load python IDE:
(load "~/.emacs.d/dot-emacs-config/python.el")

;;---------------------------------------------------------------
;; web development

(load "~/.emacs.d/dot-emacs-config/html.el")

;;----------------------------------------

(load "~/.emacs.d/dot-emacs-config/editing.el")

;;----------------------------------------
;; awesome helm + projectile
(load "~/.emacs.d/dot-emacs-config/helm-projectile.el")

;;----------------------------------------
;; protobuff
(if (at-home-ubuntu)
    (progn
      (load "~/.emacs.d/dot-emacs-config/protobuf.el")
      ))
;;----------------------------------------
;; c-mode
(load "~/.emacs.d/dot-emacs-config/c-mode.el")

;;----------------------------------------------------------------------------------------

;; openwith & dired config
(load "~/.emacs.d/dot-emacs-config/dired.el")

;; load buffer shortcuts
(load "~/.emacs.d/dot-emacs-config/buffers.el")

;;--------------------------------------------------------------
;; hide/show + autocomplete + outline mode
(load "~/.emacs.d/dot-emacs-config/hide-show.el")


;; tabbar config 
(load "~/.emacs.d/dot-emacs-config/tabbar.el")
;; --------------------------------------------

;; --------------------------------------------
;; system specific config (@home, @qbm etc
(load "~/.emacs.d/dot-emacs-config/system-specific-config.el")
;; --------------------------------------------


;; --------------------------------------------
;; load aliases 
(load "~/.emacs.d/dot-emacs-config/alias.el")
;; --------------------------------------------

;; overwrite jedi:complete
(global-set-key (kbd "<C-tab>")  'tabbar-ruler-tabbar-forward-tab)

(remove-hook 'find-file-hooks 'vc-find-file-hook)
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(tabbar-button ((t (:inherit tabbar-default :foreground "dark red"))))
 '(tabbar-button-highlight ((t (:inherit tabbar-default))))
 '(tabbar-default ((t (:inherit variable-pitch :background "#959A79" :foreground "black" :weight bold))))
 '(tabbar-highlight ((t (:underline t))))
 '(tabbar-selected ((t (:inherit tabbar-default :background "#95CA59"))))
 '(tabbar-separator ((t (:inherit tabbar-default :background "#95CA59"))))
 '(tabbar-unselected ((t (:inherit tabbar-default)))))
