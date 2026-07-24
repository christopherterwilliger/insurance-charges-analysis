import pandas as pd
import matplotlib.pyplot as plt

# Load the dataset
df = pd.read_csv("insurance.csv")

# Create a reusable plotting function
def create_bar_chart(data, title, xlabel, ylabel = "Average Charges ($)", figsize=(8,6)):
    plt.figure(figsize=figsize)
    bars = plt.bar(data.index, data.values)

    plt.title(title)
    plt.xlabel(xlabel)
    plt.ylabel(ylabel)
    
    plt.bar_label(bars, fmt="$%.2f")
    plt.show()


# Average charges by smoking status
smoker_charges = df.groupby("smoker")["charges"].mean()

# Create bar chart
create_bar_chart(
    smoker_charges, 
    "Average charges by Smoking Status", 
    "Smoking Status"
)

# Average charges by Region chart
region_charges = df.groupby("region")["charges"].mean()

create_bar_chart(
    region_charges,
    "Average charges by Region",
    "Region"
)

# Average charges by Age Group chart

df["age_group"] = pd.cut(
    df["age"],
    bins=[18, 30, 40, 50, 60, 65],
    labels=["18-29", "30-39", "40-49", "50-59", "60+"],
    right=False
)

age_charges = df.groupby("age_group")["charges"].mean()

create_bar_chart(
    age_charges,
    "Average charges by Age Group",
    "Age Group"
)

# Average charges by BMI category Chart

df["bmi_category"] = pd.cut(
    df["bmi"],
    bins=[0, 18.5, 25, 30, float("inf")],
    labels=["Underweight", "Normal", "Overweight", "Obese"],
    right=False
)

bmi_charges = df.groupby("bmi_category")["charges"].mean()

create_bar_chart(
    bmi_charges,
    "Average charges by BMI category",
    "BMI Category"
)

# Average charges by number of Children

children_charges = df.groupby("children")["charges"].mean()

create_bar_chart(
    children_charges,
    "Average charges by number of Children",
    "Number of Children"
)


    