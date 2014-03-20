;;; screenshot-autoloads.el --- automatically extracted autoloads
;;
;;; Code:


;;;### (autoloads (screenshot-take screenshot) "screenshot" "screenshot.el"
;;;;;;  (21289 54301 112699 592000))
;;; Generated autoloads from screenshot.el

(autoload 'screenshot "screenshot" "\
Prepare to take a screenshot to FILENAME with SCHEME.
After pressing C-c C-c, executing `screenshot-take'.
See also `screenshot-take' docstring. 

\(fn FILENAME &optional SCHEME NOMSG)" t nil)

(autoload 'screenshot-take "screenshot" "\
Take a screenshot configured by `screenshot' command.

- Taking a screenshot is delayed by `screenshot-take-delay'.
- Execute import command (ImageMagick).
- If the scheme has :ssh-dir property, use scp to send image to remote host.
  It is executed asynchronously to suppress a wait.
- Finally put the image URL or filename to kill-ring.
  Press C-y to input the image URL.
  If the scheme has :yaoddmuse, [[image:FileName]] is yanked.

\(fn)" t nil)

;;;***

;;;### (autoloads nil nil ("screenshot-pkg.el") (21289 54301 234759
;;;;;;  399000))

;;;***

(provide 'screenshot-autoloads)
;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; screenshot-autoloads.el ends here
