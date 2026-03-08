import os
import re

dataset_path = "dataset"
processed_data = []
labels = []

def clean_opcode(file_path):
    with open(file_path, "r", errors="ignore") as f:
        content = f.read().lower()
        
        # Remove numbers, addresses, special characters
        content = re.sub(r'[^a-z\s]', ' ', content)
        
        # Remove extra spaces
        content = re.sub(r'\s+', ' ', content)
        
        return content.strip()

# Loop through dataset
for label in os.listdir(dataset_path):
    label_path = os.path.join(dataset_path, label)
    
    if os.path.isdir(label_path):
        for file in os.listdir(label_path):
            if file.endswith(".opcode"):
                file_path = os.path.join(label_path, file)
                
                cleaned = clean_opcode(file_path)
                
                processed_data.append(cleaned)
                labels.append(label)

print("Total samples:", len(processed_data))
print("Example:", processed_data[0])