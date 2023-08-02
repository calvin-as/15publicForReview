##trigger Auto-Scale Group 
###replace ip & type in terminal to start python3 trigger.py
import time
import requests
from multiprocessing import Pool

# The URLs of your load balancers
urls = ["http://54.187.28.9"] #,.. 

# The number of parallel requests you want to send
num_requests = 20

# The time between requests (in seconds)
delay = 0.01

def send_request(i):
    url = urls[i % len(urls)]
    while True:
        try:
            response = requests.get(url)
            print(f"Request to {url}, Status Code: {response.status_code}")
        except Exception as e:
            print(f"Request to {url}, failed with {e}")
        time.sleep(delay)

if __name__ == "__main__":
    with Pool(num_requests) as p:
        p.map(send_request, range(num_requests))