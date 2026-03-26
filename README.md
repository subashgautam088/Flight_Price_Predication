# ✈️ Flight Price Prediction using Machine Learning

## 📌 Project Overview

This project focuses on predicting flight ticket prices based on various factors such as airline, journey date, departure time, arrival time, duration, stops, and route information. The goal is to build an end-to-end Machine Learning pipeline and deploy it using Streamlit.

---

## 🎯 Problem Statement

Flight prices vary dynamically based on multiple features. This project aims to:

* Analyze flight data
* Perform feature engineering
* Train ML models
* Predict ticket prices for new data

---

## 📂 Dataset Features

The dataset includes:

* Airline
* Source
* Destination
* Total_Stops
* Journey_day
* Journey_month
* Journey_weekday
* Dep_hour
* Dep_min
* Arrival_hour
* Arrival_min
* Arrival_Day
* Journey_Diff_Days
* Duration_hours
* Duration_minutes
* Duration_total_mins
* Additional_Info_flag
* Price (Target Variable)

---

## ⚙️ Feature Engineering

Performed advanced preprocessing:

* Extracted **hour & minute** from departure and arrival time
* Converted **Date_of_Journey** into day, month, weekday
* Handled **mixed arrival time formats**
* Converted **duration into total minutes**
* Created **Journey_Diff_Days** feature
* Encoded categorical variables using **OneHotEncoding**

---

## 🧠 Machine Learning Models Used

* Random Forest Regressor (Baseline)
* XGBoost Regressor (Final Model)
* LightGBM (for comparison)

---

## 🔄 Pipeline Implementation

Used Scikit-learn Pipeline for:

* Preprocessing (Encoding + Handling missing values)
* Model training
* Prediction on unseen data

---

## 📊 Model Evaluation

* R² Score
* Cross Validation
* Model Comparison (RF vs XGB vs LGBM)

---

## 🚀 Deployment

The model is deployed using **Streamlit**.

### Features of Web App:

* User-friendly UI
* Input flight details
* Predict ticket price instantly

---

## ▶️ How to Run the Project

### 1. Clone Repository

```bash
git clone <https://github.com/subashgautam088/Flight_Price_Predication>
cd project-folder
```

### 2. Install Dependencies

```bash
pip install -r requirements.txt
```

### 3. Run Streamlit App

```bash
streamlit run app.py
```

---

## 💡 Key Learnings

* Feature Engineering is more important than model selection
* Handling datetime data is critical in real-world datasets
* Pipelines simplify ML workflow
* Deployment makes project production-ready

---

## 🔥 Future Improvements

* Hyperparameter tuning
* Feature importance visualization
* Add more real-time data
* Deploy on cloud (Streamlit Cloud / Render)

---

## 📌 Author

**Arun Gautam**

* Data Analyst | Machine Learning Enthusiast
* Skills: SQL, Python, Power BI, Machine Learning

---

## ⭐ Conclusion

This project demonstrates an end-to-end Data Science workflow:
**Data Cleaning → Feature Engineering → Model Building → Deployment**

---

👉 If you like this project, feel free to ⭐ the repository!
