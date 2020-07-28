## Dot files

Place your home directory's dot configuration files under version control.
Use symlinks from the home directory to a directory that only contains
these configuration files. Eg:

`/home/user/.bashrc` would be a symlink that points to `/home/user/dot/bashrc`


#### Install

Running `make` will create the symlinks from the home directory down into the
checked out repo.

```
$ cd ~
$ git clone https://github.com/alexlance/dot
$ cd dot
$ make
'/home/user/.tmux.conf' -> 'dot/tmux.conf'
'/home/user/.bashrc' -> 'dot/bashrc'
<snip>
```

Then you can commit/pull/push from inside the `dot` directory to keep your
configurations up to date.


#### Notes

 * Existing config files are never touched, eg it won't deploy a .bashrc symlink
   and overwite your existing .bashrc.

 * Running `make` a second time will remove any symlinks that link back to the
   repo. It only removes the symlink if it does actually point to a file in
   the repo.

 * Deploy or undeploy only one file instead of all of them by targetting it,
   eg: `make bashrc`. Don't prefix the target with "." if just deploying one file.

