#!/bin/bash

sbcl --load "keith/qls.lisp"         \
     --load "keith/start-pd2rs.lisp" \
     --eval "(pd2rs:start)"
