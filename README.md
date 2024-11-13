Personal dotfiles

To install the dotfiles, run the following command:

```bash
python script/install.py dotfiles.json backups
```

This will backup all the files listed in `dotfiles.json` to the `backups` directory and then create symlinks to the files in this repository.
