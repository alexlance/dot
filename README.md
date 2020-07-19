## Dot files

A way to put my dot files under version control. The Makefile is used to
automatically create or remove symlinks from the home directory to the path
where this repo is checked out.

#### Install

```
$ cd ~
$ git clone https://github.com/alexlance/dot
$ cd dot
$ make
'/home/user/.tmux.conf' -> 'dot/tmux.conf'
'/home/user/.rtorrent.rc' -> 'dot/rtorrent.rc'
'/home/user/.bashrc' -> 'dot/bashrc'
<snip>
```

#### Usage

Running `make` will create symlinks from the home directory down into the
checked out repo. Eg:

```
$ make
$ ls -la ~/.bashrc
/home/user/.bashrc -> dot/bashrc
```

Running `make` a second time will remove any symlinks that link back to this
repo. Only dot files that are symlinked to this repo are affected. Existing
configuration files are not touched.

It is also possible to just deploy/undeploy one file instead of all of them
by targetting it with `make`:

```
$ make bashrc
$ ls -la ~/.bashrc
/home/user/.bashrc -> dot/bashrc

$ make bashrc
$ ls -la ~/.bashrc
ls: cannot access '/home/user/.bashrc': No such file or directory
```
