import sys
import os
from textual.app import App, ComposeResult
from textual.widgets import Header, Footer, Button, Static
from textual.containers import Container

class PulseDiagApp(App):
    """A Textual app for PulseDiag OS menu."""

    BINDINGS = [
        ("q", "quit", "Quit"),
        ("1", "quick_scan", "Quick Scan"),
        ("2", "deep_scan", "Deep Scan"),
    ]

    def compose(self) -> ComposeResult:
        yield Header()
        yield Container(
            Static("[bold green]Welcome to PulseDiag OS![/bold green]", classes="title"),
            Static("Please choose a diagnostic scan to run:", classes="subtitle"),
            Button("Quick Scan", id="quick_scan_button", variant="primary"),
            Button("Deep Scan", id="deep_scan_button", variant="primary"),
            Button("Quit", id="quit_button", variant="error"),
        )
        yield Footer()

    def on_button_pressed(self, event: Button.Pressed) -> None:
        if event.button.id == "quick_scan_button":
            self.action_quick_scan()
        elif event.button.id == "deep_scan_button":
            self.action_deep_scan()
        elif event.button.id == "quit_button":
            self.action_quit()

    def action_quick_scan(self) -> None:
        self.exit("quick_scan")

    def action_deep_scan(self) -> None:
        self.exit("deep_scan")

    def action_quit(self) -> None:
        self.exit("quit")

if __name__ == "__main__":
    app = PulseDiagApp()
    result = app.run()
    sys.exit(result)
