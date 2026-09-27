# nemo-localsend

Nemo file-manager integration for sharing selected files and folders with LocalSend.

## Overview

`nemo-localsend` adds a **Share with LocalSend** action to the Nemo file manager. It allows selected files or folders to be sent directly through LocalSend from Nemo's context menu.

The integration is designed for Linux systems using:

- Nemo file manager
- LocalSend installed through Flatpak
- Bash
- `wmctrl` (optional)

## Features

- Share one or more selected files from Nemo.
- Share folders directly from Nemo.
- Automatically starts LocalSend when it is not running.
- Brings an existing LocalSend window to the foreground when `wmctrl` is available.
- Uses LocalSend's Flatpak application ID.
- Works with Nemo's standard `%F` file-selection mechanism.

## Requirements

### Operating system

Linux with the Nemo file manager.

### LocalSend

LocalSend must be installed as a Flatpak application with the application ID:

```text
org.localsend.localsend_app
```

For example, on Debian/Ubuntu systems with Flatpak configured:

```bash
flatpak install flathub org.localsend.localsend_app
```

### Optional dependency: wmctrl

`wmctrl` is used to bring an already-running LocalSend window to the foreground.

On Debian/Ubuntu:

```bash
sudo apt install wmctrl
```

The integration continues to work without `wmctrl`; in that case, an already-running LocalSend window is not explicitly brought to the foreground.

## Installation

Create the required user directories:

```bash
mkdir -p ~/.local/bin ~/.local/share/nemo/actions ~/.local/share/icons
```

Copy the files from this repository to their corresponding locations:

```text
localsend-nemo.sh
    ~/.local/bin/localsend-nemo.sh

share-with-localsend.nemo_action
    ~/.local/share/nemo/actions/share-with-localsend.nemo_action

localsend.png
    ~/.local/share/icons/localsend.png
```

Make the script executable:

```bash
chmod +x ~/.local/bin/localsend-nemo.sh
```

Restart Nemo so that the new action is loaded:

```bash
nemo -q
```

Nemo will start again automatically when needed.

## Usage

1. Open Nemo.
2. Select one or more files or folders.
3. Open the context menu.
4. Select **Share with LocalSend**.
5. LocalSend will be started if necessary.
6. The selected files or folders are passed to LocalSend.

Multiple selections are supported.

## How it works

The Nemo action uses:

```ini
Exec=~/.local/bin/localsend-nemo.sh %F
```

Nemo expands `%F` into the selected files and folders and passes them to the Bash script.

The script first checks whether the LocalSend Flatpak application is already running:

```bash
pgrep -f "org.localsend.localsend_app"
```

If LocalSend is not running, it is started with:

```bash
flatpak run org.localsend.localsend_app
```

If LocalSend is already running and `wmctrl` is installed, the script attempts to bring the window titled **LocalSend** to the foreground.

Finally, every selected file or folder is passed to LocalSend.

## Project structure

```text
nemo-localsend/
├── localsend-nemo.sh
├── localsend.png
├── share-with-localsend.nemo_action
├── README.md
└── LICENSE
```

### Files

- `localsend-nemo.sh` — Bash launcher and Nemo integration logic.
- `share-with-localsend.nemo_action` — Nemo context-menu action definition.
- `localsend.png` — Custom action icon.
- `README.md` — Project documentation.
- `LICENSE` — MIT license.

## Uninstallation

Remove the installed integration files:

```bash
rm -f ~/.local/bin/localsend-nemo.sh
rm -f ~/.local/share/nemo/actions/share-with-localsend.nemo_action
rm -f ~/.local/share/icons/localsend.png
```

Then restart Nemo:

```bash
nemo -q
```

This does not uninstall LocalSend itself.

## Notes

- The integration does not provide a LocalSend server or networking layer of its own.
- File transfers are handled entirely by LocalSend.
- The script uses the LocalSend Flatpak application ID directly.
- `wmctrl` is optional.
- The integration is intended for user-level installation under `~/.local`.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

## Author

Gonzalo Suarez

## Repository

GitHub: `https://github.com/obi7one/nemo-localsend`
