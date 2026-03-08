import os
import re
import pandas as pd
from sklearn.feature_extraction.text import CountVectorizer

dataset_path = "dataset"
texts = []
labels = []
filenames = []

country_map = {
    "admin338": "China",
    "APT1": "China",
    "APT3": "China",
    "APT16": "China",
    "APT17": "China",
    "APT19": "China",
    "APT27": "China",
    "APT41": "China",
    "Axiom": "China",
    "BRONZE_BUTLER": "China",
    "Chimera": "China",
    "DeepPanda": "China",
    "Elderwood": "China",
    "GALLIUM": "China",
    "HAFNIUM": "China",
    "Ke3chang": "China",
    "menuPass": "China",
    "Moafee": "China",

    "APT28": "Russia",
    "APT29": "Russia",
    "Dragonfly": "Russia",
    "Dragonfly2": "Russia",
    "FIN5": "Russia",
    "FIN7": "Russia",
    "Gamaredon Group": "Russia",
    "Sandworm": "Russia",
    "TEMPVeles": "Russia",
    "Turla": "Russia",
    "Cobalt Group": "Russia",

    "APT39": "Iran",

    "Patchwork": "India",
    "Sidewinder": "India",

    "BlueMockingBird": "Unknown",
    "DarkVishnya": "Unknown",
    "Evilnum": "Unknown"
}

def clean_opcode(file_path):
    with open(file_path, "r", errors="ignore") as f:
        content = f.read().lower()
        content = re.sub(r'[^a-z\s]', ' ', content)
        content = re.sub(r'\s+', ' ', content)
        return content.strip()

for folder_name in os.listdir(dataset_path):
    folder_path = os.path.join(dataset_path, folder_name)

    if os.path.isdir(folder_path):
        country = country_map.get(folder_name, "Unknown")

        for file in os.listdir(folder_path):
            if file.endswith(".opcode"):
                file_path = os.path.join(folder_path, file)
                cleaned_text = clean_opcode(file_path)

                texts.append(cleaned_text)
                labels.append(country)
                filenames.append(file)

vectorizer_1gram = CountVectorizer(ngram_range=(1, 1))
X_1gram = vectorizer_1gram.fit_transform(texts)

df_1gram = pd.DataFrame(
    X_1gram.toarray(),
    columns=vectorizer_1gram.get_feature_names_out()
)
df_1gram["label"] = labels
df_1gram["filename"] = filenames

vectorizer_2gram = CountVectorizer(ngram_range=(2, 2))
X_2gram = vectorizer_2gram.fit_transform(texts)

df_2gram = pd.DataFrame(
    X_2gram.toarray(),
    columns=vectorizer_2gram.get_feature_names_out()
)
df_2gram["label"] = labels
df_2gram["filename"] = filenames

os.makedirs("processed_dataset", exist_ok=True)
df_1gram.to_csv("processed_dataset/opcode_1gram_country.csv", index=False)
df_2gram.to_csv("processed_dataset/opcode_2gram_country.csv", index=False)

print("1-gram dataset shape:", df_1gram.shape)
print("2-gram dataset shape:", df_2gram.shape)
print("\nCountry label counts:")
print(pd.Series(labels).value_counts())

print("\nSaved files:")
print("processed_dataset/opcode_1gram_country.csv")
print("processed_dataset/opcode_2gram_country.csv")