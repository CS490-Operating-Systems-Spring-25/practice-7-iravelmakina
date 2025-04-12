## Task 2 – File Descriptors & Limits
```bash
g++ main.cpp -o main ./main
```

---

```bash
ubuntu@kaguos:~/practice-7-iravelmakina$ pidof main
2264855
ubuntu@kaguos:~/practice-7-iravelmakina$ ps -aux | grep main
ubuntu   2182178  0.2  2.3 5183696 95544 ?       Sl   03:38   2:12 /home/ubuntu/.vscode-server/cli/servers/Stable-4437686ffebaf200fa4a6e6e67f735f3edf24ada/server/node /home/ubuntu/.vscode-server/cli/servers/Stable-4437686ffebaf200fa4a6e6e67f735f3edf24ada/server/out/server-main.js --connection-token=remotessh --accept-server-license-terms --start-server --enable-remote-auto-shutdown --socket-path=/tmp/code-bf08fa28-2acb-480e-9bb2-da1f84b4af14
ubuntu   2264855  0.0  0.0   5700  2944 pts/0    S+   19:40   0:00 ./main
ubuntu   2264969  0.0  0.0   6672  1920 pts/1    S+   19:41   0:00 grep --color=auto main
```

---

```bash
ubuntu@kaguos:/proc/2264855$ ls
attr             cwd                latency     net            root          statm
autogroup        environ            limits      ns             sched         status
auxv             exe                loginuid    numa_maps      schedstat     syscall
cgroup           fd                 map_files   oom_adj        sessionid     task
clear_refs       fdinfo             maps        oom_score      setgroups     timens_offsets
cmdline          gid_map            mem         oom_score_adj  smaps         timers
comm             io                 mountinfo   pagemap        smaps_rollup  timerslack_ns
coredump_filter  ksm_merging_pages  mounts      personality    stack         uid_map
```

---

```bash
ubuntu@kaguos:/proc/2264855$ sudo cat environ
SHELL=/bin/bashCOLORTERM=truecolorTERM_PROGRAM_VERSION=1.99.0PWD=/home/ubuntu/practice-7-iravelmakina/task2LOGNAME=ubuntuXDG_SESSION_TYPE=ttyVSCODE_GIT_ASKPASS_NODE=/home/ubuntu/.vscode-server/cli/servers/Stable-4437686ffebaf200fa4a6e6e67f735f3edf24ada/server/nodeHOME=/home/ubuntuLANG=C.UTF-8LS_COLORS=rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:mi=00:su=37;41:sg=30;43:ca=00:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arc=01;31:*.arj=01;31:*.taz=01;31:*.lha=01;31:*.lz4=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.tzo=01;31:*.t7z=01;31:*.zip=01;31:*.z=01;31:*.dz=01;31:*.gz=01;31:*.lrz=01;31:*.lz=01;31:*.lzo=01;31:*.xz=01;31:*.zst=01;31:*.tzst=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.war=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.alz=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.cab=01;31:*.wim=01;31:*.swm=01;31:*.dwm=01;31:*.esd=01;31:*.avif=01;35:*.jpg=01;35:*.jpeg=01;35:*.mjpg=01;35:*.mjpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.webp=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.m4a=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.oga=00;36:*.opus=00;36:*.spx=00;36:*.xspf=00;36:*~=00;90:*#=00;90:*.bak=00;90:*.crdownload=00;90:*.dpkg-dist=00;90:*.dpkg-new=00;90:*.dpkg-old=00;90:*.dpkg-tmp=00;90:*.old=00;90:*.orig=00;90:*.part=00;90:*.rej=00;90:*.rpmnew=00;90:*.rpmorig=00;90:*.rpmsave=00;90:*.swp=00;90:*.tmp=00;90:*.ucf-dist=00;90:*.ucf-new=00;90:*.ucf-old=00;90:SSL_CERT_DIR=/usr/lib/ssl/certsGIT_ASKPASS=/home/ubuntu/.vscode-server/cli/servers/Stable-4437686ffebaf200fa4a6e6e67f735f3edf24ada/server/extensions/git/dist/askpass.shSSH_CONNECTION=192.168.64.1 63400 192.168.64.22 22VSCODE_GIT_ASKPASS_EXTRA_ARGS=LESSCLOSE=/usr/bin/lesspipe %s %sXDG_SESSION_CLASS=userTERM=xterm-256colorLESSOPEN=| /usr/bin/lesspipe %sUSER=ubuntuVSCODE_GIT_IPC_HANDLE=/run/user/1000/vscode-git-bfb0e9839e.sockSHLVL=2XDG_SESSION_ID=719XDG_RUNTIME_DIR=/run/user/1000SSL_CERT_FILE=/usr/lib/ssl/cert.pemSSH_CLIENT=192.168.64.1 63400 22VSCODE_GIT_ASKPASS_MAIN=/home/ubuntu/.vscode-server/cli/servers/Stable-4437686ffebaf200fa4a6e6e67f735f3edf24ada/server/extensions/git/dist/askpass-main.jsXDG_DATA_DIRS=/usr/local/share:/usr/share:/var/lib/snapd/desktopBROWSER=/home/ubuntu/.vscode-server/cli/servers/Stable-4437686ffebaf200fa4a6e6e67f735f3edf24ada/server/bin/helpers/browser.shPATH=/home/ubuntu/.vscode-server/cli/servers/Stable-4437686ffebaf200fa4a6e6e67f735f3edf24ada/server/bin/remote-cli:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:/home/ubuntu/.vscode-server/data/User/globalStorage/github.copilot-chat/debugCommandDBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/busTERM_PROGRAM=vscodeVSCODE_IPC_HOOK_CLI=/run/user/1000/vscode-ipc-13aa0da6-eb2a-4640-bf4d-85d2d8f012f4.sock_=./mainOLDPWD=/home/ubuntu/practice-7-iravelmakina
```

