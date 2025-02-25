# Compress all files in the 4K folder to a zip file stored in the "exports" folder
# Usage: python install.py

import os
import zipfile

skins = ["4K", "4K_mini"]

for skin in skins:
    # If 4k.osz exist, delete it first
    if os.path.exists(f"exports/{skin}.msp"):
        os.remove(f"exports/{skin}.msp")
    # Create a zip file
    with zipfile.ZipFile(f"exports/{skin}.msp", "w") as zip:
        # Loop through the 4K folder
        for root, dirs, files in os.walk(skin):
            for file in files:
                # Compress the file without the "4K" parent folder
                file_path = os.path.join(root, file)
                arcname = os.path.relpath(file_path, skin)
                zip.write(file_path, arcname)
