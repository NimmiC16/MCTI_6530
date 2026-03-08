import pandas as pd
from sklearn.model_selection import train_test_split
from sklearn.preprocessing import LabelEncoder
from sklearn.svm import SVC
from sklearn.neighbors import KNeighborsClassifier
from sklearn.tree import DecisionTreeClassifier
from sklearn.metrics import classification_report, confusion_matrix, accuracy_score, precision_recall_fscore_support
import matplotlib.pyplot as plt
import seaborn as sns
import os

# Change this to run 1-gram or 2-gram
DATASET_FILE = "processed_dataset/opcode_1gram_country.csv"
# DATASET_FILE = "processed_dataset/opcode_2gram_country.csv"

# Load dataset
df = pd.read_csv(DATASET_FILE)

# Separate features and labels
X = df.drop(columns=["label", "filename"])
y = df["label"]

# Optional: remove labels with less than 2 samples
label_counts = y.value_counts()
valid_labels = label_counts[label_counts >= 2].index
df = df[df["label"].isin(valid_labels)].copy()

X = df.drop(columns=["label", "filename"])
y = df["label"]

print("Label counts used for training/testing:")
print(y.value_counts())
print()

# Encode labels
le = LabelEncoder()
y_encoded = le.fit_transform(y)

# Train-test split
X_train, X_test, y_train, y_test = train_test_split(
    X,
    y_encoded,
    test_size=0.2,
    random_state=42,
    stratify=y_encoded
)

# Output folder for confusion matrices and metrics
os.makedirs("model_outputs", exist_ok=True)

# Models
models = {
    "SVM": SVC(),
    "KNN": KNeighborsClassifier(n_neighbors=3),
    "Decision_Tree": DecisionTreeClassifier(random_state=42)
}

results = []

for model_name, model in models.items():
    print("=" * 40)
    print(f"Model: {model_name}")

    model.fit(X_train, y_train)
    y_pred = model.predict(X_test)

    accuracy = accuracy_score(y_test, y_pred)
    precision, recall, f1, _ = precision_recall_fscore_support(
        y_test,
        y_pred,
        average="weighted",
        zero_division=0
    )

    print(f"Accuracy : {accuracy:.4f}")
    print(f"Precision: {precision:.4f}")
    print(f"Recall   : {recall:.4f}")
    print(f"F1-score : {f1:.4f}")
    print("\nClassification Report:\n")
    print(classification_report(y_test, y_pred, zero_division=0))

    # Save confusion matrix
    cm = confusion_matrix(y_test, y_pred)

    plt.figure(figsize=(8, 6))
    sns.heatmap(
        cm,
        annot=True,
        fmt="d",
        xticklabels=le.classes_,
        yticklabels=le.classes_
    )
    plt.title(f"{model_name} Confusion Matrix")
    plt.xlabel("Predicted")
    plt.ylabel("Actual")
    plt.tight_layout()
    plt.savefig(f"model_outputs/{model_name}_confusion_matrix.png")
    plt.close()

    results.append({
        "Model": model_name,
        "Accuracy": accuracy,
        "Precision": precision,
        "Recall": recall,
        "F1-score": f1
    })

# Save summary table
results_df = pd.DataFrame(results)
results_df.to_csv("model_outputs/model_results_summary.csv", index=False)

print("=" * 40)
print("Saved files:")
print("model_outputs/model_results_summary.csv")
print("model_outputs/SVM_confusion_matrix.png")
print("model_outputs/KNN_confusion_matrix.png")
print("model_outputs/Decision_Tree_confusion_matrix.png")