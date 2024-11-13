import os
import sys
import json

import symlink

if __name__ == "__main__":
    if len(sys.argv) < 3:
        print("Usage: python install.py <dotfiles.json> <backup_directory>")
        sys.exit(1)
    
    # Load dotfiles from JSON file
    dotfiles_json = sys.argv[1]
    backup_dir = sys.argv[2]
    with open(dotfiles_json) as f:
        dotfiles = json.load(f)["dotfiles"]
    
    # Iterate over dotfiles and create symlinks
    for dotfile in dotfiles:
        print(f"[{dotfile['name']}]")
        src_file = os.path.abspath(dotfile["source"])
        dest_file = os.path.abspath(os.path.expanduser(dotfile["destination"]))
        print(f"Linking {src_file} -> {dest_file}")
        symlink.link_dotfile(src_file, dest_file, backup_dir)
        print("")


