# MIAM Metro Database Management System

## 📋 Project Information

**Project Name**: Metro  
**Project Code**: MIAM  

---

## 👥 Team Members

| Name | Member # |
|------|----------|
| Ahmed Yasin Ashraf Ibrahim Eldsoky | 1 |
| Mohamed Ahmed Qorany Ewis | 2 |
| Mohamed Farag Mohamed Hafez | 3 |

**Supervisor**:  
**Ibrahim Ashraf Abdelraouf Hassan**

---

## 🎯 Problem Statement and Database Importance

### **I. Problem Statement:**

1. **Efficient Metro Operations**:  
   The database could help manage and optimize the operation of the metro system, including information about stations, trains, schedules, and employees.

2. **Passenger Management**:  
   The system may help keep track of passengers, their personal information, travel history, and the types of access methods they use (tickets, cards, subscriptions).

3. **Safety and Accident Management**:  
   With details about safety services, accidents, and occurrences, the database can contribute to the overall safety and security of the metro system. It allows for efficient tracking and resolution of incidents.

4. **Employee Management**:  
   The system provides information about metro employees, including their roles, stations they manage, and their work details.

5. **Financial Transactions**:  
   The database may facilitate financial transactions related to ticket purchases, subscriptions, and other services, contributing to revenue tracking and financial management.

### **II. Importance of Our Database:**

1. **Data Centralization**:  
   The database serves as a central repository for various aspects of the metro system, allowing for organized and centralized data management.

2. **Efficiency and Productivity**:  
   Efficiently managing metro operations and having a comprehensive view of passenger data can contribute to increased efficiency and productivity.

3. **Safety and Incident Response**:  
   The database's ability to store safety-related information facilitates a quick response to incidents, ensuring the safety of passengers and staff.

4. **Strategic Decision-Making**:  
   Access to historical data and real-time information allows metro authorities to make informed decisions, optimize schedules, and improve overall performance.

5. **Customer Experience**:  
   Detailed information about passengers and their preferences enables the metro system to tailor services, improving the overall customer experience.

6. **Regulatory Compliance**:  
   The database can assist in ensuring compliance with regulations, especially in safety and security matters.

7. **Financial Management**:  
   Tracking financial transactions and revenue can contribute to better financial management and planning.

8. **Maintenance and Planning**:  
   Information about trains, stations, and incidents can aid in maintenance planning, ensuring the smooth functioning of the metro system.

---

## 📋 Functional Requirements

### 1. **Passengers and Tickets:**
- How are passenger data recorded? Is there a need to store personal information?
- How are tickets issued? Is there a payment system dealing with cash or credit cards?
- Are there subscription systems for frequent passengers?

### 2. **Stations and Schedules:**
- How is station data stored? Are there geographical location details?
- Are there timetables for train trips? How can this data be efficiently recorded?

### 3. **Employees:**
- How is employee information recorded? Are there different categories of employees?
- How is data about tasks and responsibilities stored?
- Are there schedules for employee patrols or shifts?

### 4. **Safety and Accidents:**
- How can safety and incident data be accurately recorded?
- Are there procedures for tracking emergencies and responding to them?
- Are there periodic reports or analyses of past incidents?

### 5. **Line and Transformation:**
- The system should allow efficient and flexible definition and design of lines, with the ability to set various properties for each line, such as color and type.
- The system should efficiently manage lines, enabling users to add, delete, and modify lines based on their needs.
- The system should provide ease for making transformations on the lines, allowing for easy changes to their direction.

---

## 🛠️ Technical Architecture

### **Database Design:**
- **Enhanced Entity-Relationship (EER) Model**: Illustrates hierarchical relationships, including supertypes like "Person" (subtyped into Manager, Employee, Passenger, Dependent) and entities such as Station, Train, Line, Access_Method, Accident, and Safety_Service.
- **Relational Model**: Maps the EER to a normalized schema with tables like:
  - `Person` (SSN, Fname, Lname, Address, Sex, Bdate, Phone)
  - `Station` (Name, Location, Manager SSN)
  - `Employee` (SSN, Station Name, Salary, Hours)
  - `Access_Method` (Code, Name, Price, Ticket Flag, Date, Card Flag, Type)
  - `Passenger` (SSN, Access Method Code)

### **Implementation:**
- **MySQL Workbench**: Forward engineering of the schema
- **InnoDB Engine**: Transactional support and ACID compliance
- **Cascade Operations**: Maintaining data consistency

---

## 🚀 Getting Started

### **Prerequisites:**
- MySQL Server 8.0+
- MySQL Workbench
- .NET Core (optional for applications)

### **Installation:**
1. Clone the repository
2. Run `create_schema.sql` in MySQL Workbench
3. Insert sample data from `sample_data.sql`
4. Run your application

---

## 📊 Key Entities

| Entity | Description |
|--------|-------------|
| **Person** | Basic person information (SSN, name, address, gender, birthdate, phone) |
| **Station** | Station details (name, location, station manager) |
| **Employee** | Employee information (SSN, station name, salary, working hours) |
| **Access_Method** | Access methods (code, name, price, ticket/card type) |
| **Passenger** | Passenger details (SSN, access method code) |
| **Train** | Train information (number, energy type, timing) |
| **Line** | Line details (number, color, type, number of stations) |
| **Accident** | Accident records (date, location, description, severity) |

---

## 📈 Key Features

### **Operations Management:**
- ✅ Real-time schedule optimization
- ✅ Passenger flow analytics
- ✅ Employee performance tracking
- ✅ Incident response coordination

### **Safety & Security:**
- ✅ Comprehensive incident logging
- ✅ Emergency response protocols
- ✅ Safety service documentation
- ✅ Historical incident analysis

### **Financial Operations:**
- ✅ Ticket and subscription management
- ✅ Revenue tracking
- ✅ Financial reporting
- ✅ Transaction management

---

## 📚 Documentation

- **EER Diagram**: `docs/eer_diagram.pdf`
- **Database Schema**: `docs/schema_documentation.pdf`
- **SQL Scripts**: `database/scripts/`
- **User Manual**: `docs/user_manual.pdf`

---

## 🤝 Contributing

1. Fork the repository
2. Create a new branch (`git checkout -b feature/amazing-feature`)
3. Make your changes
4. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
5. Push to the branch (`git push origin feature/amazing-feature`)
6. Open a pull request

---

## 📄 License

This project is licensed under the [MIT License](LICENSE).

---

## 📞 Contact

For any inquiries about the project, please contact:
- **Email**: [team@metro-project.com](mailto:team@metro-project.com)
- **GitHub Issues**: [Create an Issue](https://github.com/yourusername/metro-miam/issues/new)

---

**© 2025 MIAM Metro Database Team. All rights reserved.**
