🚀 Java Docker Terminal IDE
📌 Project Overview

This project is a Docker-based Java development environment that allows users to write, edit, save, and run Java code directly from the terminal without installing JDK on the host system.

It simulates a simple terminal-based IDE inside a Docker container.

⚙️ Features
🆕 Create new Java classes automatically
✍️ Write Java code inside terminal
📝 Edit existing Java classes
▶️ Run Java classes by name
💾 Save command to compile and execute code
⏱️ Tracks code writing time and execution time
🐳 Fully Dockerized (no JDK required on host system)
🧭 How It Works

When the Docker container starts, it shows an interactive menu with the following options:

1️⃣ Create New Class
User enters a class name
System automatically creates a Java file
User starts writing code
2️⃣ Edit Existing Class
User selects this option
System asks for class name
Opens the file for editing
User modifies the code
3️⃣ Run Class
User enters class name
System compiles and runs the Java program
💾 Save Feature (Important)

After writing or editing code, the user must type:

save

Once save is entered:

The code is saved automatically
The Java file is compiled
The program is executed
Execution time and writing time are displayed
4️⃣ Exit
Closes the application safely
⏱️ Timing Feature

The system measures:

📝 Time spent writing code
▶️ Time taken to execute the program

Example output:

Code saved successfully.
Compiling...
Running program...

⏱ Writing time: 3m 10s
⏱ Execution time: 0.6s
🛠️ Tech Stack
🐳 Docker
🐚 Bash / Shell Script
☕ Java (inside container)
🐧 Linux environment
🚀 How to Run
1. Build Docker Image
docker build -t java-terminal-ide .
2. Run Container
docker run -it java-terminal-ide
📁 Project Structure
.
├── Dockerfile
├── start.sh
├── scripts/
│   ├── menu.sh
│   ├── create_class.sh
│   ├── edit_class.sh
│   └── run_class.sh
├── java/
│   └── (user-created classes)
└── README.md
🎯 Purpose of Project

This project was built for:

Learning Docker in real-world scenarios
Practicing Java without local setup
Understanding DevOps workflows
Creating a lightweight terminal-based IDE system
👨‍💻 Author

Taeeb Habibi
