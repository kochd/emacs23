;;; opsi-mode-el -- Major mode for editing Winst/OPSI files

;; Author: Daniel Koch <koch@triple6.org>
;; Created: 07 Mar 2014
;; Keywords: OPSI major-mode
;; Version: 0.5
;; Description:
;; This is a Major-Mode for Editing Winst/OPSI files
;; as involved in the software deployment software OPSI by uib
;; See opsi.org for details

;; Copyright (C) 2014 Daniel Koch <koch@triple6.org>

;; This program is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License as
;; published by the Free Software Foundation; either version 2 of
;; the License, or (at your option) any later version.

;; This program is distributed in the hope that it will be
;; useful, but WITHOUT ANY WARRANTY; without even the implied
;; warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR
;; PURPOSE.  See the GNU General Public License for more details.

;; You should have received a copy of the GNU General Public
;; License along with this program; if not, write to the Free
;; Software Foundation, Inc., 59 Temple Place, Suite 330, Boston,
;; MA 02111-1307 USA

(defvar opsi-mode-hook nil)
(defvar opsi-mode-map
  (let ((opsi-mode-map (make-keymap)))
;    (define-key opsi-mode-map "\C-j" 'newline-and-indent)
    opsi-mode-map)
  "Keymap for OPSI major mode")


;; ,----
;; | File-Extensions
;; `----
(add-to-list 'auto-mode-alist '("\\.opsi.*\\'" . opsi-mode))
(add-to-list 'auto-mode-alist '("\\.ins\\'" . opsi-mode))

;; ,----
;; | Syntax
;; `----
(setq opsi-parts '(
"Actions" "Initial"
"actions" "initial"
))

(setq opsi-sections '(
"WinBatch" "DosBatch" "DosInAnIcon" "Sub" "Files" "Patch" "Registry"
"Winbatch" "Dosbatch" "Dosinanicon"
"winbatch" "dosbatch" "Dosinanicon" "sub" "files" "patch" "registry"
))

(setq opsi-constants '(
"ScriptPath" "Scriptpath" "scriptpath"
"ScriptDrive" "Scriptdrive" "scriptdrive"
"ProgramFiles32Dir" "Programfiles32dir" "programfiles32dir"
"ProgramFiles64Dir" "Programfiles64dir" "programfiles64dir"
"ProgramFilesDir" "Programfilesdir" "programfilesdir"
"CurrentProfileDir" "Currentprofiledir" "currentprofiledir"
"CurrentDesktopDir" "Currentdesktopdir" "currentdesktopdir"
"AllUsersProfileDir" "Allusersprofiledir" "allusersprofiledir"
))

(setq opsi-functions '(
"SetLogLevel" "Setloglevel" "setloglevel"
"ExitOnError" "Exitonerror" "exitonerror"
"ScriptErrorMessages" "Scripterrormessages" "scripterrormessages"
"TraceMode" "Tracemode" "tracemode"
"StayOnTop" "Stayontop" "stayontop"
"Comment" "comment"
"Message" "message"
"ShowBitmap" "Showbitmap" "showbitmap"
"KillTask" "Killtask" "killtask"
"SleepSeconds" "Sleepseconds" "sleepseconds"
"Set" "set"
"DefVar" "Defvar" "defvar"
"DefStringList" "Defstringlist" "defstringlist"
"If" "if"
"Or" "or"
"Not" "not"
"EndIf" "Endif" "endif"
"Else" "else"
"For" "for"
"In" "in"
"Include_Insert" "Include_Insert" "Include_insert"
"Include_Append" "Include_Append" "Include_append"
"Sub" "sub"
"LogError" "Logerror" "logerror"
"IsFatalError" "Isfatalerror" "isfatalerror"
"HasMinimumSpace" "Hasminimumspace" "hasminimumspace"
"GetReturnListFromSection" "getReturnListFromSection" "Getreturnlistfromsection" "getreturnlistfromsection"
"GetProductProperty" "getProductProperty" "Getproductproperty" "getproductproperty"
"GetMsVersionInfo" "getMsVersionInfo" "Getmsversioninfo" "getmsversioninfo"
"GetLastExitCode" "getLastExitCode" "Getlastexitcode" "getlastexitcode"
"GetSystemType" "GetSystemType" "Getsystemtype" "getsystemtype"
"TakeString" "takeString" "Takestring" "takestring"
"SplitString" "splitString" "Splitstring" "splitstring"
"ExitWindows" "ExitWindows" "Exitwindows" "exitwindows"
))

(setq opsi-functions-args '(
"Waitforprocessending" "Timeout" "ImmediateLogout"
"waitforprocessending" "Timeout" "Immediatelogout"
"WaitForProcessEnding" "Timeout" "immediatelogout"
))

;; []
(setq opsi-parts-regexp (concat "\\[" (regexp-opt opsi-parts ) "\\]"))

;; Section_
(setq opsi-sections-regexp (concat "\\(\\[\\|\\)" (regexp-opt opsi-sections ) "_\\(_\\|\\w\\)*\\(\\]\\|\\)"))

