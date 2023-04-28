# executables and compilers
DARTC = dart
FLUTTERC = flutter
VECTORC = vector_graphics_compiler

# All tasks
all: pub_get assets build_runner flutter_native_splash flutter_launcher_icons

# Compile all assets into vectors
assets: assets/svg/medial_match.vec

assets/svg/medial_match.vec: docs/assets/svg/medial_match.svg
	$(DARTC) run $(VECTORC) -i $< -o $@

# Actions
.PHONY: build_runner
build_runner:
	$(DARTC) run build_runner build

.PHONY: flutter_native_splash
flutter_native_splash:
	$(DARTC) run flutter_native_splash:create

.PHONY: flutter_launcher_icons
flutter_launcher_icons:
	$(DARTC) run flutter_launcher_icons

.PHONY: pub_get
pub_get: pubspec.yaml
	$(DARTC) pub get

.PHONY: precompile_sksl
precompile_sksl:
	echo "Press M to export flutter_01.sksl.json file"
	$(FLUTTERC) run --profile --cache-sksl --purge-persistent-cache --dump-skp-on-shader-compilation

.PHONY: apk_release
apk_release: flutter_01.sksl.json all
	$(FLUTTERC) build apk --obfuscate --split-debug-info=build/app/output/symbols --no-track-widget-creation --release --bundle-sksl-path $< --no-tree-shake-icons