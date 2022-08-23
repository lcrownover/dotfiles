alias hpc='ssh talapas-ln1'
alias gpra='spushd; cd ~/ansible/racs/ansible; ssh ansible@talapas-hn1.uoregon.edu -i ssh/id_rsa "cd ~ansible/racs; git pull"; spopd'
alias hpca='spushd; cd ~/ansible/racs/ansible; ssh -t ansible@talapas-hn1.uoregon.edu -i ssh/id_rsa "cd ~ansible/racs/ansible; bash"; spopd'
alias hpch='ssh lrc@talapas-hn1'
