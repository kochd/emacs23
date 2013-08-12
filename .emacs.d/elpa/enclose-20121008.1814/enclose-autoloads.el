;;; enclose-autoloads.el --- automatically extracted autoloads
;;
;;; Code:


;;;### (autoloads (enclose-global-mode turn-off-enclose-mode turn-on-enclose-mode
;;;;;;  enclose-mode) "enclose" "enclose.el" (20891 19014))
;;; Generated autoloads from enclose.el

(autoload 'enclose-mode "enclose" "\
Enclose cursor within punctuation pairs.

\(fn &optional ARG)" t nil)

(autoload 'turn-on-enclose-mode "enclose" "\
Turn on `enclose-mode'.

\(fn)" t nil)

(autoload 'turn-off-enclose-mode "enclose" "\
Turn off `enclose-mode'.

\(fn)" t nil)

(defvar enclose-global-mode nil "\
Non-nil if Enclose-Global mode is enabled.
See the command `enclose-global-mode' for a description of this minor mode.
Setting this variable directly does not take effect;
either customize it (see the info node `Easy Customization')
or call the function `enclose-global-mode'.")

(custom-autoload 'enclose-global-mode "enclose" nil)

(autoload 'enclose-global-mode "enclose" "\
Toggle Enclose mode in every possible buffer.
With prefix ARG, turn Enclose-Global mode on if and only if
ARG is positive.
Enclose mode is enabled in all buffers where
`turn-on-enclose-mode' would do it.
See `enclose-mode' for more information on Enclose mode.

\(fn &optional ARG)" t nil)

;;;***

;;;### (autoloads nil nil ("enclose-pkg.el") (20891 19014 571219))

;;;***

(provide 'enclose-autoloads)
;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; enclose-autoloads.el ends here
