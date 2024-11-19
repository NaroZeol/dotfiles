import os
import shutil
import sys
from datetime import datetime

def backup_file(file_path, backup_dir):
    """Backup the specified file to the backup directory and append a timestamp to the backup filename"""
    # Ensure the backup directory exists
    if not os.path.exists(backup_dir):
        os.makedirs(backup_dir)
        print(f"Created backup directory: {backup_dir}")

    # Generate backup file path
    backup_filename = f"{os.path.basename(file_path)}.bak_{datetime.now().strftime('%Y%m%d_%H%M%S')}"
    backup_path = os.path.join(backup_dir, backup_filename)

    # Copy the file to the backup directory
    shutil.copy(file_path, backup_path)
    print(f"Backup created: {backup_path}")

def create_symlink(src_path, dest_path):
    """Remove the original file or symlink and create a new symlink in the target location"""
    if os.path.exists(dest_path) or os.path.islink(dest_path):
        os.remove(dest_path)
        print(f"Removed existing file or symlink: {dest_path}")
    os.symlink(src_path, dest_path)
    print(f"Symlink created: {dest_path} -> {src_path}")

def link_dotfile(src_file, dest_file, backup_dir):
    """Backup and create a symlink for the specified dotfile"""
    # Check if the source file exists
    if not os.path.isfile(src_file):
        print(f"Source file does not exist: {src_file}")
        sys.exit(1)

    # Check if the destination directory exists
    dest_dir = os.path.dirname(dest_file)
    if not os.path.exists(dest_dir):
        print(f"Destination directory does not exist: {dest_dir}")
        sys.exit(1)

    # Check if the destination path is already a symlink to the source file
    if os.path.islink(dest_file) and os.path.realpath(dest_file) == src_file:
        print(f"Symlink already exists: {dest_file} -> {src_file}")
        return

    # If the destination path is a file, back it up
    if os.path.isfile(dest_file):
        print(f"Detected existing file {dest_file}, backing up...")
        backup_file(dest_file, backup_dir)

    # Create the symlink
    create_symlink(src_file, dest_file)

if __name__ == "__main__":
    if len(sys.argv) < 4:
        print("Usage: python symlink.py <source_file_path> <destination_file_path> <backup_directory>")
        sys.exit(1)

    # Get source and destination file paths from command line arguments
    src_file = os.path.abspath(sys.argv[1])
    dest_file = os.path.abspath(sys.argv[2])
    backup_dir = os.path.abspath(sys.argv[3])

    # Perform the symlink operation
    link_dotfile(src_file, dest_file, backup_dir)
