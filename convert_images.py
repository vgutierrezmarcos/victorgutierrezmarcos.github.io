import os
from PIL import Image
import glob

def convert_images():
    base_dir = "/mnt/c/Users/vgutierrez/Documents/src/victorgutierrezmarcos.github.io/oposicion/temario/primer-ejercicio/test/img"
    files = glob.glob(os.path.join(base_dir, "*.png"))
    
    print(f"Found {len(files)} PNG files.")
    
    for file_path in files:
        try:
            img = Image.open(file_path)
            # Create new filename with .webp extension
            new_file_path = os.path.splitext(file_path)[0] + ".webp"
            
            # Save as webp
            img.save(new_file_path, "WEBP")
            print(f"Converted: {os.path.basename(file_path)} -> {os.path.basename(new_file_path)}")
            
            # Optional: Remove original file
            # os.remove(file_path) 
            
        except Exception as e:
            print(f"Error converting {file_path}: {e}")

if __name__ == "__main__":
    convert_images()
