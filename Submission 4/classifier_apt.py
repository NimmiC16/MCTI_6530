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

# APT-level dataset
DATASET_FILE = "processed_dataset/opcode_1gram.csv"
# To test APT-level 2-gram later, change to:
# DATASET_FILE = "processed_dataset/opcode_2gram.csv"

df = pd.read_csv(DATASET_FILE)

X = df.drop(columns=["label", "filename"])
y = df["label"]

print("APT label counts:")
print(y.value_counts())
print()

le = LabelEncoder()
y_encoded = le.fit_transform(y)

X_train, X_test, y_train, y_test = train_test_split(
    X,
    y_encoded,
    test_size=0.2,
    random_state=42
)

os.makedirs("model_outputs_apt", exist_ok=True)

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

    cm = confusion_matrix(y_test, y_pred)

    plt.figure(figsize=(8, 6))
    sns.heatmap(cm, annot=True, fmt="d")
    plt.title(f"{model_name} APT Confusion Matrix")
    plt.xlabel("Predicted")
    plt.ylabel("Actual")
    plt.tight_layout()
    plt.savefig(f"model_outputs_apt/{model_name}_confusion_matrix_apt.png")
    plt.close()

    results.append({
        "Model": model_name,
        "Accuracy": accuracy,
        "Precision": precision,
        "Recall": recall,
        "F1-score": f1
    })

results_df = pd.DataFrame(results)
results_df.to_csv("model_outputs_apt/model_results_summary_apt.csv", index=False)

print("=" * 40)
print("Saved files:")
print("model_outputs_apt/model_results_summary_apt.csv")
print("model_outputs_apt/SVM_confusion_matrix_apt.png")
print("model_outputs_apt/KNN_confusion_matrix_apt.png")
print("model_outputs_apt/Decision_Tree_confusion_matrix_apt.png")