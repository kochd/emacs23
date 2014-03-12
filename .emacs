;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; add to your /etc/bash.bashrc: ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;(server-start)

;export TERM=xterm-256color
;em() { /usr/bin/emacsclient -t $1 || ( /usr/bin/emacs --daemon && emacsclient -t $1 ) }
;export -f em


;And then use em instead of emacs for faster loading of emacs
;You can also use 'emacsclient -nw' instead of 'emacsclient -t' for non-X mode and have an alias for that.

;;;;;;;;;;;
;; Loads ;;
;;;;;;;;;;;

;; Subdirs
(add-to-list 'load-path (expand-file-name "~/.emacs.d/move-text/"))
(add-to-list 'load-path (expand-file-name "~/.emacs.d/opsi-mode/"))
(require 'opsi-mode)


;;;;; Packages

;; Other archives
(when (<= emacs-major-version 24)
  (add-to-list 'load-path (expand-file-name "~/.emacs.d/package.el"))
  (load (expand-file-name "~/.emacs.d/package.el"))
)

(require 'package)
(add-to-list 'package-archives
	     '("marmalade" .
	       "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives
	     '("melpa" .
	       "http://melpa.milkbox.net/packages/"))
(package-initialize)

;;;;;;;;;;;;
;; Colors ;;
;;;;;;;;;;;;

(require 'color-theme)
(eval-after-load "color-theme"
  '(progn
;     (color-theme-initialize)
;     (color-theme-gray30)
;     (color-theme-dark-laptop)
;     (color-theme-zenburn)))
      (color-theme-molokai)))
;     (color-theme-arjen)
;     (color-theme-solarized-dark)


;;Force colors ignoring the theme
;;e.g. background to be transparent
;(set-face-foreground 'default "white")
;(set-face-background 'default " ")           ; Color of background
;(set-face-background 'region  "red")       ; Region color
(set-face-background 'hl-line "#111111")   ; hl-line color

(set-face-background 'col-highlight "#303030") ; col-line color
;(set-face-foreground 'paren-face "#cc6666")

;; ,----
;; | Font
;; `----
(set-face-attribute 'default nil :height 100 :family "Droid Sans Mono" )


;;;;;;;;;;;;;;;;;;;;;;;;
;; Settings and Modes ;;
;;;;;;;;;;;;;;;;;;;;;;;;

;; ,----
;; | OPSI-Mode
;; `----

(add-to-list 'auto-mode-alist '("\\.opsi*\\'" . opsi-mode))



;; ,----
;; | Org-Mode
;; `----

(org-babel-do-load-languages
 'org-babel-load-languages
 '(
   (sh . t)
   (python . t)
   (R . t)
   (ruby . t)
   (ditaa . t)
   (dot . t)
   (octave . t)
   (sqlite . t)
   (perl . t)
   (C . t)
   ))


;Yasnippet
(when (<= emacs-major-version 24)
	  (yas-global-mode t)
)

;Auto-Complete
(auto-complete t)
(global-auto-complete-mode t)

; Smart-Tab
(smart-tab-mode t)
(global-smart-tab-mode t)

;; Comment in Bash
;; (add-hook 'sh-mode-hook
;;           (lambda ()
;;              (define-key sh-mode-map "\C-c\C-c" 'comment-region)))

;; uniquify
;(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)

;; saveplace
(setq save-place-file "~/.emacs.d/saveplace-save");; keep my ~/ clean
(setq-default save-place t)                       ;; activate it for all buffers
;(require 'saveplace)                              ;; get the package)'))))"")

;; Follow symlinks
(setq vc-follow-symlinks 1)

;; Move-Text
(require 'move-text)

;; No Menubar
(menu-bar-mode -1)

;; No Toolbar
(tool-bar-mode -1)

;; No Startup screen
(setq inhibit-startup-message t)

;; Uhrzeit in Statuszeile
(display-time-mode t)

;; Display linenumber at the buttom
(line-number-mode t )

;; Display columnumber at the buttom
(column-number-mode t )

;; Visual selection of region
(transient-mark-mode t)

;; Like Bash-Complention für Emacs minibuffer
(icomplete-mode t)

;; Show linenumbers on the left
(global-linum-mode t)

;; Hightlight current line and colum
(global-hl-line-mode t)
(col-highlight-flash t)
(col-highlight-toggle-when-idle t)
(col-highlight-set-interval 0.5) ; Interval till col-line is shown

;; Show paren brakets
;;(show-paren-mode t)
;; REPLACED
(show-smartparens-global-mode t)

;; Nicer buffer switching whith completion
(ido-mode t)
(flx-ido-mode t)
;;(ido-vertical-mode t)
;;(smex-initialize)


;; Move mouse out of the screen when typing
(mouse-avoidance-mode 'banish)

;; Syntaxhighlighting
(font-lock-mode t)

;;Leave unsaved buffer using "y" and "n" instead of "yes" and "no"
(fset 'yes-or-no-p 'y-or-n-p)

;;Enclose parens
(if (> emacs-major-version 24)
    (progn
      (enclose-mode t) (electric-pair-mode nil))
  (progn
      (enclose-mode nil) (electric-pair-mode t)
      (setq electric-pair-pairs '(
                            (?\' . ?\')
                            (?\" . ?\")
                            (?\{ . ?\})
                            (?\( . ?\))
                            (?\[ . ?\])
                            )))
  )



;;;; Show whitespaces
(global-whitespace-mode t)

;;; What kind of whitespaces to show?
;; See whitespace-toggle-options for further information about what kind of
;; modes can be used
(setq whitespace-style (quote (
			       empty
			       face
;			       lines
;			       lines-tail
			       space-after-tab
			       space-before-tab
			       trailing
			       tab-mark
			       )))

;; clipboard integration for X
(setq x-select-enable-clipboard t)
(global-set-key [(shift delete)] 'clipboard-kill-region)
(global-set-key [(control insert)] 'clipboard-kill-ring-save)
(global-set-key [(shift insert)] 'clipboard-yank)

;; Comany-mode
;; (require 'company)
;; (add-hook 'after-init-hook 'global-company-mode)

;;; Flyspell/Ispell
;(require 'auto-dictionary)
(add-hook 'flyspell-mode-hook (lambda () (auto-dictionary-mode 1)))


;;;;;;;;;;;;;;;;;
;; Keybindings ;;
;;;;;;;;;;;;;;;;;
(global-set-key (kbd "C-c SPC") 'ace-jump-buffer)
(global-set-key (kbd "<C-tab>") 'other-window)

(global-set-key (kbd "<f8>") 'flyspell-mode)
(global-set-key (kbd "M-<f8>") 'flyspell-prog-mode)
(global-set-key (kbd "C-<f8>") 'ispell-word)
(global-set-key (kbd "S-<f8>") 'ispell-change-dictionary)
(global-set-key (kbd "C-c -") 'comment-dwim)


;;; Eshell
(global-set-key (kbd "<f1>") 'eshell)


;;; Resize windows
(global-set-key (kbd "S-C-<down>") 'windresize)

;;; Other windows
(global-set-key (kbd "C-o") 'other-window)

;; redo+
;(require 'redo+)
(global-set-key (kbd "M-_") 'redo)
(setq undo-no-redo t)

;; ,----
;; |X-Clipboard Integration
;; `----
(defun copy-to-x-clipboard ()
  (interactive)
  (if (region-active-p)
    (progn
     ; my clipboard manager only intercept CLIPBOARD
      (shell-command-on-region (region-beginning) (region-end)
        (cond
         ((eq system-type 'cygwin) "putclip")
         ((eq system-type 'darwin) "pbcopy")
         (t "xsel -ib")
         )
        )
      (message "Yanked region to clipboard!")
      (deactivate-mark))
    (message "No region active; can't yank to clipboard!")))

(defun paste-from-x-clipboard()
  (interactive)
  (shell-command
   (cond
    ((eq system-type 'cygwin) "getclip")
    ((eq system-type 'darwin) "pbpaste")
    (t "xsel -ob")
    )
   1)
  )
(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(show-paren-mode t))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )



;; ,----
;; | Hooks
;; `----
(eval-after-load 'python-mode
(add-hook 'python-mode-hook
	  (lambda ()
	    (define-key python-mode-map "\"" 'electric-pair)
	    (define-key python-mode-map "\'" 'electric-pair)
	    (define-key python-mode-map "(" 'electric-pair)
	    (define-key python-mode-map "[" 'electric-pair)
	    (define-key python-mode-map "{" 'electric-pair))))

;; ,----
;; | Auto-Byte-Compile
;; `----
(defun byte-compile-current-buffer ()
  "`byte-compile' current buffer if it's emacs-lisp-mode and compiled file exists."
  (interactive)
  (when (and (eq major-mode 'emacs-lisp-mode)
             (file-exists-p (byte-compile-dest-file buffer-file-name)))
    (byte-compile-file buffer-file-name)))

(add-hook 'after-save-hook 'byte-compile-current-buffer)

;; ,----
;; | Recompile .emacs.d every start
;; `----
;(byte-recompile-directory (expand-file-name "~/.emacs.d") 0)
