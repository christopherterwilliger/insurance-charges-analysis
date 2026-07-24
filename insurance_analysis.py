import pandas as pd

# Load the insurance dataset
df = pd.read_csv("insurance.csv")

# Display the first five rows
print("First five rows")
print(df.head())

# Display basic dataset information
print("\nDataset shape:")
print(df.shape)

# Display summary statistics
print("\nSummary statistics:")
print(df.describe())

# Average charges by smoking status
print("\nAverage charges by smoking status:")
smoker_charges = df.groupby("smoker")["charges"].mean()
print(smoker_charges.round(2))

# Average charges by region
print("\nAverage charges by region:")
region_charges = df.groupby("region")["charges"].mean()
print(region_charges.round(2))

# Create age groups
df["age_group"] = pd.cut(
    df["age"],
    bins=[18, 30, 40, 50, 60, 65],
    labels=["18-29", "30-39", "40-49", "50-59", "60+"],
    right=False
)

# Average charges by age group
print("\nAverage charges by age group:")
age_charges = df.groupby("age_group")["charges"].mean()
print(age_charges.round(2))

# Create BMI categories
df["bmi_category"] = pd.cut(
    df["bmi"],
    bins=[0, 18.5, 25, 30, float("inf")],
    labels=["Underweight", "Normal", "Overweight", "Obese"],
    right=False
)

# Average charges by BMI category
print("\nAverage charges by BMI category:")

bmi_charges = df.groupby(
    "bmi_category",
    observed=False
)["charges"].mean()

print(bmi_charges.round(2))

# Average charges by age group and smoking status
print("\nAverage charges by age group and smoking status")
age_smoking_charges = df.groupby(
    ["age_group", "smoker"]
)["charges"].mean()
print(age_smoking_charges.round(2))

# Average charges by BMI category and smoking status

print("\nAverage charges by BMI category and smoking status")
bmi_smoking_charges = df.groupby(
    ["bmi_category", "smoker"]
)["charges"].mean()
print(bmi_smoking_charges.round(2))

# Average charges by number of children

print("\nAverage charges by number of children")
children_charges = df.groupby("children")["charges"].mean()
print(children_charges.round(2))

# Highest and Lowest medical charge

print("\nHighest and Lowest Medical Charges")
highest_charge = df["charges"].max()
lowest_charge = df["charges"].min()
print(f"Highest charge: ${highest_charge:.2f}")
print(f"Lowest charge: ${lowest_charge:.2f}")

# Top 10 Highest Medical Charges

print("\nTop 10 Highest Medical Charges")
top_10 = df.sort_values("charges", ascending=False).head(10)
print(top_10)

# Average medical charge for smokers

print("\nAverage charge for smokers")
smoking_charge = (df[df["smoker"] == "yes"])["charges"].mean()
print(f"Average charge for smokers: ${smoking_charge:.2f}")

# Average medical charge for non-smokers

print("\nAverage charge for non-smokers")
non_smoking_charge = (df[df["smoker"] == "no"])["charges"].mean()
print(f"Average charge for non-smokers: ${non_smoking_charge:.2f}")

# Medical charges greater than $50,000

print("\nMedical Charges greater than $50,000")
charges_50000 = df[df["charges"] > 50000]
print(charges_50000)