;; %
(setq opsi-constants-regexp (concat "%" (regexp-opt opsi-constants) "%"))

;; $
(setq opsi-variables-regexp "\\<\$\\(\\w\\|\_\\|\-\\)*\$\\>")

;; DefVar,Set
(setq opsi-functions-regexp (regexp-opt opsi-functions 'words))

;; Parsing ARGS with leading "/"
(setq opsi-functions-args-regexp (concat "\/" (regexp-opt opsi-functions-args)))


;;Warning ARGS. (Not legit)
(setq opsi-warning-args-regexp  "%\\w*%")

;; create the list for font-lock.
;; each class of keyword is given a particular face
(setq opsi-font-lock-keywords
  `(
    (,opsi-parts-regexp . font-lock-keyword-face)
    (,opsi-sections-regexp . font-lock-keyword-face)
    (,opsi-constants-regexp . font-lock-builtin-face)
    (,opsi-functions-regexp . font-lock-function-name-face)
    (,opsi-functions-args-regexp . font-lock-builtin-face)
    (,opsi-variables-regexp . font-lock-constant-face)
    (,opsi-warning-args-regexp . font-lock-warning-face)
    ;; note: order above matters. “opsi-keywords-regexp” goes last because
))

;;; Clear mem
(setq opsi-parts-regexp nil)
(setq opsi-sections-regexp nil)
(setq opsi-constants-regexp nil)
(setq opsi-functions-regexp nil)
(setq opsi-functions-args-regexp nil)
(setq opsi-variables-regexp nil)

(defvar opsi-mode-syntax-table
  (let ((opsi-mode-syntax-table (make-syntax-table )))

    ; Use ";" for commands
	(modify-syntax-entry ?\; "< b" opsi-mode-syntax-table) ; ";" Start a comment
	(modify-syntax-entry ?\n "> b" opsi-mode-syntax-table) ; "\n" Ends a comment
	(modify-syntax-entry ?\' "\""  opsi-mode-syntax-table) ; "'" qoutes a string
	(modify-syntax-entry ?\\ " "  opsi-mode-syntax-table)  ; "\" does nothing ( Escapes by default )



	opsi-mode-syntax-table)
  "Syntax table for opsi-mode")

;; ,----
;; | Comment-dwim
;; `----
(defun opsi-comment-dwim (arg)
  "Comment or uncomment current line or region in a smart way.
For detail, see `comment-dwim'."
  (interactive "*P")
  (require 'newcomment)
  (let (
        (comment-start ";")
        )
    (comment-dwim arg)))


;; ,----
;; | Indentation
;; `----
(defun opsi-indent-line ()
  "Indent current line as OPSI code."
  (interactive)
  (beginning-of-line)
    (let ((not-indented t) cur-indent)
        (if (looking-at "^[ \t]*\\(Endif\\|Else\\)") ; If the line we are looking at is the end of a block, then decrease the indentation
	      (progn
		(save-excursion
		    (forward-line -1)
		      (setq cur-indent (- (current-indentation) tab-width)))
		(if (< cur-indent 0) ; We can't indent past the left margin
		    (setq cur-indent 0)))
	  (save-excursion
	      (while not-indented ; Iterate backwards until we find an indentation hint
		(forward-line -1)
		(if (looking-at "^[ \t]*Endif") ; This hint indicates that we need to indent at the level of the Endif token
		    (progn
			(setq cur-indent (current-indentation))
			  (setq not-indented nil))
		    (if (looking-at "^[ \t]*\\(If\\|Else\\)") ; This hint indicates that we need to indent an extra level
			(progn
			    (setq cur-indent (+ (current-indentation) tab-width)) ; Do the actual indenting
			    (setq not-indented nil))
		      (if (bobp)
			  (setq not-indented nil)
			))))))
	(if cur-indent
	    (indent-line-to cur-indent)
	  (indent-line-to 0))


)) ; If we didn't see an indentation hint, then allow no indentation



;; ,----
;; | Key Bindings
;; `----
(define-key opsi-mode-map (kbd "<backtab>") 'indent-relative)
(define-key opsi-mode-map [remap comment-dwim] 'opsi-comment-dwim)
;; ,----
;; | Mode Definition
;; `----

(defun opsi-mode ()
  (interactive)
  (kill-all-local-variables)
  (use-local-map opsi-mode-map)
  (set-syntax-table opsi-mode-syntax-table)
  ;; Set up font-lock
  (set (make-local-variable 'font-lock-defaults) '(opsi-font-lock-keywords))
  ;; Register our indentation function
  (set (make-local-variable 'indent-line-function) 'opsi-indent-line)
  (setq major-mode 'opsi-mode)
  (setq mode-name "OPSI")
  (run-hooks 'opsi-mode-hook))

(provide 'opsi-mode)
(provide 'opsi-mode-map)

;;; opsi-mode.el ends here