---


```bash
ubuntu@kaguos:/proc/2264855$ sudo cat limits
Limit                     Soft Limit           Hard Limit           Units     
Max cpu time              unlimited            unlimited            seconds   
Max file size             unlimited            unlimited            bytes     
Max data size             unlimited            unlimited            bytes     
Max stack size            8388608              unlimited            bytes     
Max core file size        0                    unlimited            bytes     
Max resident set          unlimited            unlimited            bytes     
Max processes             15331                15331                processes 
Max open files            1048576              1048576              files     
Max locked memory         511533056            511533056            bytes     
Max address space         unlimited            unlimited            bytes     
Max file locks            unlimited            unlimited            locks     
Max pending signals       15331                15331                signals   
Max msgqueue size         819200               819200               bytes     
Max nice priority         0                    0                    
Max realtime priority     0                    0                    
Max realtime timeout      unlimited            unlimited            us        
```

---

```bash
ubuntu@kaguos:/proc/2264855$ sudo cat stat
2264855 (main) S 2258021 2264855 2258021 34816 2264855 4194304 169 0 0 0 0 1 0 0 20 0 1 0 17795315 5836800 736 18446744073709551615 190376920612864 190376920618795 281474162640240 0 0 0 0 0 0 1 0 0 17 0 0 0 0 0 0 190376920743152 190376920743960 190377439076352 281474162643475 281474162643482 281474162643482 281474162647025 0
```

---

```bash
ubuntu@kaguos:/proc/2264855$ sudo cat stack
[<0>] hrtimer_nanosleep+0xc4/0x1d8
[<0>] common_nsleep+0x50/0xb8
[<0>] __arm64_sys_clock_nanosleep+0xf0/0x1b0
[<0>] invoke_syscall+0x7c/0x130
[<0>] el0_svc_common.constprop.0+0x4c/0x140
[<0>] do_el0_svc+0x28/0x58
[<0>] el0_svc+0x44/0x1a0
[<0>] el0t_64_sync_handler+0x148/0x158
[<0>] el0t_64_sync+0x1b0/0x1b8
```

---

```bash
ubuntu@kaguos:/proc/2264855$ sudo cat cmdline
./mainubuntu@kaguos:/proc/2264855$ 
```

---

```bash
g++ files.cpp -o files ./files
```

---

