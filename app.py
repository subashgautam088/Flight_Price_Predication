import streamlit as st
import pandas as pd
import joblib

# Load model
model = joblib.load('model\\xgb_pipeline_model.pkl')

st.title("✈️ Flight Price Prediction App")

st.markdown("Enter flight details to predict price")

# Inputs
Airline = st.selectbox("Airline", ['IndiGo','Air India','Jet Airways','SpiceJet','Multiple carriers','GoAir'
 'Vistara','Air Asia','Vistara Premium economy','Jet Airways Business',
 'Multiple carriers Premium economy','Trujet'])

Source = st.selectbox("Source", ['Banglore','Kolkata','Delhi','Chennai','Mumbai'])

Destination = st.selectbox("Destination", ['New Delhi','Banglore','Cochin','Kolkata','Delhi','Hyderabad'])

Total_Stops = st.selectbox("Total Stops", [0,1,2,3])

Journey_day = st.slider("Journey Day", 1, 31)
Journey_month = st.slider("Journey Month", 1, 12)
Journey_weekday = st.selectbox("Weekday (0=Mon)", list(range(7)))

Dep_hour = st.slider("Departure Hour", 0, 23)
Dep_min = st.slider("Departure Minute", 0, 59)

Arrival_hour = st.slider("Arrival Hour", 0, 23)
Arrival_min = st.slider("Arrival Minute", 0, 59)

Arrival_Day = st.slider("Arrival Day", 1, 31)

Journey_Diff_Days = st.selectbox("Journey Day Difference", [0,1,2])

Duration_hours = st.slider("Duration Hours", 0, 30)
Duration_minutes = st.slider("Duration Minutes", 0, 59)

Duration_total_mins = Duration_hours * 60 + Duration_minutes

Additional_Info_flag = st.selectbox("Additional Info (0/1)", [0,1])

# Prediction button
if st.button("Predict Price 💰"):

    input_df = pd.DataFrame({
        'Airline': [Airline],
        'Source': [Source],
        'Destination': [Destination],
        'Total_Stops': [Total_Stops],
        'Journey_day': [Journey_day],
        'Journey_month': [Journey_month],
        'Journey_weekday': [Journey_weekday],
        'Dep_hour': [Dep_hour],
        'Dep_min': [Dep_min],
        'Arrival_hour': [Arrival_hour],
        'Arrival_min': [Arrival_min],
        'Arrival_Day': [Arrival_Day],
        'Journey_Diff_Days': [Journey_Diff_Days],
        'Duration_hours': [Duration_hours],
        'Duration_minutes': [Duration_minutes],
        'Duration_total_mins': [Duration_total_mins],
        'Additional_Info_flag': [Additional_Info_flag]
    })

    prediction = model.predict(input_df)

    st.success(f"💸 Estimated Flight Price: ₹ {int(prediction[0])}")