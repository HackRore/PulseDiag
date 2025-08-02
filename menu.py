import tkinter as tk
from tkinter import messagebox
import subprocess
import sys

class PulseDiagGUI(tk.Tk):
    def __init__(self):
        super().__init__()
        self.title("PulseDiag OS")
        self.geometry("400x250")
        self.create_widgets()

    def create_widgets(self):
        # Welcome Label
        self.welcome_label = tk.Label(self, text="Welcome to PulseDiag OS!", font=("Arial", 16, "bold"))
        self.welcome_label.pack(pady=10)

        self.instruction_label = tk.Label(self, text="Please choose a diagnostic scan to run:", font=("Arial", 12))
        self.instruction_label.pack(pady=5)

        # Quick Scan Button
        self.quick_scan_button = tk.Button(self, text="Quick Scan", command=self.run_quick_scan, width=20, height=2)
        self.quick_scan_button.pack(pady=5)

        # Deep Scan Button
        self.deep_scan_button = tk.Button(self, text="Deep Scan", command=self.run_deep_scan, width=20, height=2)
        self.deep_scan_button.pack(pady=5)

        # Quit Button
        self.quit_button = tk.Button(self, text="Quit", command=self.quit_app, width=20, height=2, bg="red", fg="white")
        self.quit_button.pack(pady=10)

    def run_quick_scan(self):
        self.destroy()
        sys.exit("quick_scan")

    def run_deep_scan(self):
        self.destroy()
        sys.exit("deep_scan")

    def quit_app(self):
        self.destroy()
        sys.exit("quit")

if __name__ == "__main__":
    app = PulseDiagGUI()
    app.mainloop()