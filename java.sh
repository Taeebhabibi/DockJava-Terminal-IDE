#!/bin/bash

# ===== رنگ‌ها =====
GREEN="\e[32m"
RED="\e[31m"
YELLOW="\e[33m"
BLUE="\e[34m"
CYAN="\e[36m"
RESET="\e[0m"

# ===== تضمین UTF-8 =====
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# ===== خوش‌آمدگویی =====
clear
echo -e "${CYAN}======================================${RESET}"
echo -e "${CYAN}     ☕ Java Interactive IDE Lab        ${RESET}"
echo -e "${CYAN}======================================${RESET}"
echo -e "${YELLOW}Java Version:${RESET}"
java -version 2>&1 | head -n 1
echo -e "${YELLOW}Date: $(date)${RESET}"
echo "--------------------------------------"

# ===== تابع نوشتن کلاس =====
write_class() {
    while true; do
        read -p "📄 Enter Java class name (no spaces): " CLASS_RAW
        CLASS=$(echo "$CLASS_RAW" | tr -d '\r\n')   # حذف کاراکترهای مخفی
        if [[ -z "$CLASS" || "$CLASS" =~ [[:space:]] ]]; then
            echo -e "${RED}❌ Invalid name. Try again.${RESET}"
        else
            break
        fi
    done

    FILE="$CLASS.java"
    LOG="run.log"

    # اسکلت کلاس اتوماتیک با نام فایل
    cat <<EOF > "$FILE"
public class $CLASS {
    public static void main(String[] args) {

    }
}
EOF

    echo -e "${YELLOW}✍️ Start writing your Java code"
    echo "👉 Type 'save' to finish${RESET}"
    echo "--------------------------------------"

    LINE_COUNT=0
    while true; do
        read LINE
        [[ "$LINE" == "save" ]] && break
        # اضافه کردن خطوط داخل main
        sed -i '/^    }$/i\        '"$LINE" "$FILE"
        ((LINE_COUNT++))
    done

    echo -e "${GREEN}💾 File saved ($LINE_COUNT lines)${RESET}"

    # Compile
    echo -e "${BLUE}⚙️ Compiling...${RESET}"
    START_COMPILE=$(date +%s%N)
    javac "$FILE" 2> compile.err
    END_COMPILE=$(date +%s%N)

    if [ $? -ne 0 ]; then
        echo -e "${RED}❌ Compilation failed:${RESET}"
        cat compile.err
        return
    fi
    COMPILE_TIME=$(( (END_COMPILE - START_COMPILE)/1000000 ))
    echo -e "${GREEN}✅ Compiled in ${COMPILE_TIME} ms${RESET}"

    # Run
    echo -e "${BLUE}🚀 Running program...${RESET}"
    START_RUN=$(date +%s%N)
    java "$CLASS" | tee output.txt
    END_RUN=$(date +%s%N)
    RUN_TIME=$(( (END_RUN - START_RUN)/1000000 ))
    echo -e "${GREEN}⏱️ Execution time: ${RUN_TIME} ms${RESET}"

    # Log
    {
        echo "[$(date)] Class: $CLASS"
        echo "Lines: $LINE_COUNT"
        echo "Compile: ${COMPILE_TIME} ms"
        echo "Run: ${RUN_TIME} ms"
        echo "-------------------------"
    } >> "$LOG"

    # Tip آموزشی کوتاه
    echo -e "${CYAN}💡 Tip: main() method is required for program execution.${RESET}"
}

# ===== منوی اصلی =====
while true; do
    echo
    echo -e "${YELLOW}Select an option:${RESET}"
    echo "1️⃣ Create and run a new class"
    echo "2️⃣ Edit existing class"
    echo "3️⃣ Run existing class"
    echo "4️⃣ Exit"

    read -p "Choose (1-4): " MENU

    case $MENU in
        1)
            write_class
            ;;
        2)
            read -p "Enter class name to edit: " EDIT_RAW
            EDIT_CLASS=$(echo "$EDIT_RAW" | tr -d '\r\n')
            if [[ -f "$EDIT_CLASS.java" ]]; then
                nano "$EDIT_CLASS.java"
                javac "$EDIT_CLASS.java" && java "$EDIT_CLASS"
            else
                echo -e "${RED}❌ File does not exist${RESET}"
            fi
            ;;
        3)
            read -p "Enter class name to run: " RUN_RAW
            RUN_CLASS=$(echo "$RUN_RAW" | tr -d '\r\n')
            if [[ -f "$RUN_CLASS.java" ]]; then
                javac "$RUN_CLASS.java" && java "$RUN_CLASS"
            else
                echo -e "${RED}❌ File does not exist${RESET}"
            fi
            ;;
        4)
            echo -e "${YELLOW}👋 Bye!${RESET}"
            exit 0
            ;;
        *)
            echo -e "${RED}❌ Invalid option${RESET}"
            ;;
    esac
done
