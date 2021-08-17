# Todo

--------------------------------------------------------------------------------

# _Tue 17 Aug 2021 06:46:14 AM PDT_ add job check to pre-flight scripts for satellite

- run a simple job against a known-good host
- wait for complete
- validate output

--------------------------------------------------------------------------------

# [ ] _Mon Jul 26 09:26:57 2021_ jupyterhub

- provide class name, make hostname classname date
- generate SSL cert with API
- provide DuckID list or AD group
- scripts on disk for TSD to modify users
- 250 students same time
    - 1 cpu per?
    - 4GB mem per?
- query banner for students
    - cron to add or drop students
- write confluence document for technical implementation
- confidentiality requirements down the road with scaling?
- shell access outside of their home directories if in pool?
- if cluster, will there ever be separation in versions? older/newer version existing same time

--------------------------------------------------------------------------------

# [ ] _Fri Jul 23 12:42:09 2021_ DUO scenarios

Will vendors have DUO?

Any Scenario where DUO is configured across-the-board could be a
massive implementation effort as there are many servers that
communicate with eachother via SSH and unless we're easily able to
do exclusions, each of those cases will need to be handled individually.

The better solution is to only implement DUO where needed,
mainly for vendor access. As long as users are using ssh keys,
(encrypted keys forced via policy), they will not have to use 2fa.
This is to facilitate automation from Satellite (patching), as well
as Bolt task orchestration from client workstations.

## DUO using login_duo (sshd only)

