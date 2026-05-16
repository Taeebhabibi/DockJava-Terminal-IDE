# از JDK رسمی (eclipse-temurin)
FROM eclipse-temurin:17-jdk-jammy

# نصب ابزارهای مورد نیاز
RUN apt update && apt install -y git nano curl && apt clean

# محل کار کانتینر
WORKDIR /app

# کپی اسکریپت
COPY java.sh /java.sh

# اجازه اجرا
RUN chmod +x /java.sh

# اجرای اسکریپت هنگام start کانتینر
ENTRYPOINT ["/java.sh"]
