.PHONY: all clean help build-linux build-macos build-windows build-all install test fmt

all: help

build-all: build-linux build-macos build-windows
	@echo ""
	@echo "Build Summary:"
	@ls -lh builds/ 2>/dev/null || echo "No builds directory found"
	@echo ""
	@echo "All builds complete! Binaries are in the 'builds/' directory."

build-linux: builds/pomo-linux-x64 builds/pomo-linux-x86 builds/pomo-linux-arm64

builds/pomo-linux-x64:
	@mkdir -p builds
	GOOS=linux GOARCH=amd64 go build -o $@ main.go

builds/pomo-linux-x86:
	@mkdir -p builds
	GOOS=linux GOARCH=386 go build -o $@ main.go

builds/pomo-linux-arm64:
	@mkdir -p builds
	GOOS=linux GOARCH=arm64 go build -o $@ main.go

build-macos: builds/pomo-macos-x64 builds/pomo-macos-arm64

builds/pomo-macos-x64:
	@mkdir -p builds
	GOOS=darwin GOARCH=amd64 go build -o $@ main.go

builds/pomo-macos-arm64:
	@mkdir -p builds
	GOOS=darwin GOARCH=arm64 go build -o $@ main.go

build-windows: builds/pomo-windows-x64.exe builds/pomo-windows-x86.exe

builds/pomo-windows-x64.exe:
	@mkdir -p builds
	GOOS=windows GOARCH=amd64 go build -o $@ main.go

builds/pomo-windows-x86.exe:
	@mkdir -p builds
	GOOS=windows GOARCH=386 go build -o $@ main.go

clean:
	rm -rf builds/

help:
	@echo "Pomodoro CLI - Cross-platform build system"
	@echo ""
	@echo "Available targets:"
	@echo "  build-all     - Build for all platforms"
	@echo "  build-linux   - Build Linux variants only"
	@echo "  build-macos   - Build macOS variants only"
	@echo "  build-windows - Build Windows variants only"
	@echo "  clean         - Remove all built binaries"
	@echo "  help          - Show this help"
	@echo ""
	@echo "Usage:"
	@echo "  make build-all    # Build everything"
	@echo "  make build-linux  # Build Linux only"
	@echo "  make clean        # Clean builds"
	@echo ""
	@echo "Output binaries will be in the 'builds/' directory."