#!/bin/bash

# Clear the screen for a fresh start
clear

# Welcome Animation
sleep 0.2
echo -e "\e[1;36m###########################################\e[0m"
sleep 0.2
echo -e "\e[1;33m###########   FUNDAMENTAL NEWS AI ###########\e[0m"
sleep 0.2
echo -e "\e[1;36m###########################################\e[0m"
sleep 0.5

# Credits Section
echo -e "\e[1;32m╔════════════════════════════════════════════════════════╗\e[0m"
echo -e "\e[1;32m║ [+] DEVOLPER    : MIR SIYAM                            ║\e[0m"
echo -e "\e[1;32m║ [+] TELEGRAM   : @siyam_official_0                     ║\e[0m"
echo -e "\e[1;32m║ [+] VERSION    : 01:00                                 ║\e[0m"
echo -e "\e[1;32m║ [+] TOOLS      : FUNDAMENTAL NEWS AI                  ║\e[0m"
echo -e "\e[1;32m╚════════════════════════════════════════════════════════╝\e[0m\n"
sleep 0.5

# Login System
echo -e "\e[1;36mEnter Username: \e[0m"
read username
echo -e "\e[1;36mEnter Password: \e[0m"
read -s password

if [[ "$username" != "SIYAM" || "$password" != "SIYAMMALS" ]]; then
    echo -e "\e[1;31mInvalid Username or Password! Exiting...\e[0m"
    exit 1
fi

# Function to fetch news data
fetch_news() {
    local day=$1
    local url="https://alltradingapi.com/news_v2/news_data_v2.js?add_day=${day}"
    
    echo -e "\n\e[1;32mFetching news for Day ${day}...\e[0m"
    sleep 0.5
    response=$(curl -s "$url")

    if [[ $response ]]; then
        echo -e "\e[1;33m┌─────────────────────────────────────────────────────────────────────────────────────────────┐\e[0m"
        echo -e "\e[1;33m│\e[0m\e[1;37m NUM   DATE       TIME     CURRENCY  IMPACT   DESCRIPTION   FORECAST   PREVIOUS   COPY  \e[0m\e[1;33m│\e[0m"
        echo -e "\e[1;33m├─────────────────────────────────────────────────────────────────────────────────────────────┤\e[0m"
        
        # Parse JSON data and format it for output
        echo "$response" | jq -r '.news[] | 
        "\(.id)   \(.date)   \(.time)   \(.currency)   \(.impact)   \(.description)   \(.forecast)   \(.previous)"' |
        while IFS= read -r line; do
            echo -e "\e[1;33m│ \e[0m\e[1;37m$line \e[0m\e[1;33m│ \e[1;36m[Copy]\e[0m\e[1;33m │\e[0m"
        done

        echo -e "\e[1;33m└─────────────────────────────────────────────────────────────────────────────────────────────┘\e[0m"
    else
        echo -e "\e[1;31mFailed to fetch data for Day ${day}.\e[0m"
    fi
}

# Function to fetch predictions
fetch_predictions() {
    local day=$1
    local url="https://alltradingapi.com/news_v2/news_data_v2.js?add_day=${day}"

    echo -e "\n\e[1;35mFetching signal data for Day ${day}...\e[0m"
    sleep 0.5
    response=$(curl -s "$url")
    
    if [[ $response ]]; then
        echo -e "\e[1;35m┌────────────────────────────────────────────────────────────┐\e[0m"
        echo -e "\e[1;35m│\e[0m\e[1;37m PAIR      TIME      DIRECTION    IMPACT      EVENT          \e[0m\e[1;35m│\e[0m"
        echo -e "\e[1;35m├────────────────────────────────────────────────────────────┤\e[0m"
        
        # Parse JSON data for signal information
        echo "$response" | jq -r '.signals[] | 
        "\(.pair)   \(.time)   \(.direction)   \(.impact)   \(.event)"' |
        while IFS= read -r line; do
            # Color coding signals
            impact=$(echo "$line" | awk '{print $4}')
            case $impact in
                High) color="\e[1;31m" ;;  # Red for High
                Medium) color="\e[1;33m" ;; # Yellow for Medium
                Low) color="\e[1;32m" ;;    # Green for Low
                *) color="\e[1;37m" ;;      # White for unknown
            esac
            echo -e "${color}│ \e[0m\e[1;37m$line \e[0m${color}│\e[0m"
        done

        echo -e "\e[1;35m└────────────────────────────────────────────────────────────┘\e[0m"
    else
        echo -e "\e[1;31mFailed to fetch signals for Day ${day}.\e[0m"
    fi
}

# Main Menu
echo -e "\e[1;36mEnter your choice of day (0, 1, 2, or 3):\e[0m"
read choice

# Validate Input and Fetch Data
if [[ "$choice" =~ ^[0-3]$ ]]; then
    fetch_news "$choice"
    fetch_predictions "$choice"
else
    echo -e "\e[1;31mInvalid input! Please enter 0, 1, 2, or 3.\e[0m"
fi

# Closing Message
echo -e "\n\e[1;36m###########################################\e[0m"
echo -e "\e[1;33m   Thank you for using FUNDAMENTAL NEWS AI   \e[0m"
echo -e "\e[1;36m###########################################\e[0m"
