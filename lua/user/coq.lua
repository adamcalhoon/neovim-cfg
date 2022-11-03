local status_ok, coq = pcall(require, 'coq')
if not status_ok then return end

coq.Now("shut-up")