```bash
ubuntu@kaguos:~/practice-7-iravelmakina/task2$ pidof files
2268782
```

---

```bash
ubuntu@kaguos:~/practice-7-iravelmakina/task2$ ls -l /proc/2268782/fd
total 0
lrwx------ 1 ubuntu ubuntu 64 Apr 12 20:01 0 -> /dev/pts/0
lrwx------ 1 ubuntu ubuntu 64 Apr 12 20:01 1 -> /dev/pts/0
l-wx------ 1 ubuntu ubuntu 64 Apr 12 20:01 10 -> /home/ubuntu/practice-7-iravelmakina/task2/files_created/file_7.txt
l-wx------ 1 ubuntu ubuntu 64 Apr 12 20:01 11 -> /home/ubuntu/practice-7-iravelmakina/task2/files_created/file_8.txt
l-wx------ 1 ubuntu ubuntu 64 Apr 12 20:01 12 -> /home/ubuntu/practice-7-iravelmakina/task2/files_created/file_9.txt
l-wx------ 1 ubuntu ubuntu 64 Apr 12 20:01 13 -> /home/ubuntu/practice-7-iravelmakina/task2/files_created/file_10.txt
l-wx------ 1 ubuntu ubuntu 64 Apr 12 20:01 14 -> /home/ubuntu/practice-7-iravelmakina/task2/files_created/file_11.txt
l-wx------ 1 ubuntu ubuntu 64 Apr 12 20:01 15 -> /home/ubuntu/practice-7-iravelmakina/task2/files_created/file_12.txt
l-wx------ 1 ubuntu ubuntu 64 Apr 12 20:01 16 -> /home/ubuntu/practice-7-iravelmakina/task2/files_created/file_13.txt
l-wx------ 1 ubuntu ubuntu 64 Apr 12 20:01 17 -> /home/ubuntu/practice-7-iravelmakina/task2/files_created/file_14.txt
l-wx------ 1 ubuntu ubuntu 64 Apr 12 20:01 18 -> /home/ubuntu/practice-7-iravelmakina/task2/files_created/file_15.txt
l-wx------ 1 ubuntu ubuntu 64 Apr 12 20:01 19 -> /home/ubuntu/.vscode-server/data/logs/20250411T203404/remoteTelemetry.log
lrwx------ 1 ubuntu ubuntu 64 Apr 12 20:01 2 -> /dev/pts/0
l-wx------ 1 ubuntu ubuntu 64 Apr 12 20:01 20 -> /home/ubuntu/.vscode-server/data/logs/20250411T203404/ptyhost.log
l-wx------ 1 ubuntu ubuntu 64 Apr 12 20:01 21 -> /home/ubuntu/practice-7-iravelmakina/task2/files_created/file_16.txt
l-wx------ 1 ubuntu ubuntu 64 Apr 12 20:01 22 -> /home/ubuntu/.vscode-server/data/logs/20250411T203404/remoteagent.log
l-wx------ 1 ubuntu ubuntu 64 Apr 12 20:01 23 -> /home/ubuntu/practice-7-iravelmakina/task2/files_created/file_17.txt
l-wx------ 1 ubuntu ubuntu 64 Apr 12 20:01 24 -> /home/ubuntu/practice-7-iravelmakina/task2/files_created/file_18.txt
l-wx------ 1 ubuntu ubuntu 64 Apr 12 20:01 25 -> /home/ubuntu/practice-7-iravelmakina/task2/files_created/file_19.txt
l-wx------ 1 ubuntu ubuntu 64 Apr 12 20:01 26 -> /home/ubuntu/practice-7-iravelmakina/task2/files_created/file_20.txt
l-wx------ 1 ubuntu ubuntu 64 Apr 12 20:01 27 -> /home/ubuntu/practice-7-iravelmakina/task2/files_created/file_21.txt
l-wx------ 1 ubuntu ubuntu 64 Apr 12 20:01 28 -> /home/ubuntu/practice-7-iravelmakina/task2/files_created/file_22.txt
l-wx------ 1 ubuntu ubuntu 64 Apr 12 20:02 29 -> /home/ubuntu/practice-7-iravelmakina/task2/files_created/file_23.txt
l-wx------ 1 ubuntu ubuntu 64 Apr 12 20:01 3 -> /home/ubuntu/practice-7-iravelmakina/task2/files_created/file_0.txt
l-wx------ 1 ubuntu ubuntu 64 Apr 12 20:02 30 -> /home/ubuntu/practice-7-iravelmakina/task2/files_created/file_24.txt
l-wx------ 1 ubuntu ubuntu 64 Apr 12 20:02 31 -> /home/ubuntu/practice-7-iravelmakina/task2/files_created/file_25.txt
l-wx------ 1 ubuntu ubuntu 64 Apr 12 20:02 32 -> /home/ubuntu/practice-7-iravelmakina/task2/files_created/file_26.txt
l-wx------ 1 ubuntu ubuntu 64 Apr 12 20:02 33 -> /home/ubuntu/practice-7-iravelmakina/task2/files_created/file_27.txt
l-wx------ 1 ubuntu ubuntu 64 Apr 12 20:02 34 -> /home/ubuntu/practice-7-iravelmakina/task2/files_created/file_28.txt
l-wx------ 1 ubuntu ubuntu 64 Apr 12 20:02 35 -> /home/ubuntu/practice-7-iravelmakina/task2/files_created/file_29.txt
l-wx------ 1 ubuntu ubuntu 64 Apr 12 20:02 36 -> /home/ubuntu/practice-7-iravelmakina/task2/files_created/file_30.txt
l-wx------ 1 ubuntu ubuntu 64 Apr 12 20:02 37 -> /home/ubuntu/practice-7-iravelmakina/task2/files_created/file_31.txt
l-wx------ 1 ubuntu ubuntu 64 Apr 12 20:02 38 -> /home/ubuntu/practice-7-iravelmakina/task2/files_created/file_32.txt
l-wx------ 1 ubuntu ubuntu 64 Apr 12 20:02 39 -> /home/ubuntu/practice-7-iravelmakina/task2/files_created/file_33.txt
l-wx------ 1 ubuntu ubuntu 64 Apr 12 20:01 4 -> /home/ubuntu/practice-7-iravelmakina/task2/files_created/file_1.txt
l-wx------ 1 ubuntu ubuntu 64 Apr 12 20:02 40 -> /home/ubuntu/practice-7-iravelmakina/task2/files_created/file_34.txt
l-wx------ 1 ubuntu ubuntu 64 Apr 12 20:02 41 -> /home/ubuntu/practice-7-iravelmakina/task2/files_created/file_35.txt
l-wx------ 1 ubuntu ubuntu 64 Apr 12 20:02 42 -> /home/ubuntu/practice-7-iravelmakina/task2/files_created/file_36.txt
l-wx------ 1 ubuntu ubuntu 64 Apr 12 20:02 43 -> /home/ubuntu/practice-7-iravelmakina/task2/files_created/file_37.txt
l-wx------ 1 ubuntu ubuntu 64 Apr 12 20:02 44 -> /home/ubuntu/practice-7-iravelmakina/task2/files_created/file_38.txt
l-wx------ 1 ubuntu ubuntu 64 Apr 12 20:02 45 -> /home/ubuntu/practice-7-iravelmakina/task2/files_created/file_39.txt
l-wx------ 1 ubuntu ubuntu 64 Apr 12 20:02 46 -> /home/ubuntu/practice-7-iravelmakina/task2/files_created/file_40.txt
l-wx------ 1 ubuntu ubuntu 64 Apr 12 20:02 47 -> /home/ubuntu/practice-7-iravelmakina/task2/files_created/file_41.txt
l-wx------ 1 ubuntu ubuntu 64 Apr 12 20:02 48 -> /home/ubuntu/practice-7-iravelmakina/task2/files_created/file_42.txt
l-wx------ 1 ubuntu ubuntu 64 Apr 12 20:02 49 -> /home/ubuntu/practice-7-iravelmakina/task2/files_created/file_43.txt
l-wx------ 1 ubuntu ubuntu 64 Apr 12 20:01 5 -> /home/ubuntu/practice-7-iravelmakina/task2/files_created/file_2.txt
l-wx------ 1 ubuntu ubuntu 64 Apr 12 20:02 50 -> /home/ubuntu/practice-7-iravelmakina/task2/files_created/file_44.txt
l-wx------ 1 ubuntu ubuntu 64 Apr 12 20:02 51 -> /home/ubuntu/practice-7-iravelmakina/task2/files_created/file_45.txt
l-wx------ 1 ubuntu ubuntu 64 Apr 12 20:02 52 -> /home/ubuntu/practice-7-iravelmakina/task2/files_created/file_46.txt
l-wx------ 1 ubuntu ubuntu 64 Apr 12 20:02 53 -> /home/ubuntu/practice-7-iravelmakina/task2/files_created/file_47.txt
l-wx------ 1 ubuntu ubuntu 64 Apr 12 20:02 54 -> /home/ubuntu/practice-7-iravelmakina/task2/files_created/file_48.txt
l-wx------ 1 ubuntu ubuntu 64 Apr 12 20:02 55 -> /home/ubuntu/practice-7-iravelmakina/task2/files_created/file_49.txt
l-wx------ 1 ubuntu ubuntu 64 Apr 12 20:02 56 -> /home/ubuntu/practice-7-iravelmakina/task2/files_created/file_50.txt
l-wx------ 1 ubuntu ubuntu 64 Apr 12 20:02 57 -> /home/ubuntu/practice-7-iravelmakina/task2/files_created/file_51.txt
l-wx------ 1 ubuntu ubuntu 64 Apr 12 20:02 58 -> /home/ubuntu/practice-7-iravelmakina/task2/files_created/file_52.txt
l-wx------ 1 ubuntu ubuntu 64 Apr 12 20:02 59 -> /home/ubuntu/practice-7-iravelmakina/task2/files_created/file_53.txt
l-wx------ 1 ubuntu ubuntu 64 Apr 12 20:01 6 -> /home/ubuntu/practice-7-iravelmakina/task2/files_created/file_3.txt
l-wx------ 1 ubuntu ubuntu 64 Apr 12 20:01 7 -> /home/ubuntu/practice-7-iravelmakina/task2/files_created/file_4.txt
l-wx------ 1 ubuntu ubuntu 64 Apr 12 20:01 8 -> /home/ubuntu/practice-7-iravelmakina/task2/files_created/file_5.txt
l-wx------ 1 ubuntu ubuntu 64 Apr 12 20:01 9 -> /home/ubuntu/practice-7-iravelmakina/task2/files_created/file_6.txt
```