[login_duo](https://duo.com/docs/loginduo)

```
Match Address *,!10.174.128.0/20,!184.171.102.189
    ForceCommand /usr/sbin/login_duo
```

### Benefits:

- Incredibly easy to use

- Can use MatchAddress to bypass DUO for DC networks or IP addresses
  for server-server communication

- Easiest solution to automate, requires no external dependencies,
  (no IDS team involvement for exceptions)

### Issues:

- SSH key auth does not bypass DUO

    - with admin vpn exclusion policy in DUO admin console, we should be fine

    - Match block in sshd_config:
      available criteria are
      User, Group, Host, LocalAddress, LocalPort, RDomain, and Address

- AllowTcpForwarding and PermitTunnel have to be turned off.

    - PermitTunnel - allow full tunnel via ssh (vpn-like functionality)

    - AllowTcpForwarding - allow proxy ssh through server

- Can be bypassed if users know how

    - Requires user to already have logged in once, as they'll have to edit their bashrc

    - `ForceCommand /usr/sbin/login_duo`

    - This ForceCommand directive instructs sshd to run login_duo
      (to perform two-factor authentication) before any other
      requested commands. However, according to the sshd documentation:

      "The command is invoked by using the user's login shell with
      the -c option." This means that shell rc files
      (e.g. .bashrc, .cshrc, etc.) execute before login_duo;
      if users can edit these files, they may be able to disable
      Duo authentication for their own accounts. Keep in mind that
      ForceCommand also disables command=. Mitigate these issues by
      deploying pam_duo instead of login_duo.

## DUO using pam_duo

[pam_duo](https://duo.com/docs/duounix)

### Benefits:

More secure than login_duo

### Issues:

SSH key with DUO means that you have to turn PasswordAuthentication off
and force AuthenticationMethods to be both SSH key AND DUO.

```
PubkeyAuthentication yes
PasswordAuthentication no
AuthenticationMethods publickey,keyboard-interactive
```

Exclusions can only be defined via:

- local UNIX group, AD groups did *not* work

- policy attached to secret key

    - managed by cbernard in the DUO admin console

    - policies would need to be:

        - per-group (MAD, DBA, CTL, etc)

        - per server in the case of server-to-server communication (common)

## More VPN profiles

### Benefits:

- No system implementation

- Easy to build

### Issues:

- Hard to manage, easy to get out-of-hand

- More work for NTS

## Vendors on Admin VPN

### Benefits:

- Easiest solution

- no implementation needed, problem of "2fa in the path" is solved

### Issues:

- Depends on the answer of "What issue are we trying to solve?"

## What issue are we trying to solve?:

Having 2fa in the path?

Having access to the admin vpn does not mean that you have access to the services inside the admin vpn.

For Linux, ssh users are almost always admin users (except shell and a couple others)

For Windows, some RDP users are NOT admins. RDP seems to be understood as an administrative function, so they should be considered admins for the VPN?

Assuming a vendor or non-admin has access to the admin vpn, what issue are we trying to protect against?

- If their account gets owned, they have 2fa, so that should be a non-issue

- If their account is not compromised, what are we protecting against? Each service in the admin vpn is still password-protected.


TODO:

Work with cbernard to split out exception policy for each puppet group

--------------------------------------------------------------------------------

# [ ] _Thu Jul  1 15:21:19 2021_ followup on ticket replies from vmware about horizon client

- licensing:
    ```
    # /etc/nvidia/gridd.conf
    ServerAddress=is-vdinvidia01.uoregon.edu
    ServerPort=7070
    FeatureType=1
    ```
- i guess we're doing a remote meeting or something
- bunch of logs were uploaded to sftp, all the easy stuff checked out
- Isaac checked in and i told him i havent heard from them
- still working with john
- setting up a meeting with both John (vmware) and Mike (nvidia)

--------------------------------------------------------------------------------

# [ ] _Thu Jul  1 15:21:25 2021_ nms fully operational for base checks

- waiting on firewall rules
- decommission lib-vm-rdmi3?
- lib-vm-rdmi3 has been powered off, check back in a few days to see if we can decom
- bumped firewall rules ticket
- bunch of updates, need to go through checks again, lots of things resolved now

--------------------------------------------------------------------------------

# [ ] _Fri Jul  9 13:41:25 2021_ nms migration to rhel8

- next week, create confluence checklist for components that nms needs
    - perl modules?
    - any directories on nms that are important
    - nagios
    - sendpage
    - ton of scripts?
- spun up rhel8 vm - is-nms
- looks like Andrew is point on DCI to help with this upgrade
- [link to confluence](https://confluence.uoregon.edu/x/zTIkGg)
- ticket in for Shibboleth authentication

--------------------------------------------------------------------------------

# [ ] _Thu Jul  1 15:22:39 2021_ check out nsx training materials

- waiting on a list of them from somewhere

--------------------------------------------------------------------------------



# Completed tasks


- [x] _Thu Jul  1 15:24:18 2021_ get NEMO up and running, should be easy
    - [docker installation](https://github.com/usnistgov/NEMO/wiki/Installation-with-Docker)
    - is-nemo-test
    - django is pain, settings not found. need to go interactive and figure it out
    - dude fuck nemo
    - [google group question on install](https://groups.google.com/a/list.nist.gov/g/nemo/c/JrVTxryjuwY)
    - settings.py needed a newer version i guess?
    - it's all working now, just need to configure auth
        - SHIBBOLETH??????
    - _Wed Aug  4 08:29:12 2021_ putting this on hold


- [x] _Tue Jul 13 09:07:16 2021_ beginning of the end - DUO for linux
    - seeing what Matt's opinion is about DUO for cbernard's request

    - Considerations for video 1on1:
        - i'll formalize anything we decide on in writing, i just had a lot to ask

        - duo puppet module was never fully finished and integrated so i'll need until the end of next week to rewrite it and a couple other supporting modules.

        - exclusions for 2fa networks
            - need config mgmt vlan, only has servers that are used for config mgmt like puppet and satellit
            - admin vpn? there's already a layer of 2fa.
            - if exclusions are okay, which exclusions should we define client side vs server side?
                - exclude admin vpn on TFA side and server-specific exclusions on client side?
                - do all exclusions on client side?


        - exclusions for ssh key auth? (already 2fa by way of password-protected key)

        - in the case of exclusions, i've seen docs for linux that its configured client side, but is there anything in the admin side to configure for exclusions? what about client side for windows?

        - answer for windows vs linux:  windows has two management protocols, rdp and winrm
            - rdp can be DUO without affecting automation over winrm

    - module development:
        - duo::client::linux
            - done!
        - auth (for ensuring pam files)
            - done!
        - ssh (for modifying sshd)
            - done!

    - After meeting:
        - apply duo to two test tfa servers first

        - matt needs to swap cisco exceptions with admin vpn exceptions in duo admin console
            - i think this is why we even still 2fa into windows servers...
            - end state being admin vpn exception in duo admin console
            - removing the 10.128 ranges from admin console duo
            - allowlist for any ip range

    - Action items:
        - work with cbernard about splitting up ssh and rdp into puppet_ groups
            - services would have more accurate stakeholders
            - we can directly use those keys on those boxes so they all bind nicely

        - draft communication for each group for two questions
            - can we add admin vpn to exclusion list?
            - can we remove 10.128 from exclusion list?
            - cc charles and leland

    - Discussion with Matt:
        - ISO seems to think that duo client is THE answer instead of VPN, everyone can't be admins?
        - I've pushed back saying that Micah/Matt and Jose need to decide it's the correct answer and/or have a discussion before any implementation outside specific requests
            - charles seems hellbent on saying it IS the answer, i kept reminding him it might not be.
        - We need a direct answer from ISO about vendor access:
            - Vendor off-campus needs to SSH to a system. What is their route and how do we facilitate that?
                - vendor might not be able to 2fa?
                - if VPN, which vpn profile will they use? do we exclude that vpn from DUO using cbernard admin controls?
        - managing DUO exclusion policies, if DUO client is chosen, cbernard will need to support another service for managing exclusions
            - those exclusions are tied to a secret key, so we will need to implement that key for various systems
            - an example of a painful but realistic set up is:
                - each module has its own key with its own default exclusions, probably all the same
                - if a system needs ANY ssh access that's not from the admin vpn (server to server), it will need its own policy created with the IPs specified
                    - that key will then be used in the system's hiera
                    - cbernard will need to be able to organize all these policies
        - deployment of DUO client for linux is a BIG implementation
            - server to server communications will all need to be documented
        - alternatives:
            - local groups in the conf?
            - other settings in conf?
            - any way we can control the access lists ourselves on the server itself?

    - need to review list of people who have not responded
        - [x] ACADADMIN Tim Miller <tjm@uoregon.edu>
        - [x] ACADCENTRAL Shandon Bates <shandon@uoregon.edu>
        - [x] ACADSOUTH Duncan Barth <dbarth@uoregon.edu>
        - [x] DBA Stephany Freeman <sfreeman@uoregon.edu>
        - [x] DEVSERVICES Loring Hummel <lhummel@uoregon.edu>
        - [x] EDM Michelle Brown <mab@uoregon.edu>
        - [x] IDS Jeff Jones <jsjones@uoregon.edu>
        - [x] ISO Cleven Mmari <cmmari@uoregon.edu>
        - [x] ISO Jose Dominguez <jad@uoregon.edu>
        - [x] MAD Derek Wormdahl <derek@uoregon.edu>
        - [x] NTS Joe Mailander <jlm@uoregon.edu>
        - [x] TELECOM Eric Fullar <efullar@uoregon.edu>

    - post module development:
        - resources:
          - [How PAM Stacking Works](https://docs.oracle.com/cd/E19253-01/816-4557/pam-15/index.html)
        - local accounts bypass 2fa
        - ssh keys bypass 2fa
        - inter-system logins bypass 2fa (su)
        - password logins via ssh require 2fa
        - research is done, new task for implementation
    - _Tue Aug  3 12:07:35 2021_

- [x] _Thu Jul 22 11:17:51 2021_ sequoia priv escallation
    - patches second week of august
    - [check for docs and patches](https://access.redhat.com/security/vulnerabilities/RHSB-2021-006)
    - [patch shell out of band](https://jira.uoregon.edu/browse/CM-34520)
    - notify ISO - done in teams
    - notify Mark Allen - done
    - done! _Tue Jul 27 11:08:49 2021_

- [x] _Thu Jul  1 15:21:23 2021_ track github PR for vim-puppet
    - still waiting on comment from someone with permission to merge
    - this probably wont happen so i'll just mark as complete

- [x] _Tue Jul  6 12:32:12 2021_ ctl audit and gathering details for servers/clusters
    - ~/temp/ctl-status.md
    - msg sent for some of the systems i'm not sure of
    - just waiting on response about ctl-termsrv1
    - notes sent to Matt, he will forward to leslie
    - Derek is gonna get a list of all CTL fileshares
    - Julie will take that list back to CTL and make sure files are all there and being backed up
    - confluence and maybe jira will be reduced by september
        - they need to get off their plugins so its just be base product
        - we need to migrate to the cloud offering once it's been reduced
    - support.ctl.uoregon.edu
        - other than DDS helpdesk thing, the other sites should be static and easily moved?
    - no action items for me
    - _Thu Jul 22 14:35:13 2021_

- [x] _Fri Jul  9 11:50:27 2021_ refactor snmp modules
    - nagios was the only one with different configs, all fixed up

- [x] _Fri Jul  9 11:50:05 2021_ move rtbh to new hostnames
    - custom rtbh snmp

- [x] _Thu Jul  8 13:11:05 2021_ move cas-londonstage to puppet_devservices
    - access for seright
    - _Thu Jul  8 13:13:07 2021_

- [x] _Thu Jul  1 15:18:24 2021_ email about nvidia issues with linux
    - gdm3 used but lightdm needed?
    - lspci shows nvidia but software and updates shows svga
    - screenshots on desktop
    - sounds like its a vmware issue. ticket still open, waiting on vmware
    - _Thu Jul  1 15:18:58 2021_

- [x] _Thu Jul  1 15:18:34 2021_ check iterm2 FR issue for vim shell
    - [link here](https://gitlab.com/gnachman/iterm2/-/issues/9791)
    - _Thu Jul  1 15:19:07 2021_

- [x] _Thu Jul  1 15:18:41 2021_ upgrade loginsight agent package and deploy to production
    - redhat no longer using `yum` to update, using `rpm` like centos
    - instructions on how to update the agent are in the module comments
    - _Thu Jul  1 15:19:14 2021_

- [x] _Thu Jul  1 15:18:44 2021_ add the base role to the template repository for new modules
    - each module now has a puppet_group::role::base that can be used in place of specific configuration
    - vra will also use that role if no role is chosen
    - _Thu Jul  1 15:20:06 2021_

- [x] _Thu Jul  1 15:18:47 2021_ see about taking results from a shell command and storing them in a new split? buffer
    - <leader>xe should execute a command and open pipe to new buffer
    - _Thu Jul  1 15:21:02 2021_

- [x] _Thu Jul  1 15:18:49 2021_ keep track of the redhat licenese that expire 6-29
    - email sent to john
    - waiting for updated PO from SHI
    - said that they should all be processed by july 1
    - they all applied!
    - _Thu Jul  1 15:21:06 2021_
