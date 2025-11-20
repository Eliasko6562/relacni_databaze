# IT3 PVY - Návrh vlastní relační databáze
# 🏊 Swim Competition Database
A simple relational database for managing swimmers, teams, events, and race data.

## 📦 Tables Overview

### **age_category**
Defines age groups used to classify swimmers and races.

### **coach**
Stores coach information and links each coach to a specific team.

### **discipline**
Lists swimming disciplines (e.g., freestyle, butterfly).

### **race**
Represents individual races within events, including discipline and age category.

### **race_events**
Contains high-level event info such as date, location, and pricing.

### **race_swimmer**
Maps which swimmers are participating in which races (many-to-many).

### **swimmer**
Stores swimmer personal data, physical attributes, and team/age category.

### **team**
Represents teams participating in the system, including country and member count.