---

```bash
ubuntu@kaguos:~$ cat /proc/sys/fs/file-max
9223372036854775807
ubuntu@kaguos:~$ sudo bash -c 'echo 65535 > /proc/sys/fs/file-max'
ubuntu@kaguos:~$ cat /proc/sys/fs/file-max
65535
```

---

```bash
ubuntu@kaguos:~/practice-7-iravelmakina/task2$ g++ file_limit.cpp -o file_limit ./file_limit
```

---

```bash
.
.
.
Batch 52: Opened 53000 files so far.
Batch 53: Opened 54000 files so far.
Batch 54: Opened 55000 files so far.
Batch 55: Opened 56000 files so far.
Batch 56: Opened 57000 files so far.
Batch 57: Opened 58000 files so far.
Batch 58: Opened 59000 files so far.
Batch 59: Opened 60000 files so far.
Batch 60: Opened 61000 files so far.
Batch 61: Opened 62000 files so far.
Batch 62: Opened 63000 files so far.
Failed to open file: files_created/file_63761.txt after opening 63761 files.
```

---

```bash
ubuntu@kaguos:~$ sudo dmesg | tail -1
[179963.622384] VFS: file-max limit 65535 reached
```

```bash
ubuntu@kaguos:~/practice-7-iravelmakina/task2$ cd files_created
bash: cannot make pipe for command substitution: Too many open files in system
bash: cannot make pipe for command substitution: Too many open files in system
```

The terminal process failed to launch: A native exception occurred during launch (forkpty(3) failed.).
