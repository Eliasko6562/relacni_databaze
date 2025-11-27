# IT3 PVY - Návrh vlastní relační databáze

## 🏊 Databáze plaveckých závodů
Relační databáze pro správu plavců, týmů, závodů a soutěžních událostí.

## 📦 Přehled tabulek

### **age_category**
Definuje věkové kategorie používané pro zařazení plavců a závodů.

### **coach**
Ukládá informace o trenérech a přiřazuje je ke konkrétním týmům.

### **discipline**
Obsahuje seznam plaveckých disciplín (např. kraul, motýlek).

### **race**
Reprezentuje jednotlivé rozplavby v rámci soutěžních událostí, včetně disciplíny a věkové kategorie.

### **race_events**
Obsahuje základní informace o událostech, jako je datum, místo a cena.

### **race_swimmer**
Propojuje plavce s konkrétními rozplavbami (vztah mnoho-na-mnoho).

### **swimmer**
Ukládá údaje o plavcích, jejich parametrech a příslušnosti k týmu a věkové kategorii.

### **team**
Reprezentuje týmy v systému, včetně země původu a počtu členů.

## DB Diagram Reference
[https://dbdiagram.io/d/swim-schema-6910ea116735e11170f37690](https://dbdiagram.io/d/swim-schema-6910ea116735e11170f37690)

![swim-schema](<img width="1058" height="482" alt="image" src="https://github.com/user-attachments/assets/40ce78a1-531a-4d63-b17c-9b69a06085f9" />)

