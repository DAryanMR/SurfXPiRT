import subprocess
import tkinter as tk
from tkinter import messagebox
import time


class WiFiScanner:
    def __init__(self, master):
        self.master = master
        master.title("WiFi Scanner")

        self.ssids = []
        self.selected_ssid = tk.StringVar()

        self.scan_button = tk.Button(master, text="Scan", command=self.scan)
        self.scan_button.pack()

        self.ssid_listbox = tk.Listbox(master, listvariable=self.ssids)
        self.ssid_listbox.pack()

        self.password_label = tk.Label(master, text="")
        self.password_label.pack()

        self.password_entry = tk.Entry(master, show='*')
        self.password_entry.pack()

        self.connect_button = tk.Button(
            master, text="Connect", state=tk.DISABLED, command=self.connect)
        self.connect_button.pack()

        # MODIFY THIS PART TO ADD THE AUTO-CONNECT BUTTON
        self.auto_connect_button = tk.Button(
            master, text="Auto-Connect", command=self.auto_connect)
        self.auto_connect_button.pack()

        self.open_ssids = []

        self.ssid_listbox.bind('<<ListboxSelect>>', self.on_select_ssid)

        subprocess.run(["sudo", "ip", "link", "set", "mlan0", "down"])

    def scan(self):
        subprocess.run(["sudo", "rfkill", "unblock", "all"])
        time.sleep(1)
        subprocess.run(["sudo", "ip", "link", "set", "mlan0", "up"])
        self.ssids = []
        output = subprocess.check_output(
            ["sudo", "iw", "dev", "mlan0", "scan"])
        for line in output.splitlines():
            line = line.decode("utf-8")
            if "SSID: " in line:
                ssid = line.split("SSID: ")[1]
                self.ssids.append(ssid)
        self.ssid_listbox.delete(0, tk.END)
        for ssid in self.ssids:
            self.ssid_listbox.insert(tk.END, ssid)
        self.selected_ssid.set("")
        self.password_label.config(text="")
        self.password_entry.delete(0, tk.END)
        self.connect_button.config(state=tk.DISABLED)

    def connect(self):
        ssid = self.selected_ssid.get()
        password = self.password_entry.get()
        if not password and ssid in self.open_ssids:
            subprocess.run(["sudo", "iw", "dev", "mlan0", "connect", ssid])
            messagebox.showinfo("Connection Successful",
                                f"Connected to '{ssid}' without a password")
        elif ssid:
            wpa_supplicant = f'''
#country=US
ctrl_interface=/var/run/wpa_supplicant
ap_scan=1
update_config=1

network={{
    ssid="{ssid}"
    scan_ssid=1
    key_mgmt=WPA-PSK
    psk="{password}"
    priority=1
}}
'''
            with open("/etc/wpa_supplicant/wpa_supplicant.conf", "w") as f:
                f.write(wpa_supplicant)
            try:
                subprocess.run(["sudo", "rm", "-rf", "/var/run/wpa_supplicant/"])
                subprocess.run(["sudo", "wpa_supplicant", "nl80211", "-B", "-i", "mlan0", "-c", "/etc/wpa_supplicant/wpa_supplicant.conf"])                
                # Obtain IP address
                subprocess.run(["sudo", "dhclient", "mlan0"])
                # Store current IP address
                ip_before = subprocess.check_output(['sudo', 'ip', 'addr', 'show', 'mlan0']).decode()
                output = subprocess.check_output(["sudo", "iw", "dev", "mlan0", "link"])
                # Check if IP address has changed
                ip_after = subprocess.check_output(['sudo', 'ip', 'addr', 'show', 'mlan0']).decode()
                if ip_before != ip_after:
                    messagebox.showinfo("Connection Successful",
                                        f"Connected to '{ssid}' with a password")
                else:
                    # Check if the network is reachable
                    #ping_output = subprocess.check_output(["ping", "-c", "1", ssid]).decode()
                    ping_output = subprocess.check_output(["ping", "8.8.8.8"]).decode()
                    if "100% packet loss" in ping_output:
                        messagebox.showerror(
                            "Connection Failed", "Unable to connect to the selected network")
                    else:
                        messagebox.showerror(
                            "Connection Failed", "Incorrect password for the selected network")
            except subprocess.CalledProcessError:
                messagebox.showerror(
                    "Connection Failed", "Unable to connect to the selected network")
        else:
            messagebox.showerror(
                "Connection Failed", "Please select a Wi-Fi network first")
        self.master.destroy()

    def on_select_ssid(self, event):
        selection = event.widget.curselection()
        if selection:
            self.selected_ssid.set(self.ssid_listbox.get(selection))
            my_selection = self.ssid_listbox.get(selection)
            if self.selected_ssid.get():
                self.connect_button.config(state=tk.NORMAL)
                self.open_ssids = []
                output = subprocess.check_output(
                    ["sudo", "iw", "dev", "mlan0", "scan"])
                ssid = ""
                for line in output.splitlines():
                    line = line.decode("utf-8")
                    if "SSID: " in line:
                        ssid = line.split("SSID: ")[1]
                    elif "WPA:" not in line and "RSN:" not in line:
                        self.open_ssids.append(ssid)
                self.password_label.config(text=f"(psk for: {my_selection})") 

    # ADD THIS FUNCTION TO THE CLASS TO HANDLE AUTO-CONNECT FUNCTIONALITY
    def auto_connect(self):
        result = messagebox.askyesno(
            "Confirmation", "Are you sure you want to auto-connect?")
        if result:
            max_attempts = 3
            attempt_count = 0
            while attempt_count < max_attempts:
                try:
                    # Run the custom rc-local
                    subprocess.run(["sudo", "rc-local"])
                    # Obtain IP address
                    #subprocess.run(["sudo", "dhclient", "mlan0"])
                    # Store current IP address
                    ip_before = subprocess.check_output(
                        ['sudo', 'ip', 'addr', 'show', 'mlan0']).decode()
                    output = subprocess.check_output(
                        ["sudo", "iw", "dev", "mlan0", "link"])
                    # Check if IP address has changed
                    ip_after = subprocess.check_output(
                        ['sudo', 'ip', 'addr', 'show', 'mlan0']).decode()
                    if ip_before != ip_after:
                        messagebox.showinfo(
                            "Auto Connect Successful", f"Connected to local network")
                        self.master.destroy()
                        return
                    else:
                        # Check if the network is reachable
                        #ping_output = subprocess.check_output(["ping", "-c", "1", ssid]).decode()
                        ping_output = subprocess.check_output(
                            ["ping", "8.8.8.8"]).decode()
                        if "100% packet loss" not in ping_output:
                            messagebox.showinfo(
                                "Auto Connect Successful", f"Connected to local network")
                            self.master.destroy()
                            return
                except subprocess.CalledProcessError:
                    pass
                
                attempt_count += 1
            
            # If all attempts fail, show an error message
            messagebox.showerror(
                "Connection Failed", "Unable to connect to the local network")
            
            # Close the main window
            self.master.destroy()


root = tk.Tk()
wifi_scanner = WiFiScanner(root)
wifi_scanner.ssid_listbox.bind(
    '<<ListboxSelect>>', wifi_scanner.on_select_ssid)
root.mainloop()
