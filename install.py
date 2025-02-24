# Compress all files in the 4K folder to a zip file stored in the "exports" folder
# Usage: python install.py

import os
import zipfile

# If 4k.osz exist, delete it first
if os.path.exists("exports/4k.msp"):
    os.remove("exports/4k.msp")
# Create a zip file
with zipfile.ZipFile("exports/4k.msp", "w") as zip:
    # Loop through the 4K folder
    for root, dirs, files in os.walk("4K"):
        for file in files:
            # Compress the file without the "4K" parent folder
            file_path = os.path.join(root, file)
            arcname = os.path.relpath(file_path, "4K")
            zip.write(file_path, arcname)
