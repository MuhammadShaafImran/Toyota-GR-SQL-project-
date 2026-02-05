import os
import csv
import time
import requests

from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait, Select
from selenium.webdriver.support import expected_conditions as EC

BASE_URL = "http://usac.alkamelna.com/"

# ----------------------------
# Helpers
# ----------------------------
def safe_mkdir(folder):
    os.makedirs(folder, exist_ok=True)

def download_file(url, folder):
    filename = url.split("/")[-1]
    filepath = os.path.join(folder, filename)

    r = requests.get(url)
    r.raise_for_status()

    with open(filepath, "wb") as f:
        f.write(r.content)

    print("Downloaded:", filename)


# ----------------------------
# Selenium Setup
# ----------------------------
options = webdriver.ChromeOptions()
options.add_argument("--start-maximized")

driver = webdriver.Chrome(options=options)
wait = WebDriverWait(driver, 20)

driver.get(BASE_URL)

# ----------------------------
# Step 1: Select Series = SRO
# ----------------------------
series_dropdown = wait.until(
    EC.presence_of_element_located((By.NAME, "series"))
)
Select(series_dropdown).select_by_value("06_SRO")
time.sleep(2)

# ----------------------------
# Step 2: Select Year = 2025
# ----------------------------
season_dropdown = wait.until(
    EC.presence_of_element_located((By.NAME, "season"))
)
Select(season_dropdown).select_by_visible_text("2025")
time.sleep(2)

# ----------------------------
# Step 3: Select First Event
# ----------------------------
event_dropdown = wait.until(
    EC.presence_of_element_located((By.NAME, "evvent"))
)

event_select = Select(event_dropdown)
events = event_select.options

event_names = [opt.text for opt in event_select.options]

for name in event_names:
    event_dropdown = wait.until(
        EC.presence_of_element_located((By.NAME, "evvent"))
    )
    Select(event_dropdown).select_by_visible_text(name)

    time.sleep(3)

    # ----------------------------
    # Step 4: Extract CSV Links
    # ----------------------------

    all_links = driver.find_elements(By.TAG_NAME, "a")

    csv_links = []
    for a in all_links:
        href = a.get_attribute("href")
        if href and href.lower().endswith(".csv"):
            csv_links.append(href)

    print("Total CSV Found: ", len(csv_links))
    print("Raw csv links: ", csv_links)

    master_csv_path = "output/raw_csv_links.csv"

    with open(master_csv_path, "a", newline="", encoding="utf-8") as f:
        writer = csv.writer(f)
        writer.writerow([f"{name}"])
        for link in csv_links:
            writer.writerow([link])

print("Saved Master List:", master_csv_path)

driver.quit()

print("\nAll Done.")
