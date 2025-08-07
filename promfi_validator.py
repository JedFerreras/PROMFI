import os

# Define the required filenames for each folder type
REQUIRED_FILES = {
    "family": ["README.md", "index.json", "{folder}.json"],
    "project": ["README.md", "index.json"]
}

def is_family_folder(foldername):
    return foldername.endswith(".00") and foldername[0].isdigit() and foldername[1:5] == "000"

def is_project_folder(foldername):
    return foldername.endswith(".00") and foldername[0:5].isdigit() and not is_family_folder(foldername)

def check_folder(folder_path, folder_type):
    missing_files = []
    foldername = os.path.basename(folder_path)
    for filename in REQUIRED_FILES[folder_type]:
        if "{folder}" in filename:
            filename = filename.replace("{folder}", foldername)
        if not os.path.isfile(os.path.join(folder_path, filename)):
            missing_files.append(filename)
    return missing_files

def scan_directories(root):
    print(f"Scanning PROMFI root: {root}\n")
    for item in os.listdir(root):
        full_path = os.path.join(root, item)
        if os.path.isdir(full_path):
            if is_family_folder(item):
                missing = check_folder(full_path, "family")
                if missing:
                    print(f"[FAMILY] {item} is missing: {missing}")
            elif is_project_folder(item):
                missing = check_folder(full_path, "project")
                if missing:
                    print(f"[PROJECT] {item} is missing: {missing}")
    print("\nValidation complete.")

if __name__ == "__main__":
    scan_directories(os.getcwd())
